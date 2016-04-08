Ext.define 'Moboque.view.gallery_category.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-gallery-category'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-gallery-category-form'
            title:  title
            viewModel:
                type: 'vm-gallery-category-form'
                data:
                    record: record

        @callParent([record, options])
