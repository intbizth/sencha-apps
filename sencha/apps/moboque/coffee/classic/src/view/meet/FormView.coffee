Ext.define 'Moboque.view.meet.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-meet-form'

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
            fieldLabel: '<span style="color:red;">*</span> สถานะ'
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
