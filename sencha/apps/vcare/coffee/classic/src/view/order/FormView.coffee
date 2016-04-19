Ext.define 'Vcare.view.order.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-order-form'

    width: 400
    modal: yes

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'hbox'


        defaults:
            xtype: 'container'
            layout: 'anchor'

        fieldDefaults:
            labelAlign: 'top'
            anchor : '100%'

        items: [

            xtype: 'fieldset'
            title: 'Billing Address'
            defaultType: 'textfield'
            defaults:
                anchor: '100%'

            items: [

                allowBlank: false
                fieldLabel: 'First name'
                bind: '{record.billing_address.first_name}'
            ,
                allowBlank: false
                fieldLabel: 'Last name'
                bind: '{record.billing_address.last_name}'
            ,
                fieldLabel: 'Phone number'
                bind: '{record.billing_address.phone_number}'
            ,
                fieldLabel: 'Company'
                bind: '{record.billing_address.company}'
            ,
                allowBlank: false
                fieldLabel: 'Street'
                bind: '{record.billing_address.street}'
            ,

                allowBlank: false
                fieldLabel: 'City'
                bind: '{record.billing_address.city}'
            ,
                xtype: 'combobox'
                fieldLabel: 'Country'
                displayField: 'name'
                valueField: 'code'
                queryMode: 'local'
                forceSelection: yes
                bind:
                    store: '{countries}'
                    selection: '{record.billing_address.country_code}'

            ,
                fieldLabel: 'Postcode',
                bind: '{record.billing_address.postcode}'

            ]
        ,
            xtype: 'fieldset',
            title: 'Shipping Address',
            defaultType: 'textfield',
            defaults: {
                anchor: '100%'
            },
            items: [
                allowBlank: false
                fieldLabel: 'First name'
                bind: '{record.shipping_address.first_name}'
            ,
                allowBlank: false
                fieldLabel: 'Last name'
                bind: '{record.shipping_address.last_name}'
            ,
                fieldLabel: 'Phone number'
                bind: '{record.shipping_address.phone_number}'
            ,
                fieldLabel: 'Company'
                bind: '{record.shipping_address.company}'
            ,
                allowBlank: false
                fieldLabel: 'Street'
                bind: '{record.shipping_address.street}'
            ,
                allowBlank: false
                fieldLabel: 'City'
                bind: '{record.shipping_address.city}'
            ,

                xtype: 'combobox'
                fieldLabel: 'Country'
                displayField: 'name'
                valueField: 'code'
                queryMode: 'local'
                bind:
                    store: '{countries}'
                    selection: '{record.shipping_address.country_code}'
            ,
                fieldLabel: 'Postcode'
                bind: '{record.shipping_address.postcode}'

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
