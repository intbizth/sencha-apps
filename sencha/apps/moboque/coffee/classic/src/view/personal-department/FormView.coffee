Ext.define 'Moboque.view.personal-department.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-personal-department-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        items: [
            xtype: 'textfield'
            width: 360
            fieldLabel: '<span style="color:red;">*</span> ชื่อแผนก'
            labelAlign: 'top'
            emptyText: 'กรุณากรอกชื่อแผนก'
            allowBlank: no
            bind: '{record.title}'
        ,
            xtype: 'fieldset'
            title: 'Upload Images'
            defaultType: 'textfield'
            width: 360
            items: [
                xtype: 'image'
                reference: 'refImage'
                height: 200
                alt: 'thumbnail'
                style:
                    backgroundColor: '#d9d9d9'
                margin: '0 0 0 10'
                listeners:
                    beforerender: 'setImagePreview'
            ,
                name: 'thumbnail'
                xtype: 'fileuploadfield'
                emptyText: 'Select an image'
                fieldLabel: 'Image '
                labelAlign: 'top'
                anchor: '100%'
                margin: '0 5 0 10'
                buttonText: ''
                buttonConfig:
                    iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                bind: '{record.thumbnail}'
                listeners:
                    change: 'imageUploadChanged'
            ]
        ]

        buttons: [
            text: 'Preview'
            handler: 'applyImage'
            reference: 'refApply'
            hidden: yes
        ,
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmitWithImage'
            disabled: yes
            formBind: yes
        ]
