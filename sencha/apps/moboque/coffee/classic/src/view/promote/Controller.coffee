Ext.define 'Moboque.view.promote.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-promote-form'
            title:  title
            viewModel:
                type: 'vm-promote-form'
                data:
                    record: record
        @callParent([record, options])
