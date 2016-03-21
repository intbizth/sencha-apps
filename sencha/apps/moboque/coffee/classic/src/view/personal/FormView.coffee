Ext.define 'Moboque.view.personal.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-personal-form'

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
            fieldLabel: '<span style="color:red;">*</span> ชื่อ'
            emptyText: 'กรุณาระบุชื่อ'
            bind: '{record.name}'
        ,
            fieldLabel: '<span style="color:red;">*</span> นามสกุล'
            emptyText: 'กรุณาระบุนามสกุล'
            bind: '{record.surname}'
        ,
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่อแผนก'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{personalDepartments}'
                selection: '{personalDepartment}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ตำแหน่ง'
            emptyText: 'กรุณาระบุตำแหน่ง'
            bind: '{record.position}'
        ,
            xtype: 'textareafield'
            fieldLabel: '<span style="color:red;">*</span> ที่อยู่'
            emptyText: 'กรุณากรอกรายละเอียดที่อยู่'
            bind: '{record.address}'
        ,
            xtype: 'datefield'
            fieldLabel: '<span style="color:red;">*</span> วันเกิด'
            emptyText: 'กรุณาระบุวันเกิด'
            format: 'd-m-Y'
            bind: '{record.birth_date}'
        ,
            fieldLabel: '<span style="color:red;">*</span> เบอร์โทรติดต่อ'
            emptyText: 'กรุณาใส่เบอร์โทรติดต่อ'
            bind: '{record.tel}'
        ,
            fieldLabel: '<span style="color:red;">*</span> อีเมล์'
            emptyText: 'กรุณาใส่ชื่ออีเมล์'
            vtype: 'email'
            bind: '{record.email}'
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
