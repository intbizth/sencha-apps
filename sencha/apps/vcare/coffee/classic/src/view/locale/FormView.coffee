Ext.define 'Vcare.view.locale.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-locale-form'

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

                xtype: 'combobox'
                fieldLabel: '* ภาษา'
                name: 'code'
                allowBlank: no
                editable: no
                bind: '{record.code}'
                store: 'ulocalecodes'
                displayField: 'name'
                valueField: 'abbr'

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
