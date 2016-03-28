Ext.define 'Vcare.view.tax.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-tax-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'border'
        referenceHolder: yes

        defaults:
            split: yes
            bodyPadding: 10

        items: [
            region: 'center'
            collapsible: no
            margin: '5 5 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            xtype: 'form'

            defaults:
                anchor : '100%'
                labelAlign: 'top'

            items: [

                xtype: 'textfield'
                fieldLabel: 'Code'
                name: 'code'
                bind:
                    value: '{record.code}'
                    readOnly: '{hasCode}'

            ,
                xtype: 'textfield'
                fieldLabel: 'Name'
                name: 'name'
                bind: '{record.name}'
            ,
                xtype: 'combobox'
                fieldLabel: 'Category'
                name: 'category'
                allowBlank: no
                editable: no
                queryMode: 'remote'
                bind: '{record.category}'
                forceSelection: yes
                store: 'tax-cats'
                valueField: 'id'
                displayField: 'name'
            ,
                xtype: 'combobox'
                fieldLabel: 'Zone'
                name: 'zone'
                allowBlank: no
                editable: no
                queryMode: 'local'
                bind: '{record.zone.id}'
                store: 'zones'
                valueField: 'id'
                displayField: 'name'
            ,
                xtype: 'numberfield'
                fieldLabel: 'Amount'
                name: 'amount'
                bind: '{record.amount}'
                maxValue: 100
                minValue: 0

            ,
                xtype: 'checkboxfield'
                fieldLabel: 'Included in price ?'
                name: 'included_in_price'
                bind: '{record.included_in_price}'
            ,
                xtype: 'combobox'
                fieldLabel: 'Calculator'
                name: 'calculator'
                allowBlank: no
                editable: no
                queryMode: 'local'
                bind: '{record.calculator}'
                store: [
                    'default'
                ]
                valueField: 'id'
                displayField: 'id'

            ]
        ,
            region: 'south'
            collapsible: no
            layout: 'fit'
            split: no
            bodyPadding: 0
            buttons: [
                text: 'ยกเลิก'
                handler: 'onCancel'
            ,
                text: 'บันทึก'
                handler: 'onSubmit'
                disabled: yes
                formBind: yes
            ]
        ]
