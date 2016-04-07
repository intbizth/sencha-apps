Ext.define 'Moboque.view.gift.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-gift-form'

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
            width: 360
            labelAlign: 'top'
            required: yes
            msgTarget: 'under'
            minLength: 2
            maxLength: 255

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อของฝาก'
            emptyText: 'ของฝาก...'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำอธิบาย'
            emptyText: 'พูดทักทาย หรือสถานะ...'
            bind: '{record.description}'
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
