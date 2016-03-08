Ext.define 'Vcare.view.taxon.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-taxon'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
           return 'เพิ่มรายการใหม่'
        else "แก้ไข " + r.getName()

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        console.log(record)
        console.log(record)

        @dialog = @getView().add
            xtype: 'wg-taxon-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-taxon-form'
                data:
                    title:  @createDialogTitle(record)
                    record: record
                    currentLocale: 'en_US'

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('TaxonList').getSelection()[0]

    onSubmit: ->
        vm = @dialog.getViewModel()
        form = @dialog.down 'form'
        record = vm.get 'record'

        if !(form.isValid() && vm.isDirty())
            @dialog.close()
            return

        form.mask('กำลังบันทึกข้อมูล ..')

        record.save
            failure: (record, o) =>
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

            success: (record, o) =>
                form.unmask()
                @reloadStore('taxons')

                if record.phantom
                    @alertSuccess('เพิ่มผู้ใช้ระบบเรียบร้อยแล้ว')
                else
                    @alertSuccess('แก้ไขผู้ใช้ระบบเรียบร้อยแล้ว')

                vm.commit()

                @dialog.close()
