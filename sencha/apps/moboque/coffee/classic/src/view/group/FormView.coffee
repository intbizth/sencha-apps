Ext.define 'Moboque.view.group.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-group-form'

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
            labelAlign: 'top'
            msgTarget: 'under'
            width: 360

        items: [
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่องานอีเวนท์'
            emptyText: 'กรุณาเลือกอีเวนท์..'
            editable: no
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            required: yes
            bind:
                store: '{events}'
                selection: '{event}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อกลุ่ม'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            required: yes
            bind: '{record.name}'
        ,
            xtype: 'colorfield'
            fieldLabel: '<span style="color:red;">*</span> สีกลุ่ม'
            format: '#hex6'
            required: yes
            bind: '{record.color}'
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
            handler: 'onSubmitWithImage'
            disabled: yes
            formBind: yes
        ]
