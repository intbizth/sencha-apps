Ext.define 'Moboque.view.promote.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-promote-form'

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
            width: 360
            labelAlign: 'top'

        items: [
            fieldLabel: 'ชื่อสถานที่-แหล่งท่องเที่ยว'
            emptyText: 'กรุณาระบุชื่อสถานที่, ร้าน หรือ แหล่งท่องเที่ยว'
            required: yes
            msgTarget: 'under'
            bind: '{record.title}'
        ,
            xtype: 'textareafield'
            fieldLabel: 'คำอธิบาย'
            emptyText: 'ระบุคำอธิบายสถานที่ หรือ แหล่งท่องเที่ยว'
            required: yes
            msgTarget: 'under'
            bind: '{record.description}'
        ,
            xtype: 'combobox'
            fieldLabel: 'ประเภทของสถานที่'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{promoteCategories}'
                selection: '{promoteCategory}'
        ]

        buttons: [
            text: 'เพิ่มรูป'
            handler: 'onAddImage'
        ,
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
