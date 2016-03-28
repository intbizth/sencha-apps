Ext.define 'Moboque.view.sub-district.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-sub-district-form'

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
            width: 360
            labelAlign: 'top'
            allowBlank: no

        items: [
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่ออำเภอ'
            emptyText: 'กรุณาเลือกอำเภอ'
            editable: no
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{districts}'
                selection: '{district}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อตำบล'
            emptyText: 'กรุณาใส่ชื่อตำบล'
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
