Ext.define 'Moboque.view.district.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-district'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มข้อมูลอำเภอ'
        else r.get 'name'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-district-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-district-form'
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
    onEdit: -> @createDialog @referTo('DistrictList').getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'DistrictList'
                    list.mask('Deleting..')

                    memberRecord = list.getSelection()[0]
                    store = list.getStore()

                    memberRecord.erase
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
        list = @referTo 'DistrictList'
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
                        errorMessage = 'Validation error.'

                        Ext.Object.each obj.errors.children, (key, value, item) ->
                            if value.hasOwnProperty('errors')
                                errorMessage = value.errors[0]

                @alertFailure
                    title: titleMessage
                    message: errorMessage

            success: (rec, o) =>
                vm.commit()
                form.unmask()

                if isPhantom
                    @alertSuccess('เพิ่มข้อมูลสมาชิกเรียบร้อยแล้ว')
                    store.add(record)
                else
                    @alertSuccess('แก้ไขข้อมูลสมาชิกเรียบร้อยแล้ว')

                @dialog.close()
