Ext.define 'Moboque.view.promote.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-promote-form'

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


        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อเรื่อง'
            emptyText: 'กรุณากรอกชื่อเรื่อง...'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำอธิบาย'
            emptyText: 'กรุณากรอกคำอธิบาย...'
            bind: '{record.description}'
        ,
            fieldLabel: '<span style="color:red;">*</span> หมวด'
            xtype: 'combobox'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{promotesCat}'
                selection: '{promoteSaveTitle}'
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
