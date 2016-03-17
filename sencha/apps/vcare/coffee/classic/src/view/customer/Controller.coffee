Ext.define 'Vcare.view.customer.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-customer'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.getUser() && record.getUser().get('username')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-customer-form'
            title:  title
            viewModel:
                type: 'vm-customer-form'
                data:
                    record: record

        @callParent([record, options])

    onManageGroup: ->
        @getView().add(xtype: 'wg-group-form').show()
