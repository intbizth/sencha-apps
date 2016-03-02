Ext.define 'Moboque.view.service_category.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-service-category-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อเรื่อง'
            emptyText: 'กรุณาระบุชื่อเรื่อง'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำบรรยาย'
            emptyText: 'กรุณาใส่คำบรรยาย'
            bind: '{record.sub_title}'
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
