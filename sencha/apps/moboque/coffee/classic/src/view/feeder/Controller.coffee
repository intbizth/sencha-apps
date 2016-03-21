Ext.define 'Moboque.view.feeder.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-feeder'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-feeder-form'
            title:  title
            viewModel:
                type: 'vm-feeder-form'
                data:
                    record: record
                    
        @callParent([record, options])
