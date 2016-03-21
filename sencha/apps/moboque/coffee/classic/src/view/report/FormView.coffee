Ext.define 'Moboque.view.report.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-report-form'

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
            xtype: 'textfield'
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no

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
        ,
            xtype: 'textareafield'
            fieldLabel: 'ละติจูด'
            emptyText: 'กรุณาใส่รายละเอียด'
            bind: '{record.latitude}'
        ,
            xtype: 'textareafield'
            fieldLabel: 'ลองจิจูด'
            emptyText: 'กรุณาใส่รายละเอียด'
            bind: '{record.longitude}'
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
