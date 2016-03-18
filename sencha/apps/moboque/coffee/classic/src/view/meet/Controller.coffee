Ext.define 'Moboque.view.meet.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-meet'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('description')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-meet-form'
            title:  title
            viewModel:
                type: 'vm-meet-form'
                data:
                    record: record

        @callParent([record, options])
