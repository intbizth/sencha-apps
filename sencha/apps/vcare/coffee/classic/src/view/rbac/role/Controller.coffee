Ext.define 'Vcare.view.rbac.role.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-rbac-role'

    # @override
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"
        record = vm.createRecord(record)

        options =
            xtype: 'wg-rbac-role-form'
            title: title
            viewModel:
                type: 'vm-rbac-role-form'
                data:
                    record: record

        @callParent([record, options])
