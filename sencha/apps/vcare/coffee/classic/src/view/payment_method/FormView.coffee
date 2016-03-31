Ext.define 'Vcare.view.payment_method.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-payment-method-form'

    fullsize: no
    width: 500
    height: 500

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        padding: 10

        fieldDefaults:
            labelAlign: 'top'

        items: [
            xtype: 'textfield'
            fieldLabel: 'Code'
            required: no
            bind:
                value: '{record.code}'
                disabled: '{!record.phantom}'
        ,
            xtype: 'combobox'
            fieldLabel: 'Gateways'
            required: yes
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{payment-gateways}'
                selection: '{record.gateway}'
        ,
            xtype: 'checkboxfield'
            boxLabel: 'เปิดการใช้งาน '
            bind: '{record.enabled}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Name'
            itemKey: 'name'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Description'
            itemKey: 'description'
            itemType: 'textarea'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
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
