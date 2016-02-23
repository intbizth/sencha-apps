Ext.define 'Moboque.view.member.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-member-form'

    width: 600
    scrollable: 'true'
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
            fieldLabel: '* ชื่อ'
            anchor: '100%'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุชื่อจริง'
            allowBlank: no
            bind: '{record.firstname}'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* นามสกุล'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุนามสกุล'
            allowBlank: no
            bind: '{record.lastname}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* รหัสประจำตัวประชาชน'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุรหัสประจำตัวประชาชน'
            allowBlank: no
            bind: '{record.card_id}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* รหัสประจำตัวพนักงาน'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุรหัสประจำตัวพนักงาน'
            allowBlank: no
            bind: '{record.employee_id}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* ชื่อหน่วยงาน'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุชื่อหน่วยงาน'
            allowBlank: no
            bind: '{record.company}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* ที่อยู่'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุที่อยู่'
            allowBlank: no
            bind: '{record.address}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* อีเมล์'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุอีเมล์'
            allowBlank: no
            bind: '{record.email}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: 'เบอร์โทรศัพท์'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุเบอร์โทรศัพท์'
            allowBlank: no
            bind: '{record.phone_number}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* เบอร์มือถือ'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุเบอร์มือถือ'
            allowBlank: no
            bind: '{record.mobile_number}'
            anchor: '100%'
            minLength: 2
            maxLength: 255
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
