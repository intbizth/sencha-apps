Ext.define 'Vcare.view.shipmemt.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-shipment-form'

    modal: yes
    width: 400
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

        items: [
            items: [
                xtype: 'textfield'
                fieldLabel: 'Tracking Code'
                required: no
                bind: '{record.tracking}'
                minLength: 2
                maxLength: 255
            ]
        ]
        buttons: [
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
