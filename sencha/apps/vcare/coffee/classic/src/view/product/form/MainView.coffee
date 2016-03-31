Ext.define 'Vcare.view.product.form.MainView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-main'

    layout: 'border'
    defaults:
        split:
            size: 5
        bodyPadding: 10

    items: [
        region: 'center'
        collapsible: no
        scrollable: yes
        modelValidation: yes
        referenceHolder: yes
        scrollable: yes
        xtype: 'form'

        defaults:
            anchor : '100%'
            labelAlign: 'top'

        items: [
            xtype: 'fieldtranslation'
            fieldLabel: 'Name'
            itemKey: 'name'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Short description'
            itemKey: 'short_description'
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
    ,
        region: 'east'
        floatable: no
        scrollable: yes
        referenceHolder: yes
        width: 340
        scrollable: yes
        xtype: 'form'

        defaults:
            width: 300
            labelAlign: 'top'
        items: [
            xtype: 'textfield'
            fieldLabel: 'SKU'
            bind: '{record.master_variant.sku}'
        ,
            xtype: 'textfield'
            fieldLabel: 'Price'
            bind: '{record.master_variant.price}'
        ,
            xtype: 'textfield'
            fieldLabel: 'Original price'
            bind: '{record.master_variant.original_price}'
        ,
            xtype: 'numberfield'
            fieldLabel: 'Current stock'
            minValue: 0
            bind: '{record.master_variant.on_hold}'
        ,
            xtype: 'container'
            layout: 'hbox'
            defaults:
                labelAlign: 'top'

            items: [
                xtype: 'datefield'
                name: 'date'
                fieldLabel: 'Available on date'
                submitFormat: 'Y-m-d'
                format: 'Y-m-d'
                margin: '0 5 0 0'
                width: 170
            ,
                xtype: 'timefield'
                name: 'time'
                fieldLabel: 'time'
                format: 'H:i'
                margin: '0 0 0 5'
                width: 120
            ]
        ,
            xtype: 'container'
            layout: 'hbox'
            margin: '10 0 0 0'
            defaults:
                labelAlign: 'top'

            items: [
                xtype: 'datefield'
                name: 'date'
                fieldLabel: 'Available until date'
                submitFormat: 'Y-m-d'
                format: 'Y-m-d'
                margin: '0 5 0 0'
                width: 170
            ,
                xtype: 'timefield'
                name: 'time'
                fieldLabel: 'time'
                format: 'H:i'
                margin: '0 0 0 5'
                width: 120
            ]
        ,
            xtype: 'checkboxfield'
            boxLabel: 'Available on demand'
            margin: '10 0 0 0'
        ]
    ]
