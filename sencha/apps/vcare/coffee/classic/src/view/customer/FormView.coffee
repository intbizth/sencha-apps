Ext.define 'Vcare.view.customer.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-customer-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'border'
        referenceHolder: yes

        defaults:
            split: yes
            bodyPadding: 10

        items: [
            region: 'center'
            collapsible: no
            margin: '5 5 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            xtype: 'form'

            defaults:
                anchor : '100%'
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* ชื่อ'
                allowBlank: no
                bind: '{record.first_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: '* นามสกุล'
                allowBlank: no
                bind: '{record.last_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: '* อีเมล '
                allowBlank: no
                bind: '{record.email}'
                vtype: 'email'
            ,
                xtype: 'datefield'
                fieldLabel: 'วันเกิด'
                format: 'd M Y'
                bind: '{record.birthday}'
            ,
                xtype: 'textfield'
                fieldLabel: 'เบอร์มือถือ'
                bind: '{record.mobile}'
                emptyText: '08123456789'
                # maxLength: 10
                enforceMaxLength: true
            ,
                xtype: 'combobox'
                fieldLabel: '* เพศ'
                name: 'gender'
                allowBlank: no
                editable: no
                bind: '{record.gender}'
                store: [
                    ['u', 'ไม่ระบุ']
                ,
                    ['m', 'ชาย']
                ,
                    ['f', 'หญิง']
                ]
            ,
                xtype: 'tagfield'
                fieldLabel: 'กลุ่มผู้ใช้งาน '
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                multiSelect: yes
                bind:
                    store: '{groups}'
                    value: '{currentGroups}'
            ]
        ,
            region:'west'
            floatable: no
            margin: '5 0 0 5'
            scrollable: yes
            referenceHolder: yes
            width: 400
            xtype: 'form'

            defaults:
                width: 360
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: 'Username'
                allowBlank: no
                bind: '{record.user.username}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Displayname'
                allowBlank: yes
                bind: '{record.user.displayname}'
            ,
                xtype: 'textfield'
                inputType: 'password'
                fieldLabel: 'รหัสผ่าน '
                minLength: 4
                bind:
                    value: '{record.user.plain_password}'
                    required: '{isPhantom}'
            ,
                xtype: 'checkboxfield'
                boxLabel: 'เปิดการใช้งาน '
                bind: '{record.user.enabled}'
            ]
        ,
            region: 'south'
            collapsible: no
            layout: 'fit'
            split: no
            bodyPadding: 0
            buttons: [
                text: 'ยกเลิก'
                handler: 'onCancel'
            ,
                text: 'บันทึก'
                handler: 'onSubmit'
                disabled: yes
                formBind: yes
            ]
        ]
