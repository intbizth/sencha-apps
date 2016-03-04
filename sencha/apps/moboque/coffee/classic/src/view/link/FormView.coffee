Ext.define 'Moboque.view.link.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-link-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อเว็บ'
            emptyText: 'กรุณาระบุชื่อหรือคำอธิบายเว็บ'
            bind: '{record.label}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ลิงค์'
            emptyText: 'กรุณาระบุลิงค์'
            bind: '{record.url}'
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
