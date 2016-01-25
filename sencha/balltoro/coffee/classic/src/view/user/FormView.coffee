Ext.define 'Toro.view.user.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-user-form'

    #TODO remove this file because use in profile form.

    layout: 'fit'
    modal: yes
    closable: yes
    height: 540
    width: 320

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
            region: 'west'
            collapsible: no
            margin: '5 0 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            width: 320
            xtype: 'form'

            defaults:
                width: 280
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* ชื่อผู้ใช้งานระบบ (Username)'
                allowBlank: no
                bind: '{user.username}'
            ,
                xtype: 'textfield'
                fieldLabel: 'ชื่อ (Displayname)'
                allowBlank: yes
                bind: '{user.displayname}'
            ,
                # TODO ถ้า เพิ่มใหม่บังคับกรอก ถ้า edit check ว่ามีการแก้ไขมั้ย
                xtype: 'textfield'
                name: 'password'
                fieldLabel: 'รหัสผ่าน '
                # allowBlank: no
                minLength: 6
            ,
                xtype: 'combobox'
                fieldLabel: 'ประเทศ '
                name: 'country'
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                # queryParam: 'search'
                bind: '{user.country}'
                forceSelection: yes
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                # TODO use local field
                # now not sent data with this field
                xtype: 'textfield'
                fieldLabel: 'locale'
                allowBlank: yes
                bind: '{user.locale}'
            ,
                xtype: 'combobox'
                fieldLabel: 'สโมสร '
                name: 'club'
                displayField: 'name'
                valueField: 'id'
                queryMode: 'remote'
                queryParam: 'search'
                bind: '{user.club}'
                forceSelection: yes
                minChars: 1
                store:
                    type: 'store-clubs'
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
