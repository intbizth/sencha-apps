Ext.define 'Moboque.view.promote_category.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote-category'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-promote-category-form'
            title:  title
            viewModel:
                type: 'vm-promote-category-form'
                data:
                    record: record
        @callParent([record, options])
