Ext.define 'Moboque.view.report.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-report-form'

    scrollable: 'true'

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
            anchor: '100%'
            labelAlign: 'top'
            xtype: 'textfield'
            msgTarget: 'under'

        items: [
            fieldLabel: '<span style="color:red;">*</span> หัวข้อเหตุฉุกเฉิน'
            emptyText: 'กรุณาระบุหัวข้อเหตุฉุกเฉิน'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> สถานะ'
            emptyText: 'กรุณาระบุสถานะ'
            bind: '{record.state}'
        ,
            xtype: 'textareafield'
            fieldLabel: '<span style="color:red;">*</span> รายละเอียด'
            emptyText: 'กรุณาใส่รายละเอียด'
            bind: '{record.description}'
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
