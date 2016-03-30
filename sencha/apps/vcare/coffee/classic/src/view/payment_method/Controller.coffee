Ext.define 'Vcare.view.payment_method.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-payment-method'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.getName()}"
        record = vm.createRecord(record)

        console.log record
        console.log record
        console.log record

        options =
            xtype: 'wg-payment-method-form'
            title:  title
            viewModel:
                type: 'vm-payment-method-form'
                data:
                    record: record

        @callParent([record, options])
