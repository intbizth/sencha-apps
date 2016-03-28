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

        # auto select first row after show dialog.
        @referTo('RolePermissionList')
            .getSelectionModel().select([
                @getViewModel().get('rbac-permissions').getAt(0)
            ])

    onPermissionChoiceLoaded: (store, rs) ->
        records = []

        @getDialogRecord().getPermissions().each (rec) ->
            if record = store.getById(rec.getId())
                records.push(record)

        # mask selected items.
        @referTo('RolePermissionChoiceList')
            .getSelectionModel()
            .select(records, no, yes)

    onPermissionChange: (sm, rs) ->
        # deselect with `suppressEvent` prevent `selectionchange` fire.
        @referTo('RolePermissionChoiceList')
            .getSelectionModel()
            .deselectAll(yes)

        # reload choice.
        @getViewModel().get('rbac-permissions-choice').filter([
            property: 'code'
            value: rs[0].get('code')
        ])

    # @private
    doPermissionChoiceSelectionChange: (method, rec) ->
        record = @getDialogRecord()
        store = record.getPermissions()

        store[method](rec)

        # just mask dirty change to prevent daul check in vm.isDirty()
        record.set('permissions', store.getData().getRange())

    onPermissionChoiceChecked: (sm, record) ->
        @doPermissionChoiceSelectionChange('add', record)

    onPermissionChoiceUnChecked: (sm, record) ->
        @doPermissionChoiceSelectionChange('remove', record)
