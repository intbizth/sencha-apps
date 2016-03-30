Ext.define 'Vcare.view.channel.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-channel'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.createRecord(record)

        console.log record
        console.log record
        console.log record

        options =
            xtype: 'wg-channel-form'
            title:  title
            viewModel:
                type: 'vm-channel-form'
                data:
                    record: record

        @callParent([record, options])
