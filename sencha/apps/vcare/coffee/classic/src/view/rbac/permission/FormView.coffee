Ext.define 'Vcare.view.rbac.permission.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-rbac-permission-form'

    bind:
        title: '{title}'

    fullsize: no
    width: 400
    height: 300

    items:
        xtype: 'form'
        padding: 10

        defaults:
            anchor: '100%'

        items: [
            xtype: 'combo-tree'
            queryMode: 'local'
            triggerAction: 'all'
            fieldLabel: 'Parent'
            forceSelection: yes
            required: yes
            editable: yes
            displayField: 'description'
            valueField: 'id'
            bind:
                store: '{rbac-permissions}'
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
