Ext.define 'Moboque.view.emergency-call.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-emergency-call'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-emergency-call-form'
            title:  title
            viewModel:
                type: 'vm-emergency-call-form'
                data:
                    record: record

        @callParent([record, options])
