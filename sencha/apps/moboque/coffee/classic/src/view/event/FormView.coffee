Ext.define 'Moboque.view.event.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-event-form'

    width: 500
    modal: yes

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        # TODO allowBlank is not working !
        items: [
            xtype: 'textfield'
            fieldLabel: '* ชื่องานอีเวนท์'
            anchor: '100%'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุชื่องานอีเวนท์'
            allowBlank: no
            bind: '{record.name}'
            width: 570
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textareafield'
            fieldLabel: '* สถานที่จัดงานอีเวนท์'
            anchor: '100%'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุสถานที่จัดงานอีเวนท์'
            allowBlank: no
            bind: '{record.location}'
            width: 570
            minLength: 2
            maxLength: 255
        ,
            xtype: 'container'
            layout: 'hbox'
            margin: '10 0 10 0'

            items: [
                xtype: 'datefield'
                fieldLabel: '* วันเริ่มงาน'
                labelAlign: 'top'
                bind: '{startDate}'
                format: 'd/m/Y'
                margin: '10 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '* เวลาเริ่มงาน'
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
                fieldLabel: '* วันสิ้นสุดงาน'
                labelAlign: 'top'
                bind: '{endDate}'
                format: 'd/m/Y'
                margin: '0 10 10 0'
            ,
                xtype: 'timefield'
                fieldLabel: '* เวลาสิ้นสุดงาน'
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
