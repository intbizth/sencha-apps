Ext.define 'Balltoro.view.competition.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-competition-form'

    layout: 'fit'
    modal: yes
    closable: yes
    height: 440
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
                fieldLabel: '* ชื่อลีก'
                allowBlank: no
                bind: '{competition.name}'
            ,
                xtype: 'textfield'
                fieldLabel: '* รหัส'
                allowBlank: no
                bind: '{competition.code}'
            ,
                xtype: 'combobox'
                fieldLabel: '* ประเภท'
                bind: '{competition.type}'
                editable: no
                allowBlank: no
                store: [
                    ['LEAGUE', 'LEAGUE']
                    ['CUP', 'CUP']
                ]
            ,
                xtype: 'combobox'
                name: 'country'
                fieldLabel: '* ประเทศ'
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                allowBlank: no
                forceSelection: yes
                bind: '{competition.country}'
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                xtype: 'checkboxfield'
                boxLabel: 'เปิดใช้งาน '
                bind: '{competition.enabled}'
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
