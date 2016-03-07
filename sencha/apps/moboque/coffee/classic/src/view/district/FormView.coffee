Ext.define 'Moboque.view.district.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-district-form'

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
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no

        items: [
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่อจังหวัด'
            emptyText: 'กรุณาเลือกจังหวัด'
            editable: no
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{provinces}'
                selection: '{province}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่ออำเภอ'
            emptyText: 'กรุณาใส่ชื่ออำเภอ'
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
