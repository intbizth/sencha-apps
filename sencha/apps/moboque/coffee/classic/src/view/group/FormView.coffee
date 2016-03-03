Ext.define 'Moboque.view.group.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-group-form'

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
            xtype: 'combobox'
            fieldLabel: '<span style="color:red;">*</span> ชื่องานอีเวนท์'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{events}'
                selection: '{event}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อกลุ่ม'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            bind: '{record.name}'
        ,
            xtype: 'colorfield'
            fieldLabel: '<span style="color:red;">*</span> สีกลุ่ม'
            format: '#hex6'
            allowBlank: no
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
