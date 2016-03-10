Ext.define 'Moboque.view.personal-department.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-personal-department'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มแผนก'
        else r.get 'title'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-personal-department-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-personal-department-form'
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
    onEdit: -> @createDialog @referTo('PersonalDepartmentList').getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'PersonalDepartmentList'
                    list.mask('Deleting..')

                    personalDepartmentRecord = list.getSelection()[0]
                    store = list.getStore()

                    personalDepartmentRecord.erase
                        success: =>
                            list.unmask()
                            @alertSuccess('ลบข้อมูลเรียบร้อยแล้วค่ะ')
                        failure: =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบข้อมูล กรุณาลองใหม่อีกครั้งค่ะ')

    onSubmit: ->
        vm = @dialog.getViewModel()

        form = @dialog.down 'form'
        record = vm.get 'record'
        list = @referTo 'PersonalDepartmentList'
        store = list.getStore()
        isPhantom = record.phantom

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
                        errorMessage = 'Validation Error.'

                @alertFailure
                    title: titleMessage
                    message: errorMessage

            success: (rec, o) =>
                vm.commit()
                form.unmask()

                if isPhantom
                    @alertSuccess('เพิ่มข้อมูลแผนกเรียบร้อยแล้ว')
                    store.add(record)
                else
                    @alertSuccess('แก้ไขข้อมูลแผนกเรียบร้อยแล้ว')

                @dialog.close()
