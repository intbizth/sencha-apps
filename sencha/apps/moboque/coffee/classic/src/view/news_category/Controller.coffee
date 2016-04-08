Ext.define 'Moboque.view.news_category.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-news-category'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-news-category-form'
            title:  title
            viewModel:
                type: 'vm-news-category-form'
                data:
                    record: record

        @callParent([record, options])
