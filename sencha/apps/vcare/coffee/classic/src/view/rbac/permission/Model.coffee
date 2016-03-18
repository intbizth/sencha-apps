Ext.define 'Vcare.view.rbac.permission.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-rbac-permission'

    stores:
        "rbac-permissions":
            type: 'store-rbac-permissions'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data["rbac-permissions"].getModel())()
