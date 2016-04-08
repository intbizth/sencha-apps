Ext.define 'Moboque.view.gallery-category.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-gallery-category-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อหมวดหมู่'
            emptyText: 'กรุณาระบุชื่อรูปภาพ'
            bind: '{record.title}'
            required: yes
            msgTarget: 'under'
        ,
            fieldLabel: 'คำบรรยาย'
            emptyText: 'กรุณากรอกคำบรรยาย'
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
