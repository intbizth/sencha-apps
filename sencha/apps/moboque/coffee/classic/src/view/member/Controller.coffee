Ext.define 'Moboque.view.member.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-member'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มข้อมูลสมาชิก'
        else r.get 'fullname'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-member-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-member-form'
                data:
                    title: @createDialogTitle record
                    record: record

            listeners:
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

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('MemberList').getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'MemberList'
                    list.mask('Deleting..')

                    memberRecord = list.getSelection()[0]
                    store = list.getStore()

                    # for fix association and cascade.
                    # for fix association and cascade.
                    memberRecord.drop(no)
                    memberRecord.erasing = no
                    memberRecord.save
                        success: =>
                            list.unmask()
                            @alertSuccess('ลบประวัติเรียบร้อยแล้วค่ะ')
                        failure: =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบข้อมูล กรุณาลองใหม่อีกครั้งค่ะ')

    onSubmit: ->
        vm = @dialog.getViewModel()

        form = @dialog.down 'form'
        record = vm.get 'record'

        if !(form.isValid() && vm.isDirty())
            @dialog.close()
            return

        form.mask('กำลังบันทึกข้อมูล ..')

        record.save
            failure: (rec, o) =>
                form.unmask()

                titleMessage = 'ผิดพลาด'
                errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการข้อมูล กรุณาลองใหม่อีกครั้งค่ะ'

                if response = o.error.response
                    # internal server error
                    if response.status == 500
                        titleMessage = response.statusText
                        errorMessage = 'Sorry, something went wrong.'

                    # sf validation error.
                    # TODO: handle form error with custom fn.
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
                vm.commit()
                form.unmask()

                if record.phantom
                    @alertSuccess('เพิ่มข้อมูลสมาชิกเรียบร้อยแล้ว')
                else
                    @alertSuccess('แก้ไขข้อมูลสมาชิกเรียบร้อยแล้ว')

                @dialog.close()
