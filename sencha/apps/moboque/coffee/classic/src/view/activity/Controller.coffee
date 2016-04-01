Ext.define 'Moboque.view.activity.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-activity'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-activity-form'
            title:  title
            viewModel:
                type: 'vm-activity-form'
                data:
                    record: record

        @callParent([record, options])
