Ext.define 'Moboque.view.province.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-province'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-province-form'
            title:  title
            viewModel:
                type: 'vm-province-form'
                data:
                    record: record

        @callParent([record, options])
