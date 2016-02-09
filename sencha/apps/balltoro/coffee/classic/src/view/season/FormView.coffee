Ext.define 'Balltoro.view.season.FormView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-season-form'

    layout: 'fit'
    modal: yes
    closable: yes

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
            margin: '5 0 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            xtype: 'form'

            defaults:
                anchor : '100%'
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* ชื่อ'
                allowBlank: no
                bind: '{season.name}'
            ,
                xtype: 'textfield'
                fieldLabel: '* รหัส'
                allowBlank: no
                bind: '{season.code}'
            ,
                xtype: 'combo'
                name: 'competition'
                fieldLabel: '* โปรแกรมการแข่งขัน '
                publishes: 'value'
                allowBlank: no
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind: '{season.competition}'
                store:
                    type: 'store-competitions'
                    autoLoad: yes
            ,
                xtype: 'tagfield'
                fieldLabel: 'สโมสรในฤดูกาล '
                name: 'club_members'
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'remote'
                queryParam: 'search'
                minChars: 1
                bind: '{season.club_members}'
                multiSelect: yes
                store:
                    type: 'store-clubs'
            ]
        ,
            region:'east'
            floatable: no
            margin: '5 5 0 0'
            scrollable: yes
            referenceHolder: yes
            width: 320
            xtype: 'form'

            defaults:
                width: 280
                labelAlign: 'top'

            items: [
                xtype: 'datefield'
                fieldLabel: '* เริ่ม'
                allowBlank: no
                format: 'd/m/Y'
                bind: '{season.start_date}'
            ,
                xtype: 'datefield'
                fieldLabel: '* สิ้นสุด'
                allowBlank: no
                format: 'd/m/Y'
                bind: '{season.end_date}'
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
