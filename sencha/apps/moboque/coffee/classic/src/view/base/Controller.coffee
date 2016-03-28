Ext.define 'Moboque.view.base.Controller',
    extend: 'Ext.app.ViewController'

    dialog: null

    config:
        successMessage: "การทำรายการเสร็จเรียบร้อยแล้ว"
        failureMessage: "เกิดความผิดพลาด กรุณาลองใหม่อีกครั้ง"
        confirmMessage: "กรุณายืนยันการทำรายการ"

    # @private
    createMessageBox: ->
        Ext.create
            xtype: 'messagebox'

    # @protected
    successAlert: (options) ->
        options = @getSuccessMessage() if !options

        if Ext.isString options
            options = message: options
            options.title = 'Successful!'

        if !options.icon
            options.icon = Ext.Msg.INFO

        if !options.buttons
            options.buttons = Ext.Msg.OK

        @createMessageBox().alert options

    # @protected
    failureAlert: (options) ->
        options = @getFailureMessage() if !options

        if Ext.isString options
            options = message: options
            options.title = 'Error!'

        if !options.icon
            options.icon = Ext.Msg.ERROR

        if !options.buttons
            options.buttons = Ext.Msg.OK

        @createMessageBox().alert options

    # @protected
    confirmAlert: (options, callback, scope) ->
        if Ext.isFunction(options)
            scope = callback
            callback = options
            options = null

        options = @getConfirmMessage() if !options

        if Ext.isString options
            options = message: options

        if !options.title
            options.title = 'Confirm?'

        if !options.icon
            options.icon = Ext.Msg.QUESTION

        if !options.buttons
            options.buttons = Ext.Msg.OKCANCEL

        if Ext.isFunction callback
            options.fn = (pressed) ->
                callback.call (scope || @), pressed

        @createMessageBox().show options

    # @protected
    getDialogViewModel: -> @dialog.getViewModel()

    # @protected
    getDialogRecord: (key) -> @getDialogViewModel().get(key || 'record')

    # @protected
    getDialogForm: (key) -> @dialog.down('form')

    # @protected
    closeDialog: -> @dialog.close()

    # @protected MUST be overrided!
    createDialog: (record, options) ->
        @dialog = @getView().add(Ext.apply(
            title: 'Hello World!'
            ownerView: @getView()
            widgetRecord: record
        ,
            options || {}
        ))

        @dialog.show()

    # @protected
    onCancel: ->
        @dialog.getViewModel().beforeCancel(
            @dialog.getWidgetRecord()
        )

        @closeDialog()

    # @protected
    onAddNew: (btn) -> @createDialog()

    # @protected
    onEdit: (btn) -> @createDialog(btn.getSingleWidgetRecord())

    # @protected
    onDelete: (btn) ->
        @confirmAlert "กรุณายืนยันการลบรายการ", (pressed) =>
            return if pressed != 'ok'

            record = btn.getSingleWidgetRecord()
            grid = btn.up('grid')
            store = grid.getStore()

            grid.mask("กำลังลบรายการ ...")
            store.remove([record])

            store.sync
                failure: (record, o) =>
                    grid.unmask()
                    store.rejectChanges()
                    @failureAlert('เกิดความผิดพลาด ในการลบข้อมูล')

                success: (record, o) =>
                    grid.unmask()
                    @successAlert('ลบข้อมูลเรียบร้อยแล้ว')

    # @protected
    onSubmit: ->
        vm = @dialog.getViewModel()
        form = @dialog.down 'form'
        record = vm.get 'record'

        vm.beforeSubmit(record, form)

        if !(form.isValid() && vm.isDirty())
            @dialog.close()
            return

        form.mask('กำลังบันทึกข้อมูล ..')

        record.save
            failure: (record, o) =>
                form.unmask()
                vm.onSubmitFailure(record, form)

                if response = o.error.response
                    # internal server error
                    if response.status == 500
                        titleMessage = response.statusText

                    # sf validation error.
                    # TODO: handle form error with custom fn.
                    if response.status == 400
                        obj = Ext.decode response.responseText
                        titleMessage = obj.message

                        Ext.Object.each obj.errors.children, (key, value, item) ->
                            if value.hasOwnProperty('errors')
                                errorMessage = value.errors[0]

                @failureAlert
                    title: titleMessage || "Error!"
                    message: errorMessage || @getFailureMessage()

            success: (record, o) =>
                form.unmask()

                vm.onSubmitSuccess(record, form)
                vm.commit()

                @successAlert(@getSuccessMessage())
                @closeDialog()


    # ++++++ TODO: Refatoring ++++++
    # ++++++++++++++++++++++++++++++
    createTransitionMenu: (items, handler) ->

        if !items
            return

        menuItems = []

        if Ext.isString items
            items = [items]

        if Ext.isObject items
            Ext.Object.each items, (key, value, item) ->
                menuItems.push
                    text: value
                    value: key
                    handler: handler

        if !Ext.isEmpty menuItems
            menu = Ext.create
                xtype: 'menu'
                items: menuItems

    manageFiles: (form, fieldname) ->
        field = form.getForm().findField(fieldname)
        oldValue = field.getRawValue()
        input =  field.extractFileInput()

        if !field.getRawValue()
            field.setRawValue(oldValue)

        return input

    createLoadMask: (panel, message) ->
        if !Ext.isString message
            message = 'Please wait...'

        return Ext.create
            xtype: 'loadmask'
            msg: message
            target: panel

    enabledState: (listname, fieldname, tran, refbutton) ->
        # listname เช่น 'NewsList'
        # fieldname เช่น 'hottest'
        # message เช่น 'ข่าวร้อน'
        # refbutton เช่น 'HottestButton'

        list = @referTo listname
        records = list.getSelection()
        store = list.getStore()
        loading = @createLoadMask(list, 'Updating...')

        if records.length == 1 and records[0].get(fieldname)
            @showConfirmMessage
                title: 'ยืนยัน !'
                message: 'ลบรายการนี้จาก' + tran + ' คุณแน่ใจหรือไม่ ?',
                fn: (pressed) =>
                    if pressed == 'ok'
                        loading.show()

                        store.enabledStates records, no, fieldname,
                            success: (records, response, opts) =>
                                Ext.each records, (record) ->
                                    record.set fieldname, no
                                    record.commit()

                                @referTo(refbutton).toggle no
                                loading.hide()
                                @alertSuccess('ลบรายการ' + tran + 'เรียบร้อยแล้วค่ะ')

                            failure: (records, response, opts) =>
                                loading.hide()
                                @alertFailure('ขออภัย! กรุณาลองใหม่อีกครั้งค่ะ')
            return

        @showConfirmMessage
            title: 'ยืนยัน !'
            message: 'เลือกรายการนี้เป็น' + tran + ' คุณแน่ใจหรือไม่ ?',
            fn: (pressed) =>
                if pressed == 'ok'
                    loading.show()

                    store.enabledStates records, yes, fieldname,
                        success: (records, response, opts) =>
                            Ext.each records, (record) ->
                                record.set fieldname, yes
                                record.commit()

                            @referTo(refbutton).toggle yes
                            loading.hide()
                            @alertSuccess('เปลี่ยนแปลง' + tran + 'เรียบร้อยแล้วค่ะ')

                        failure: (records, response, opts) =>
                            loading.hide()
                            @alertFailure('ขออภัย! กรุณาลองใหม่อีกครั้งค่ะ')

    # fieldnames เช่น ['competition', 'season', 'tags']
    checkStoreLoaded: (record, fieldnames) ->
        form = @dialog.down 'form'

        loading = @createLoadMask(form)
        loading.show()

        loaded = yes
        count = 0

        Ext.each fieldnames, (name) ->
            combofield = form.getForm().findField(name)
            store = combofield.getStore()

            store.on
                load:
                    fn: (store, record, success) ->
                        count++

                        if !success
                            loaded = no

                        if count == fieldnames.length and success
                            loading.hide()

                    scope: @
                    single: yes

    findFieldInForm: (fieldname) ->
        form = @dialog.down 'form'
        return form.getForm().findField(fieldname)

    enabledButtonWithSelection: (ref, value) ->
        button = @referTo(ref)
        button.setDisabled(value)
