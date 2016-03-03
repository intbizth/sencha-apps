Ext.define 'Moboque.view.promote.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มกลุ่ม'
        else r.get 'name'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-promote-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-promote-form'
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
    onEdit: -> @createDialog @referTo('PromoteList').getSelection()[0]

    onDelete: -> @baseDelete('PromoteList')

    onSubmit: ->
        vm = @dialog.getViewModel()

        form = @dialog.down 'form'
        record = vm.get 'record'
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
                    # TODO: เปลี่ยนเป็นแบบนี้
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
                    @alertSuccess('เพิ่มข้อมูลกลุ่มเรียบร้อยแล้ว')
                else
                    @alertSuccess('แก้ไขข้อมูลกลุ่มเรียบร้อยแล้ว')
                    console.log record

                @dialog.close()
