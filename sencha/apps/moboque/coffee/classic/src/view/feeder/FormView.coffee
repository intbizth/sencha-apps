Ext.define 'Moboque.view.feeder.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-feeder-form'

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

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อหัวข้อ'
            emptyText: 'กรุณาใส่ชื่อหัวข้อ'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> รายละเอียด'
            emptyText: 'กรุณาใส่รายละเอียด'
            bind: '{record.description}'
        ,
            fieldLabel: '<span style="color:red;">*</span> สถานะ'
            emptyText: 'กรุณาใส่สถานะ'
            bind: '{record.state}'
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
