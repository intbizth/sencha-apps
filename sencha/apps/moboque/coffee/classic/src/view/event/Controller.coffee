Ext.define 'Moboque.view.event.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-event'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-event-form'
            title:  title
            viewModel:
                type: 'vm-event-form'
                data:
                    record: record

        @callParent([record, options])
