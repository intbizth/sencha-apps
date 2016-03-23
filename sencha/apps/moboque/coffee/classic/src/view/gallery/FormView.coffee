Ext.define 'Moboque.view.gallery.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-gallery-form'

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

        items: [
            xtype: 'combo'
            fieldLabel: '<span style="color:red;">*</span> ชื่อหมวดหมู่รูปภาพ'
            emptyText: 'กรุณาเลือกหมวดหมู่รูปภาพ'
            editable: no
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{galleryCategories}'
                selection: '{galleryCategory}'
        ,
            fieldLabel: '<span style="color:red;">*</span> ชื่อ'
            emptyText: 'กรุณาระบุชื่อรูปภาพ'
            bind: '{record.title}'
        ,
            fieldLabel: '<span style="color:red;">*</span> คำบรรยาย'
            emptyText: 'กรุณากรอกคำบรรยาย'
            bind: '{record.sub_title}'
        # ,
        #     xtype: 'fieldset'
        #     title: 'Upload Images'
        #     defaultType: 'textfield'
        #     items: [
        #         xtype: 'image'
        #         reference: 'refImage'
        #         alt: 'image'
        #         style:
        #             backgroundColor: '#d9d9d9'
        #         margin: '0 0 0 10'
        #         listeners:
        #             beforerender: 'setImagePreview'
        #     ,
        #         name: 'image'
        #         xtype: 'fileuploadfield'
        #         emptyText: 'Select an image'
        #         fieldLabel: 'Image '
        #         labelAlign: 'top'
        #         anchor: '100%'
        #         margin: '0 5 0 10'
        #         buttonText: ''
        #         buttonConfig:
        #             iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
        #         bind: '{record.image}'
        #         listeners:
        #             change: 'imageUploadChanged'
        #     ]
        ]

        buttons: [
            # text: 'Preview'
            # handler: 'applyImage'
            # reference: 'refApply'
            # hidden: yes
        # ,
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
