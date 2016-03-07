Ext.define 'Moboque.view.travel.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-travel-form'

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
