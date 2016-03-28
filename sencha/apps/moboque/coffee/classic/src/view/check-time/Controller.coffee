Ext.define 'Moboque.view.check-time.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-check-time'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('fullname')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-check-time-form'
            title:  title
            viewModel:
                type: 'vm-check-time-form'
                data:
                    record: record

        @callParent([record, options])
