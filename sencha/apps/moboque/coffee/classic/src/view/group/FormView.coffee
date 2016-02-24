Ext.define 'Moboque.view.group.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-group-form'

    width: 600
    modal: yes

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        # TODO allowBlank is not working !
        defaults:
            xtype: 'textfield'
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no
            minLength: 2
            maxLength: 255

        items: [
            fieldLabel: '* ชื่อกลุ่ม'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            bind: '{record.name}'
        ,
            fieldLabel: '* สีกลุ่ม'
            emptyText: 'กรุณาระบุสีกลุ่ม'
            bind: '{record.color}'
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
