Ext.define 'Moboque.view.personal-department.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-personal-department-form'

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

        items: [
            xtype: 'textfield'
            anchor: '100%'
            fieldLabel: '<span style="color:red;">*</span> ชื่อแผนก'
            labelAlign: 'top'
            emptyText: 'กรุณากรอกชื่อแผนก'
            allowBlank: no
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
