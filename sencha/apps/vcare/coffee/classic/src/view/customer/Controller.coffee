Ext.define 'Vcare.view.customer.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-customer'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
           return 'เพิ่มประวัติใหม่'
        else r.getUser().get 'displayname'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)
        console.log record

        @dialog = @getView().add
            xtype: 'wg-customer-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-customer-form'
                data:
                    title:  @createDialogTitle record
                    record: record

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('CustomerList').getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'CustomerList'
                    list.mask('Deleting...')

                    record = list.getSelection()[0]
                    store = list.getStore()

                    # for fix association and cascade.
                    record.drop(no)
                    record.erasing = no
                    record.save
                        success: =>
                            list.unmask()
                            @alertSuccess('ลบประวัติเรียบร้อยแล้วค่ะ')
                        failure: =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบประวัติ กรุณาลองใหม่อีกครั้งค่ะ')

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
                errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการประวัติ กรุณาลองใหม่อีกครั้งค่ะ'

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
                    @alertSuccess('เพิ่มผู้ใช้ระบบเรียบร้อยแล้ว')
                else
                    @alertSuccess('แก้ไขผู้ใช้ระบบเรียบร้อยแล้ว')

                @dialog.close()

