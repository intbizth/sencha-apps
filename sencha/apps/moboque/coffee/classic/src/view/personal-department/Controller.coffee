Ext.define 'Moboque.view.personal-department.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-personal-department'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-personal-department-form'
            title:  title
            viewModel:
                type: 'vm-personal-department-form'
                data:
                    record: record
                    
        @callParent([record, options])
