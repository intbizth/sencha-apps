Ext.define 'Moboque.view.province.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-province-form'

    width: 600
    modal: yes
    scrollable: 'true'

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
            labelAlign: 'top'
            anchor: '100%'
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
