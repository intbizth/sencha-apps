Ext.define 'Moboque.view.event.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-event-form'

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
                fieldLabel: '* ชื่องานอีเวนท์'
                emptyText: 'กรุณาระบุชื่องานอีเวนท์'
                allowBlank: no
                bind: '{record.name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textareafield'
                fieldLabel: '* สถานที่จัดงานอีเวนท์'
                emptyText: 'กรุณาระบุสถานที่จัดงานอีเวนท์'
                allowBlank: no
                bind: '{record.location}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'container'
                layout: 'hbox'
                margin: '10 0 10 0'

                items: [
                    xtype: 'datefield'
                    fieldLabel: '* วันเริ่มงาน'
                    bind: '{record.start_date}'
                    format: 'd/m/Y'
                    margin: '10 10 10 0'
                ,
                    xtype: 'timefield'
                    fieldLabel: '* เวลาเริ่มงาน'
                    bind: '{record.start_date}'
                    margin: '10 0 10 10'
                ]
            ,
                xtype: 'container'
                layout: 'hbox'
                margin: '0 0 10 0'

                items: [
                    xtype: 'datefield'
                    fieldLabel: '* วันสิ้นสุดงาน'
                    bind: '{record.end_date}'
                    format: 'd/m/Y'
                    margin: '0 10 10 0'
                ,
                    xtype: 'timefield'
                    fieldLabel: '* เวลาสิ้นสุดงาน'
                    bind: '{record.end_date}'
                    margin: '0 0 10 10'
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
        ]
