Ext.define 'Moboque.view.news.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-news'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-news-form'
            title: title
            viewModel:
                type: 'vm-news-form'
                data:
                    record: record

        @callParent([record, options])
