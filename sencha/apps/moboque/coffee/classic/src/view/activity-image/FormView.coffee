Ext.define 'Moboque.view.activity-image.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-activity-image-form'

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
            fieldLabel: 'รูปภาพของกิจกรรม'
            emptyText: 'กรุณาเลือกกิจกรรม..'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{activities}'
                selection: '{activity}'
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
