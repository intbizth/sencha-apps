Ext.define 'Vcare.view.taxon.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-taxon'

    currentStore: null
    isPhantom: yes

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
           return 'เพิ่มรายการใหม่'
        else "แก้ไข " + r.getName()

    # @private
    closeDialog: -> @dialog.close()

    # @private
    createDialog: (record, type) ->
        @isPhantom = !!record
        vm = @getViewModel()
        record = vm.prepareData(record, type)

        console.log record
        console.log record

        switch type
            when 'brand' then @currentStore = 'brands'
            else @currentStore = 'categories'

        @dialog = @getView().add
            xtype: 'wg-taxon-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-taxon-form'
                data:
                    type: type
                    title:  @createDialogTitle(record)
                    record: record
                    currentLocale: 'en_US'
                    parents: vm.getStore(@currentStore)

        @dialog.show()

    onCancel: -> @closeDialog()
    onAddNew: -> @createDialog null, btn.up('grid').getTaxonType()
    onEdit: (btn) ->
        grid = btn.up('grid')
        @createDialog grid.getSelection()[0], grid.getTaxonType()

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
                @reloadStore(@currentStore)

                if @isPhantom
                    @alertSuccess('เพิ่มผู้ใช้ระบบเรียบร้อยแล้ว')
                else
                    @alertSuccess('แก้ไขผู้ใช้ระบบเรียบร้อยแล้ว')

                vm.commit()

                @closeDialog()
