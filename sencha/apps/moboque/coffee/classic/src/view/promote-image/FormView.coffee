Ext.define 'Moboque.view.promote-image.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-promote-image-form'

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
            allowBlank: no

        items: [
            fieldLabel: 'คำอธิบายภาพ'
            emptyText: 'คำธิบายภาพ'
            bind: '{record.description}'
        ,
            xtype: 'combo'
            editable: no
            fieldLabel: 'ภาพของโปรโมท'
            emptyText: 'กรุณาเลือก....'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{promoteList}'
                selection: '{promote}'
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
                    beforerender: 'setImagePreview'
#                    click:
#                        element: 'el'
#                        fn: 'onClickImage'
            ,
                name: 'image'
                xtype: 'fileuploadfield'
                emptyText: 'Select an image'
                fieldLabel: 'Image '
                labelAlign: 'top'
                margin: '0 5 0 10'
                buttonText: ''
                buttonConfig:
                    iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                bind: '{image}'
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
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
