Ext.define 'Vcare.view.rbac.role.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-rbac-role'

    stores:
        "rbac-roles":
            type: 'store-rbac-roles'
            autoLoad: yes

        "rbac-permissions":
            type: 'store-rbac-permissions'
            autoLoad: yes
            remoteFilter: yes

            filters:
                property: 'level'
                value: [0, 1]

        "rbac-permissions-choice":
            type: 'store-rbac-permissions'
            autoLoad: no
            remoteFilter: yes

            listeners:
                load: 'onPermissionChoiceLoaded'

    createRecord: (record) ->
        return record if record
        return new (@data["rbac-roles"].getModel())()
