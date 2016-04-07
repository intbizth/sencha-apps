Ext.define 'Moboque.view.promote-category.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-promote-category-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        items: [
            xtype: 'textfield'
            fieldLabel: 'ชื่อเรื่อง'
            emptyText: 'กรุณากรอกชื่อเรื่อง...'
            anchor: '100%'
            labelAlign: 'top'
            minLength: 2
            maxLength: 255
            required: yes
            msgTarget: 'under'
            bind: '{record.title}'
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
