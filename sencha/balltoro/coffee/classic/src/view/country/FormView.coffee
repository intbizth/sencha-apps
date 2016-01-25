Ext.define 'Toro.view.country.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-country-form'

    layout: 'fit'
    modal: yes
    closable: yes
    height: 420
    width: 320

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
            margin: '0 0 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            width: 320
            xtype: 'form'

            defaults:
                width: 280
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* ชื่อประเทศ'
                allowBlank: no
                bind: '{country.name}'
            ,
                xtype: 'textfield'
                fieldLabel: 'ภาษาท้องถิ่น'
                emptyText: 'en_EN'
                allowBlank: yes
                maxLength: 5
                bind: '{country.local}'
            ,
                xtype: 'textfield'
                fieldLabel: 'รหัสประเทศ'
                emptyText: 'EN'
                allowBlank: yes
                maxLength: 2
                bind: '{country.code}'
            ,
                xtype: 'combobox'
                fieldLabel: '* หมวด'
                allowBlank: no
                bind: '{country.type}'
                editable: no
                store: [
                    ['country', 'country']
                    ['zone', 'zone']
                ]
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
