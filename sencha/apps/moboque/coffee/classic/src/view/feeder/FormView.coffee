Ext.define 'Moboque.view.feeder.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-feeder-form'

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
            minLength: 2
            maxLength: 255

        items: [
            fieldLabel: '<span style="color:red;">*</span> ชื่อหัวข้อ'
            emptyText: 'กรุณาใส่ชื่อหัวข้อ'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> รายละเอียด'
            emptyText: 'กรุณาใส่รายละเอียด'
            bind: '{record.description}'
        ,
            fieldLabel: '<span style="color:red;">*</span> สถานะ'
            emptyText: 'กรุณาใส่สถานะ'
            bind: '{record.state}'
        ,
            xtype: 'fieldset'
            title: 'Upload Images'
            defaultType: 'textfield'
            items: [
                xtype: 'image'
                reference: 'refImage'
                height: 200
                alt: 'image'
                style:
                    backgroundColor: '#d9d9d9'
                margin: '0 0 0 10'
                listeners:
                    beforerender: 'setImagePreview'
            ,
                name: 'image'
                xtype: 'fileuploadfield'
                emptyText: 'Select an image'
                fieldLabel: 'Image '
                labelAlign: 'top'
                anchor: '100%'
                margin: '0 5 0 10'
                buttonText: ''
                buttonConfig:
                    iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                bind: '{record.image}'
                listeners:
                    change: 'imageUploadChanged'
            ]
        ]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmitWithImage'
            disabled: yes
            formBind: yes
        ]
