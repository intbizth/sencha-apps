Ext.define 'Moboque.view.report.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-report'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-report-form'
            title:  title
            viewModel:
                type: 'vm-report-form'
                data:
                    record: record

        @callParent([record, options])
