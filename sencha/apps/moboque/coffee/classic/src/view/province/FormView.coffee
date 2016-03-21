Ext.define 'Moboque.view.province.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-province-form'

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
            labelAlign: 'top'
            width: 360
            allowBlank: no

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อจังหวัด'
            emptyText: 'กรุณาระบุชื่อจังหวัด'
            bind: '{record.name}'
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
