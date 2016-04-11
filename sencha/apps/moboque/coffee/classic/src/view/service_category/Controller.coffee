Ext.define 'Moboque.view.service_category.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-service-category'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-service-category-form'
            title:  title
            viewModel:
                type: 'vm-service-category-form'
                data:
                    record: record

        @callParent([record, options])
