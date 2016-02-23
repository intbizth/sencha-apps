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
        items: [
            xtype: 'textfield'
            fieldLabel: '* ชื่อกลุ่ม'
            anchor: '100%'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            allowBlank: no
            bind: '{record.name}'
            width: 570
            minLength: 2
            maxLength: 255
        ,
            xtype: 'textfield'
            fieldLabel: '* สีกลุ่ม'
            anchor: '100%'
            labelAlign: 'top'
            emptyText: 'กรุณาระบุสีกลุ่ม'
            allowBlank: no
            bind: '{record.color}'
            width: 570
            minLength: 2
            maxLength: 255
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
