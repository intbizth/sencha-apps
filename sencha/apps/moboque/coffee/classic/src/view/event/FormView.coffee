Ext.define 'Moboque.view.event.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-event-form'

    # width: 500
    # modal: yes

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        defaults:
            xtype: 'textfield'
            labelAlign: 'top'
            required: yes
            msgTarget: 'under'

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่องานอีเวนท์'
            emptyText: 'กรุณาระบุชื่องานอีเวนท์'
            width: 360
            bind: '{record.name}'
        ,
            xtype: 'textareafield'
            fieldLabel: '<span style="color:red;">*</span> สถานที่จัดงานอีเวนท์'
            emptyText: 'กรุณาระบุสถานที่จัดงานอีเวนท์'
            width: 360
            bind: '{record.location}'
        ,
            xtype: 'container'
            layout: 'hbox'

            items: [
                xtype: 'datefield'
                fieldLabel: '<span style="color:red;">*</span> วันเริ่มงาน'
                labelAlign: 'top'
                bind: '{startDate}'
                format: 'd/m/Y'
                margin: '10 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '<span style="color:red;">*</span> เวลาเริ่มงาน'
                labelAlign: 'top'
                bind: '{startTime}'
                margin: '10 0 10 10'
            ]
        ,
            xtype: 'container'
            layout: 'hbox'
            margin: '0 0 10 0'

            items: [
                xtype: 'datefield'
                fieldLabel: '<span style="color:red;">*</span> วันสิ้นสุดงาน'
                labelAlign: 'top'
                bind: '{endDate}'
                format: 'd/m/Y'
                margin: '0 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '<span style="color:red;">*</span> เวลาสิ้นสุดงาน'
                labelAlign: 'top'
                bind: '{endTime}'
                margin: '0 0 10 10'
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
