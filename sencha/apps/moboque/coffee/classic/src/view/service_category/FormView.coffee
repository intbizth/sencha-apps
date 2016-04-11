Ext.define 'Moboque.view.service_category.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-service-category-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อเรื่อง'
            emptyText: 'กรุณาระบุชื่อเรื่อง'
            bind: '{record.title}'
            required: yes
            msgTarget: 'under'
        ,
            fieldLabel: 'คำบรรยาย'
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
