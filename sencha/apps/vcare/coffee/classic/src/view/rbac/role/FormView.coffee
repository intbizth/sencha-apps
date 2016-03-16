Ext.define 'Vcare.view.rbac.role.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-rbac-role-form'

    bind:
        title: '{title}'

    fullsize: no
    width: 600
    height: 500

    items:
        xtype: 'form'
        padding: 10

        items: [
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
            fieldLabel: 'Code'
            required: yes
            minLength: 3
            maxLength: 20
            bind:
                value: '{record.code}'
                disabled: '{!isPhantom}'
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

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
