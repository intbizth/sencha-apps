Ext.define 'Vcare.view.order.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-order-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'hbox'
        bodyPadding: 10

        defaults:
            xtype: 'container'
            layout: 'anchor'

        fieldDefaults:
            labelAlign: 'top'
            anchor : '100%'

        items: [{
            flex: 1
            margin: '0 20 0 0'
            items: [
                labelAlign: 'top'
                xtype: 'textfield'
                fieldLabel: 'Username'
                required: no
                bind: '{record.user.username}'
            ]
        }]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
