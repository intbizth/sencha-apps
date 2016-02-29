Ext.define 'Moboque.view.member.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-member-form'

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
            labelAlign: 'top'
            anchor: '100%'
            allowBlank: no
            minLength: 2
            maxLength: 255

        items: [
            fieldLabel: '* ชื่อ'
            emptyText: 'กรุณาระบุชื่อจริง'
            bind: '{record.firstname}'
        ,
            fieldLabel: '* นามสกุล'
            emptyText: 'กรุณาระบุนามสกุล'
            bind: '{record.lastname}'
        ,
            fieldLabel: '* รหัสประจำตัวประชาชน'
            emptyText: 'กรุณาระบุรหัสประจำตัวประชาชน'
            bind: '{record.card_id}'
        ,
            fieldLabel: '* รหัสประจำตัวพนักงาน'
            emptyText: 'กรุณาระบุรหัสประจำตัวพนักงาน'
            bind: '{record.employee_id}'
        ,
            fieldLabel: '* ชื่อหน่วยงาน'
            emptyText: 'กรุณาระบุชื่อหน่วยงาน'
            bind: '{record.company}'
        ,
            fieldLabel: '* ที่อยู่'
            emptyText: 'กรุณาระบุที่อยู่'
            bind: '{record.address}'
        ,
            fieldLabel: '* อีเมล์'
            emptyText: 'กรุณาระบุอีเมล์'
            bind: '{record.email}'
        ,
            fieldLabel: 'เบอร์โทรศัพท์'
            emptyText: 'กรุณาระบุเบอร์โทรศัพท์'
            bind: '{record.phone_number}'
        ,
            fieldLabel: '* เบอร์มือถือ'
            emptyText: 'กรุณาระบุเบอร์มือถือ'
            bind: '{record.mobile_number}'
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
