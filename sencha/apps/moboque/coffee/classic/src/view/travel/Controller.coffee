Ext.define 'Moboque.view.travel.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-travel'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-travel-form'
            title: title
            viewModel:
                type: 'vm-travel-form'
                data:
                    record: record

        @callParent([record, options])
