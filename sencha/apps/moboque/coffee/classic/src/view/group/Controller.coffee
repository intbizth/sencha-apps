Ext.define 'Moboque.view.group.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-group'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-group-form'
            title:  title
            viewModel:
                type: 'vm-group-form'
                data:
                    record: record

        @callParent([record, options])
