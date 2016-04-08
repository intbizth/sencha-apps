Ext.define 'Moboque.view.check-time.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-check-time-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        defaults:
            xtype: 'combo'
            width: 360
            labelAlign: 'top'
            required: yes
            msgTarget: 'under'
            editable: no

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อสมาชิก'
            emptyText: 'กรุณาเลือกชื่อสมาชิก'
            displayField: 'fullname'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{members}'
                selection: '{member}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ประเภทการลงเวลา'
            emptyText: 'กรุณาเลือกประเภทการลงเวลา'
            queryMode: 'local'
            store: [
                [ 'check-in', 'Check-in' ]
            ,
                [ 'check-out', 'Check-out' ]
            ]
            bind: '{record.type}'
        ,
            xtype: 'container'
            layout: 'hbox'

            items: [
                xtype: 'datefield'
                fieldLabel: '<span style="color:red;">*</span> วันที่บันทึก'
                labelAlign: 'top'
                bind: '{checkDate}'
                format: 'd/m/Y'
                margin: '10 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '<span style="color:red;">*</span> เวลาที่บันทึก'
                labelAlign: 'top'
                bind: '{checkTime}'
                margin: '10 0 10 10'
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
