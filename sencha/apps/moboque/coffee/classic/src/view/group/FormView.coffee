Ext.define 'Moboque.view.group.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-group-form'

    width: 600
    modal: yes
    scrollable: 'true'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'anchor'
        referenceHolder: yes
        margin: '10 10 10 10'
        modelValidation: yes

        # TODO allowBlank is not working !
        defaults:
            xtype: 'textfield'
            anchor: '100%'
            labelAlign: 'top'
            allowBlank: no

        items: [
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่องานอีเวนท์'
            emptyText: 'กรุณาเลือกอีเวนท์..'
            editable: no
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{events}'
                selection: '{event}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อกลุ่ม'
            emptyText: 'กรุณาระบุชื่องกลุ่ม'
            bind: '{record.name}'
        ,
            xtype: 'colorfield'
            fieldLabel: '<span style="color:red;">*</span> สีกลุ่ม'
            format: '#hex6'
            allowBlank: no
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
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
