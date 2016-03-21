Ext.define 'Moboque.view.service.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-service'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-service-form'
            title:  title
            viewModel:
                type: 'vm-service-form'
                data:
                    record: record
                    
        @callParent([record, options])
