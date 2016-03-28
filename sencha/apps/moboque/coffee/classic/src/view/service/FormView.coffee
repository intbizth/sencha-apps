Ext.define 'Moboque.view.service.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-service-form'

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
            allowBlank: no

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อบริการ'
            emptyText: 'กรุณาระบุชื่อบริการ'
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
