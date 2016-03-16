Ext.define 'Vcare.view.rbac.role.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-rbac-role'

    stores:
        "rbac-roles":
            type: 'store-rbac-roles'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data["rbac-roles"].getModel())()
