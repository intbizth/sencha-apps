Ext.define 'Moboque.view.member.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-member-form'

    modal: yes
    scrollable: 'true'

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
            region: 'center'
            collapsible: no
            margin: '5 5 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            xtype: 'form'

            defaults:
                xtype: 'textfield'
                anchor : '100%'
                labelAlign: 'top'

            items: [
                fieldLabel: 'รหัสประจำตัวพนักงาน'
                emptyText: 'กรุณาระบุรหัสประจำตัวพนักงาน'
                allowBlank: yes
                bind: '{record.employee_id}'
            ,
                fieldLabel: 'ชื่อหน่วยงาน'
                emptyText: 'กรุณาระบุชื่อหน่วยงาน'
                allowBlank: yes
                bind: '{record.company}'
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
        ,
            region:'west'
            floatable: no
            margin: '5 0 0 5'
            scrollable: yes
            referenceHolder: yes
            width: 600
            xtype: 'form'

            defaults:
                anchor: '100%'
                labelAlign: 'top'
                xtype: 'textfield'
                msgTarget: 'side'

            items: [
                xtype: 'combo'
                fieldLabel: '<span style="color:red;">*</span> ชื่อกลุ่ม'
                emptyText: 'กรุณาเลือกกลุ่ม..'
                editable: no
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                msgTarget: 'side'
                bind:
                    store: '{groups}'
                    selection: '{group}'
            ,
                fieldLabel: '<span style="color:red;">*</span> ชื่อ'
                emptyText: 'กรุณาระบุชื่อจริง'
                bind: '{record.firstname}'
                allowBlank: no
                msgTarget: 'side'
            ,
                fieldLabel: '<span style="color:red;">*</span> นามสกุล'
                emptyText: 'กรุณาระบุนามสกุล'
                bind: '{record.lastname}'
                msgTarget: 'side'
            ,
                fieldLabel: '<span style="color:red;">*</span> รหัสประจำตัวประชาชน'
                emptyText: 'กรุณาระบุรหัสประจำตัวประชาชน'
                bind: '{record.card_id}'
                msgTarget: 'side'
                minLength: 13
                maxLength: 13
            ,
                xtype: 'textareafield'
                fieldLabel: '<span style="color:red;">*</span> ที่อยู่'
                emptyText: 'กรุณาระบุที่อยู่'
                bind: '{record.address}'
                msgTarget: 'side'
            ,
                fieldLabel: '<span style="color:red;">*</span> อีเมล์'
                emptyText: 'กรุณาระบุอีเมล์'
                vtype: 'email'
                bind: '{record.email}'
                msgTarget: 'side'
            ,
                fieldLabel: 'เบอร์โทรศัพท์'
                emptyText: 'กรุณาระบุเบอร์โทรศัพท์ '
                allowBlank: yes
                bind: '{record.phone_number}'
            ,
                fieldLabel: '<span style="color:red;">*</span> เบอร์มือถือ'
                bind: '{record.mobile_number}'
                emptyText: 'กรุณาระบุเบอร์มือถือ'
                maskRe: /[\d\-]/
                regex: /^\d{3}\d{3}\d{4}$/
                regexText: 'Must be in the format 0999999999'
                msgTarget: 'side'
            ]
        ,
            region: 'south'
            collapsible: no
            layout: 'fit'
            split: no
            bodyPadding: 0
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
        ]
