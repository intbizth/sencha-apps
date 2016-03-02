Ext.define 'Moboque.view.service.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-service-form'

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
            xtype: 'combobox'
            fieldLabel: '* ชื่อหมวดหมู่'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{serviceCategories}'
                selection: '{serviceCategory}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อเรื่อง'
            emptyText: 'กรุณาระบุชื่อเรื่อง'
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
            fieldLabel: '<span style="color:red;">*</span> ราคา'
            emptyText: 'กรุณากรอกราคา'
            bind: '{record.price}'
        ,
            fieldLabel: '<span style="color:red;">*</span> สกุลเงิน'
            emptyText: 'กรุณากรอกสกุลเงิน'
            bind: '{record.price_currency}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ลิงก์'
            emptyText: 'http://'
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
