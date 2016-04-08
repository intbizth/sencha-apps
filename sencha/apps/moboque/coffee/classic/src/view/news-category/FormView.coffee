Ext.define 'Moboque.view.news-category.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-news-category-form'

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
            required: yes
            msgTarget: 'under'

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
