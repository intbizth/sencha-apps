Ext.define 'Moboque.view.activity.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-activity-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อกิจกรรม'
            emptyText: 'กรุณาระบุชื่อกิจกรรม'
            bind: '{record.title}'
        ,
            fieldLabel: 'หัวข้อย่อย'
            emptyText: 'กรุณาระบุหัวข้อย่อย'
            bind: '{record.sub_title}'
            allowBlank: yes
        ,
            xtype: 'textareafield'
            fieldLabel: '<span style="color:red;">*</span> รายละเอียด'
            emptyText: 'กรุณากรอกรายละเอียด'
            bind: '{record.detail}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ลิงก์'
            emptyText: 'http://'
            vtype: 'url'
            bind: '{record.link}'
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
