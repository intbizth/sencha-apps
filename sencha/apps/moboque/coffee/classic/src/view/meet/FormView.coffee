Ext.define 'Moboque.view.meet.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-meet-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        defaults:
            xtype: 'textareafield'
            width: 400
            labelAlign: 'top'
            allowBlank: no
            msgTarget: 'under'
            minLength: 2
            maxLength: 255

        items: [
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
