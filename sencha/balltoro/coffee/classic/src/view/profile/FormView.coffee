Ext.define 'Toro.view.profile.FormView',
    extend: 'Toro.view.base.Window'
    alias: 'widget.wg-profile-form'

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
                bind: '{profile.first_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: '* นามสกุล'
                allowBlank: no
                bind: '{profile.last_name}'
                minLength: 2
                maxLength: 255
            ,
                xtype: 'textfield'
                fieldLabel: '* อีเมล '
                allowBlank: no
                bind: '{profile.email}'
                vtype: 'email'
            ,
                xtype: 'datefield'
                fieldLabel: 'วันเกิด'
                format: 'd M Y'
                bind: '{profile.birthday}'
            ,
                xtype: 'textfield'
                fieldLabel: 'เบอร์มือถือ'
                bind: '{profile.mobile}'
                emptyText: '08123456789'
                # maxLength: 10
                enforceMaxLength: true
            ,
                xtype: 'combobox'
                fieldLabel: '* เพศ'
                name: 'gender'
                allowBlank: no
                bind: '{profile.gender}'
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
                name: 'groups'
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind: '{profile.groups}'
                multiSelect: yes
                store:
                    type: 'store-profile-groups'
                    autoLoad: yes
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
                bind: '{user.username}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Displayname'
                allowBlank: yes
                bind: '{user.displayname}'
            ,
                xtype: 'textfield'
                fieldLabel: 'รหัสผ่าน '
                allowBlank: no
                minLength: 6
                bind: '{user.plainPassword}'
                listeners:
                    beforerender: 'onPlainPasswordBeforeRender'
            ,
                xtype: 'combobox'
                fieldLabel: 'ประเทศ '
                name: 'country'
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind: '{user.country}'
                forceSelection: yes
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                xtype: 'checkboxfield'
                name: 'enabled'
                boxLabel: 'เปิดการใช้งาน '
                bind: '{user.enabled}'
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
