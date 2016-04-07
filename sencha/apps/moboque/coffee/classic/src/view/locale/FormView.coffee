Ext.define 'Moboque.view.locale.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-locale-form'

    width: 600
    modal: yes

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
            anchor: '100%'
            labelAlign: 'top'

        items: [
            fieldLabel: 'ชื่อสถานที่-แหล่งท่องเที่ยว'
            emptyText: 'กรุณาระบุชื่อสถานที่, ร้าน หรือ แหล่งท่องเที่ยว'
            bind: '{record.title}'
        ,
            fieldLabel: 'คำอธิบาย'
            emptyText: 'ระบุคำอธิบายสถานที่ หรือ แหล่งท่องเที่ยว'
            bind: '{record.description}'
        ,
            xtype: 'combobox'
            fieldLabel: 'ประเภทของสถานที่'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{localeCategories}'
                selection: '{localeCategory}'
        ,
            xtype: 'fieldset'
            title: 'Upload Images'
            defaultType: 'textfield'
            defaults:
                anchor: '100%'
            items: [
                xtype: 'image'
                reference: 'refImage'
                width: 60
                height: 40
                alt: 'image'
                style:
                    backgroundColor: '#d9d9d9'
                margin: '22 0 0 0'
                listeners:
#                    beforerender: 'setImagePreview'
                    click:
                        element: 'el'
                        fn: 'onClickImage'
            ,
                allowBlank: no
                fieldLabel: 'ชื่อ'
            ,
                xtype: 'filefield'
                emptyText: 'คลิกไอคอน เพื่อเลือกรูปที่จะ Upload.'
                fieldLabel: 'รูป'
                name: 'photo-path'
                buttonText: ''
                buttonConfig:
                    iconCls: 'fa fa-photo'
            ,
                xtype: 'button'
                text: 'ลบรูป'
            ]
        ]

        buttons: [
            text: 'เพิ่มรูป'
            handler: 'onAddImage'
        ,
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
