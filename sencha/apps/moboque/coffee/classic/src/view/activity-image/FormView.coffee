Ext.define 'Moboque.view.activity-image.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-activity-image-form'

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

        items: [
            xtype: 'combo'
            editable: no
            fieldLabel: 'รูปภาพของกิจกรรม'
            emptyText: 'กรุณาเลือกกิจกรรม'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{activities}'
                selection: '{activity}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำอธิบายภาพ'
            emptyText: 'คำธิบายภาพ'
            bind: '{record.description}'
            required: yes
            msgTarget: 'under'
        ,
            xtype: 'fieldset'
            title: 'Upload Images'
            defaultType: 'textfield'
            defaults:
                anchor: '100%'
            items: [
                xtype: 'image'
                reference: 'refImage'
                alt: 'image'
                style:
                    backgroundColor: '#d9d9d9'
                margin: '22 0 0 0'
                listeners:
                    beforerender: 'setImagePreview'
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
            handler: 'onSubmitWithImage'
            disabled: yes
            formBind: yes
        ]
