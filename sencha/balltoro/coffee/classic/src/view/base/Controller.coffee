Ext.define 'Toro.view.base.Controller',
    extend: 'Ext.app.ViewController'

    setCurrentView: (view, itemId, params) ->
        contentPanel = @getView().down '#' + itemId

        if !contentPanel || view == '' || (contentPanel.down() && contentPanel.down().xtype == view)
            return no

        if params && params.openWindow
            cfg = Ext.apply
                xtype: 'ux-base-window'
                items: [
                    Ext.apply
                        xtype: view,
                        params.targetCfg
                ],
                params.windowCfg

            Ext.create cfg
        else
            Ext.suspendLayouts()

            contentPanel.removeAll yes
            contentPanel.add(
                Ext.apply
                    xtype: view,
                    params
            )

            Ext.resumeLayouts yes

    createMessageBox: ->
        Ext.create
            xtype: 'messagebox'

    alertSuccess: (options) ->
        if Ext.isString options
            options = message: options
            options.title = 'สำเร็จ'

        if !options.icon
            options.icon = Ext.Msg.INFO

        if !options.buttons
            options.buttons = Ext.Msg.OK

        msg = @createMessageBox()
        msg.alert options

    alertFailure: (options) ->
        if Ext.isString options
            options = message: options
            options.title = 'ผิดพลาด !'

        if !options.icon
            options.icon = Ext.Msg.ERROR

        if !options.buttons
            options.buttons = Ext.Msg.OK

        msg = @createMessageBox()
        msg.alert options

    showConfirmMessage: (options, func) ->
        if Ext.isString options
            options = message: options

        if !options.title
            options.title = 'Confirm ?'

        if !options.icon
            options.icon = Ext.Msg.QUESTION

        if !options.buttons
            options.buttons = Ext.Msg.OKCANCEL

        if Ext.isObject func
            func.scope = @
            options.fn = (pressed) =>
                options.fn.call func.scope, pressed

        msg = @createMessageBox()
        msg.show options

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

    setDateTimeInRecord: (originDate, date, time) ->
        if date?
            _date = Ext.Date.format(date, 'Y-m-d')

            if originDate?
                _time = Ext.Date.format(originDate, 'H:i:s')
            else
                _time = '00:00:00'

            date = Ext.Date.parse(_date + ' ' + _time, 'Y-m-d H:i:s')
        else
            date = originDate

        if time?
            date = Ext.Date.format(date, 'Y-m-d')
            dateTime = date + ' ' + Ext.Date.format(time, 'H:i:s')
            date = Ext.Date.parse dateTime, 'Y-m-d H:i:s'

        return date

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
