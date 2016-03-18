Ext.define 'Vcare.view.rbac.permission.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-rbac-permission'

    # @override
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('description')}"
        record = vm.createRecord(record)

        options =
            xtype: 'wg-rbac-permission-form'
            title: title
            viewModel:
                type: 'vm-rbac-permission-form'
                data:
                    record: record

        @callParent([record, options])
