Ext.define 'Moboque.view.gift.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-gift'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-gift-form'
            title:  title
            viewModel:
                type: 'vm-gift-form'
                data:
                    record: record

        @callParent([record, options])
