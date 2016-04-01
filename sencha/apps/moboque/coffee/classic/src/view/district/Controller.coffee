Ext.define 'Moboque.view.district.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-district'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-district-form'
            title:  title
            viewModel:
                type: 'vm-district-form'
                data:
                    record: record

        @callParent([record, options])
