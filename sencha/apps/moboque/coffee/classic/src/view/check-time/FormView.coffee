Ext.define 'Moboque.view.check-time.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-check-time-form'

    width: 600
    modal: yes
    scrollable: 'true'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        # TODO allowBlank is not working !
        defaults:
            xtype: 'combo'
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no
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
                fieldLabel: '<span style="color:red;">*</span> วันเริ่มงาน'
                labelAlign: 'top'
                bind: '{checkDate}'
                format: 'd/m/Y'
                margin: '10 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '<span style="color:red;">*</span> เวลาเริ่มงาน'
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
