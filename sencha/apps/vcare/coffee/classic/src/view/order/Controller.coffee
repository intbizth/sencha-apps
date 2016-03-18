Ext.define 'Vcare.view.order.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-order'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.getUser() && record.getUser().get('username')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-order-form'
            title:  title
            viewModel:
                type: 'vm-order-form'
                data:
                    record: record

        @callParent([record, options])
