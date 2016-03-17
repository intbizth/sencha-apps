Ext.define 'Vcare.view.rbac.role.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-rbac-role-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        padding: 10

        layout:
            type: 'hbox'
            pack: 'start'
            align: 'stretch'

        defaults:
            margin: '0 10'

        items: [
            flex: 1
            defaults:
                labelAlign: 'top'
                width: '100%'

            items: [
                xtype: 'textfield'
                fieldLabel: 'Code'
                required: yes
                minLength: 3
                maxLength: 20
                bind:
                    value: '{record.code}'
                    disabled: '{!isPhantom}'
            ,
                xtype: 'combo-tree'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Parent'
                forceSelection: yes
                required: yes
                editable: no
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{rbac-roles}'
                    selection: '{record.parent}'
                    record: '{record}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Name'
                required: yes
                bind: value: '{record.name}'
            ,
                xtype: 'textarea'
                fieldLabel: 'Description'
                required: no
                bind: value: '{record.description}'
            ]
        ,
            flex: 1
            xtype: 'wg-rbac-role-permission-list'
            reference: 'refRolePermissionList'

            selModel:
                type: 'rowmodel'
                mode: 'SINGLE'

            listeners:
                selectionchange: 'onPermissionChange'
        ,
            flex: 1
            xtype: 'wg-rbac-role-permission-list'
            reference: 'refRolePermissionChoiceList'

            listeners:
                selectionchange: 'onPermissionChoiceChange'

            selModel:
                type: 'checkboxmodel'
                checkOnly: yes
                showHeaderCheckbox: no
                mode: 'MULTI'

            bind:
                store: '{rbac-permissions-choice}'

            columns: [
                flex: 1
                text: 'Permissions Selection'
                dataIndex: 'description'
                sortable: no
                menuDisabled: yes
                renderer: (v, m, r) -> @getTreePadding(m, r, v)
            ]
        ]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
