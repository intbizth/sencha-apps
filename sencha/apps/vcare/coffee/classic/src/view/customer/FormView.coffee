Ext.define 'Vcare.view.customer.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-customer-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'hbox'
        bodyPadding: 10

        defaults:
            xtype: 'container'
            layout: 'anchor'

        fieldDefaults:
            labelAlign: 'top'
            anchor : '100%'

        items: [{
            flex: 1
            margin: '0 20 0 0'
            items: [
                labelAlign: 'top'
                xtype: 'textfield'
                fieldLabel: 'Username'
                required: no
                bind: '{record.user.username}'
            # TODO: can't disable autocomplete
            # ,
            #     xtype: 'textfield'
            #     inputType: 'password'
            #     fieldLabel: 'รหัสผ่าน '
            #     minLength: 4
            #     ariaAttributes:
            #         autocomplete: 'no-password'
            #     bind:
            #         value: '{record.user.plain_password}'
            #         required: '{record.phantom}'
            ,
                xtype: 'combobox'
                fieldLabel: 'Locale'
                required: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind:
                    store: '{locales}'
                    selection: '{record.user.id}'
            ,
                xtype: 'checkboxfield'
                boxLabel: 'เปิดการใช้งาน '
                bind: '{record.user.enabled}'
            ]
        }, {
            flex: 2
            items: [
                xtype: 'textfield'
                fieldLabel: 'ชื่อ'
                required: yes
                bind: '{record.first_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: 'นามสกุล'
                required: no
                bind: '{record.last_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: 'อีเมล '
                required: yes
                bind: '{record.email}'
                vtype: 'email'
            ,
                xtype: 'datefield'
                fieldLabel: 'วันเกิด'
                format: 'd M Y'
                bind: '{record.birthday}'
            ,
                xtype: 'combobox'
                fieldLabel: 'เพศ'
                name: 'gender'
                required: yes
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
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind:
                    store: '{groups}'
                    selection: '{currentGroups}'
            ]
        }]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
