Ext.define 'Moboque.view.personal.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-personal-form'

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
                xtype: 'fieldset'
                title: 'Upload Images'
                defaultType: 'textfield'
                items: [
                    xtype: 'image'
                    reference: 'refImage'
                    height: 200
                    alt: 'image'
                    src: 'http://placehold.it/350x150'
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

            items: [
                fieldLabel: '<span style="color:red;">*</span> ชื่อ'
                emptyText: 'กรุณาระบุชื่อ'
                bind: '{record.name}'
            ,
                fieldLabel: '<span style="color:red;">*</span> นามสกุล'
                emptyText: 'กรุณาระบุนามสกุล'
                bind: '{record.surname}'
            ,
                xtype: 'combo'
                editable: no
                fieldLabel: '<span style="color:red;">*</span> ชื่อแผนก'
                displayField: 'title'
                valueField: 'id'
                queryMode: 'local'
                bind:
                    store: '{personalDepartments}'
                    selection: '{personalDepartment}'
            ,
                fieldLabel: '<span style="color:red;">*</span> ตำแหน่ง'
                emptyText: 'กรุณาระบุตำแหน่ง'
                bind: '{record.position}'
            ,
                xtype: 'textareafield'
                fieldLabel: '<span style="color:red;">*</span> ที่อยู่'
                emptyText: 'กรุณากรอกรายละเอียดที่อยู่'
                bind: '{record.address}'
            ,
                xtype: 'datefield'
                fieldLabel: '<span style="color:red;">*</span> วันเกิด'
                emptyText: 'กรุณาระบุวันเกิด'
                format: 'd-m-Y'
                bind: '{record.birth_date}'
            ,
                fieldLabel: '<span style="color:red;">*</span> เบอร์โทรติดต่อ'
                emptyText: 'กรุณาใส่เบอร์โทรติดต่อ'
                bind: '{record.tel}'
            ,
                fieldLabel: '<span style="color:red;">*</span> อีเมล์'
                emptyText: 'กรุณาใส่ชื่ออีเมล์'
                vtype: 'email'
                bind: '{record.email}'
            ]
        ,
            region: 'south'
            collapsible: no
            layout: 'fit'
            split: no
            bodyPadding: 0
            buttons: [
                text: 'ยกเลิก'
                handler: 'onCancel'
            ,
                text: 'บันทึก'
                handler: 'onSubmitWithImage'
                disabled: yes
                formBind: yes
            ]
        ]
