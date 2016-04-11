Ext.define 'Moboque.view.sub_district.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-sub-district'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-sub-district-form'
            title:  title
            viewModel:
                type: 'vm-sub-district-form'
                data:
                    record: record

        @callParent([record, options])
