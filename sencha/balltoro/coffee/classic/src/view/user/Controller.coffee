Ext.define 'Toro.view.user.Controller',
    extend: 'Toro.view.base.Controller'
    alias: 'controller.ctrl-user'

    init: -> #..

    createDialog: (record) ->
        model = @referTo('UserList').getStore().getModel()
        @dialog = @getView().add
            xtype: 'wg-user-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('username') else 'สร้างผู้ใช้ระบบใหม่'
                    user: record || new model()

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                beforeclose: (panel, eOpts) =>
                    if record and record.dirty
                        @showConfirmMessage
                            title: 'ข้อมูลมีการเปลี่ยนแปลง'
                            message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                            fn: (pressed) =>
                                if pressed == 'ok'
                                    record.store.rejectChanges()
                                    @dialog.close()

                        return no

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    onAddNew: -> @createDialog()

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-user-search'
            viewModel:
                data:
                    title: 'ค้นหาขั้นสูง'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('UserList').getStore()
        searchFieldValues = searchForm.getForm().getFieldValues(yes)

        if !Ext.Object.isEmpty searchFieldValues
            filters = {}

            # search
            if searchFieldValues.hasOwnProperty('search')
                filters['search'] = searchFieldValues['search']
                delete searchFieldValues['search']

            # criteria
            filters['criteria'] = searchFieldValues

            store.load
                params: filters

            @dialog.close()
            return

        @showConfirmMessage
            title: 'ค้นหา'
            message: 'คุณยังไม่ได้ระบุตัวเลือกการค้นหา ออกจากหน้า Advanced Search หรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    @dialog.close()

    onEdit: ->
        list = @referTo 'UserList'
        record = list.getSelection()[0]
        @createDialog record

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'UserList'
                    records = list.getSelection()
                    store = list.getStore()

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            @alertSuccess('ลบผู้ใช้งานระบบเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบผู้ใช้งานระบบ กรุณาลองใหม่อีกครั้งค่ะ')

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'user'
        store = @referTo('UserList').getStore()
        isNewRecord = record.phantom

        if newPassword = form.getForm().findField('password').getValue()
            record.set 'plainPassword', newPassword

        if form.isValid() and record.dirty
            loading = @createLoadMask(form, 'Submitting...')
            loading.show()

            record.save
                failure: (rec, o) =>
                    loading.hide()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการผู้ใช้งานระบบ กรุณาลองใหม่อีกครั้งค่ะ'

                    if response = o.error.response
                        # internal server error
                        if response.status == 500
                            titleMessage = response.statusText
                            errorMessage = 'Sorry, something went wrong.'

                        # sf validation error.
                        if response.status == 400
                            obj = Ext.decode response.responseText
                            titleMessage = obj.message

                            Ext.Object.each obj.errors.children, (key, value, item) ->
                                if value.hasOwnProperty('errors')
                                    errorMessage = value.errors[0]

                    @alertFailure
                        title: titleMessage
                        message: errorMessage

                success: (rec, o) =>
                    loading.hide()

                    if isNewRecord
                        store.add rec
                        store.commitChanges()
                        @alertSuccess('เพิ่มผู้ใช้ระบบเรียบร้อยแล้ว')

                    else
                        @alertSuccess('แก้ไขผู้ใช้ระบบเรียบร้อยแล้ว')

                    @dialog.close()
        else
            @dialog.close()
