Ext.define 'Moboque.view.emergency-call.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-emergency-call-form'

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

        defaults:
            xtype: 'textfield'
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no
            minLength: 2
            maxLength: 255

        # TODO allowBlank is not working !
        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อบริการ'
            emptyText: 'กรุณาระบุชื่อของบริการ'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำอธิบาย'
            emptyText: 'กรุณาระบุคำอธิบายของบริการ'
            bind: '{record.description}'
        ,
            fieldLabel: '<span style="color:red;">*</span> เบอร์ฉุกเฉิน'
            emptyText: 'กรุณาใส่หมายเลขฉุกเฉิน'
            bind: '{record.tel}'

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
