Ext.define 'Vcare.view.product.form.MainView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-main'

    requires:
        'Ext.form.Translation'

    layout: 'border'
    defaults:
        split: yes
        bodyPadding: 5

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

        # todo translation field
        items: [
            xtype: 'textfield'
            fieldLabel: 'xxxx'
        ,
            xtype: 'textfield'
            fieldLabel: 'xxxx'
        ,
            xtype: 'textfield'
            fieldLabel: 'xxxx'
        ,
            xtype: 'textfield'
            fieldLabel: 'xxxx'
        ]
    ,
        region: 'east'
        floatable: no
        scrollable: yes
        referenceHolder: yes
        width: 320
        scrollable: yes
        xtype: 'form'

        defaults:
            width: 300
            labelAlign: 'top'
        items: [
            xtype: 'textfield'
            fieldLabel: 'SKU'
        ,
            xtype: 'textfield'
            fieldLabel: 'Price'
            vtype: 'alphanum'
        ,
            xtype: 'textfield'
            fieldLabel: 'Original price'
            vtype: 'alphanum'
        ,
            xtype: 'numberfield'
            fieldLabel: 'Current stock'
            minValue: 0
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
