Ext.define 'Vcare.view.tax.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-tax'

    init: -> #..


    # @private
    createDialogTitle: (r) ->
        if r.phantom
           return 'เพิ่มใหม่'
        else r.get 'code'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-tax-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-tax-form'
                data:
                    title:  @createDialogTitle record
                    record: record
                    hasCode: record.get 'code'

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('TaxList').getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'TaxList'
                    list.mask('Deleting...')

                    record = list.getSelection()[0]
                    store = list.getStore()

                    # for fix association and cascade.
                    record.drop(no)
                    record.erasing = no
                    record.save
                        success: =>
                            list.unmask()
                            @alertSuccess('ลบภาษาเรียบร้อย')
                        failure: =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบภาษา กรุณาลองใหม่อีกครั้งค่ะ')

    onSubmit: ->
        vm = @dialog.getViewModel()
        form = @dialog.down 'form'
        record = vm.get 'record'

        if !(form.isValid() && vm.isDirty())
            @reloadStore('taxs')
            @dialog.close()
            return

        form.mask('กำลังบันทึกข้อมูล ..')

        record.save
            failure: (record, o) =>
                form.unmask()

                titleMessage = 'ผิดพลาด'
                errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดภาษา กรุณาลองใหม่อีกครั้งค่ะ'

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
                        errorMessage = 'Sorry, validation errors.'
#                        Ext.Object.each obj.errors.children, (key, value, item) ->
#                            if value.hasOwnProperty('errors')
#                                errorMessage = value.errors[0]

                @alertFailure
                    title: titleMessage
                    message: errorMessage

            success: (record, o) =>
                form.unmask()

                @reloadStore('taxs')
                @alertSuccess('เพิ่มภาษาเรียบร้อยแล้ว')

                vm.commit()

                @dialog.close()
