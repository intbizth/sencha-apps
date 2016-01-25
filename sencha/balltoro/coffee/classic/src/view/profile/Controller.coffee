Ext.define 'Toro.view.profile.Controller',
    extend: 'Toro.view.base.Controller'
    alias: 'controller.ctrl-profile'

    init: -> #..

    createDialog: (record) ->
        model = @referTo('ProfileList').getStore().getModel()
        userRecord = if record then record.get 'user' else Ext.create 'Toro.model.User'
        @dialog = @getView().add
            xtype: 'wg-profile-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('first_name') else 'เพิ่มประวัติใหม่'
                    profile: record || new model()
                    user: userRecord || record.getUser()

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

    onEdit: ->
        list = @referTo 'ProfileList'
        record = list.getSelection()[0]
        @createDialog record

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'ProfileList'
                    list.mask('Deleting...')

                    profileRecord = list.getSelection()[0]
                    store = list.getStore()

                    # for fix association and cascade.
                    profileRecord.drop(no)
                    profileRecord.erasing = no
                    profileRecord.save
                        success: =>
                            list.unmask()
                            @alertSuccess('ลบประวัติเรียบร้อยแล้วค่ะ')
                        failure: =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบประวัติ กรุณาลองใหม่อีกครั้งค่ะ')

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'

        profileRecord = @dialog.getViewModel().get 'profile'
        profilesStore = @referTo('ProfileList').getStore()

        userRecord = @dialog.getViewModel().get 'user'
        usersStore = Ext.getStore('users-store')

        isNewRecord = profileRecord.phantom

        if isNewRecord
            userData = userRecord.getData()
        else
            userData = userRecord.getChanges()

        if userData.hasOwnProperty('id')
            delete userData['id']

        profileRecord.set 'user', userData

        if form.isValid() and profileRecord.dirty
            form.mask('Submitting..')

            profileRecord.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการประวัติ กรุณาลองใหม่อีกครั้งค่ะ'

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
                    form.unmask()

                    if isNewRecord
                        profilesStore.add rec
                        profilesStore.commitChanges()

                        usersStore.add rec.get 'user'
                        usersStore.commitChanges()
                        @alertSuccess('เพิ่มผู้ใช้ระบบเรียบร้อยแล้ว')

                    else
                        @alertSuccess('แก้ไขผู้ใช้ระบบเรียบร้อยแล้ว')

                    @dialog.close()
        else
            @dialog.close()

    onPlainPasswordBeforeRender: (field) ->
        userRecord = @dialog.getViewModel().get 'user'

        if !userRecord.phantom
            field.setVisible no
