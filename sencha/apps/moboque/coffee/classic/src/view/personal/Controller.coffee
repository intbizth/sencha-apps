Ext.define 'Moboque.view.personal.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-personal'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-personal-form'
            title:  title
            viewModel:
                type: 'vm-personal-form'
                data:
                    record: record
                    
        @callParent([record, options])
