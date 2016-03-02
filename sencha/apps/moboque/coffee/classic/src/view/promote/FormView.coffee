Ext.define 'Moboque.view.promote.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-promote-form'

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
            # minLength: 2
            # maxLength: 255

        items: [
            fieldLabel: 'ชื่อเรื่อง'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            bind: '{record.title}'
        ,
            fieldLabel: '* สีกลุ่ม'
            emptyText: 'ระบุคำอธิบาย'
            bind: '{record.description}'
        ,
            xtype: 'combobox'
            fieldLabel: '* ชื่องานอีเวนท์'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{promoteCategories}'
                selection: '{promoteCategory}'
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
