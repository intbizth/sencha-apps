Ext.define 'Balltoro.view.club.FormView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-club-form'

    layout: 'fit'
    modal: yes
    closable: yes

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
            margin: '5 0 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            xtype: 'form'

            defaults:
                anchor : '100%'
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* ชื่อสโมสร '
                allowBlank: no
                minLength: 6
                maxLength: 50
                bind: '{club.name}'
            ,
                xtype: 'textfield'
                fieldLabel: 'ชื่อย่อสโมสร '
                allowBlank: yes
                bind: '{club.short_name}'
            ,
                xtype: 'textfield'
                fieldLabel: '* ฉายา '
                allowBlank: no
                bind: '{club.signature_name}'
            ,
                xtype: 'textfield'
                fieldLabel: 'ชื่อสนาม '
                allowBlank: yes
                bind: '{club.stadium_name}'
            ,
                xtype: 'textfield'
                fieldLabel: 'ที่อยู่ '
                allowBlank: yes
                bind: '{club.location}'
            ,
                xtype: 'textfield'
                fieldLabel: 'เว็บไซต์ '
                allowBlank: yes
                emptyText: 'https://www.balltoro.com'
                bind: '{club.website}'
                vtype: 'url'
            ,
                xtype: 'textfield'
                fieldLabel: 'อีเมล์ '
                allowBlank: yes
                emptyText: 'hi@balltoro.com'
                bind: '{club.email}'
                vtype: 'email'
            ,
                xtype: 'textfield'
                fieldLabel: 'เบอร์โทร '
                allowBlank: yes
                bind: '{club.tel}'
                emptyText: '021159907'
            ]
        ,
            region:'east'
            floatable: no
            margin: '5 5 0 0'
            scrollable: yes
            referenceHolder: yes
            width: 400
            xtype: 'form'

            defaults:
                width: 380
                labelAlign: 'top'

            items: [
                xtype: 'container'
                layout: 'hbox'
                referenceHolder: yes
                items: [
                    xtype: 'image'
                    reference: 'refLogo'
                    alt: 'image'
                    width: 60
                    height: 40
                    style:
                        backgroundColor: '#d9d9d9'
                    margin: '22 0 0 0'
                    listeners:
                        beforerender: 'setImagePreview'
                ,
                    name: 'logo'
                    xtype: 'fileuploadfield'
                    fieldLabel: 'โลโก้ '
                    labelAlign: 'top'
                    margin: '0 5 0 10'
                    buttonText: ''
                    buttonConfig:
                        iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                    bind: '{club.logo}'
                    listeners:
                        change: 'logoUploadChanged'
                ]
            ,
                xtype: 'container'
                layout: 'hbox'
                referenceHolder: yes
                items: [
                    xtype: 'image'
                    reference: 'refStadiumImage'
                    width: 60
                    height: 40
                    alt: 'image'
                    style:
                        backgroundColor: '#d9d9d9'
                    margin: '22 0 0 0'
                    listeners:
                        beforerender: 'setImagePreview'
                ,
                    name: 'stadium_image'
                    xtype: 'fileuploadfield'
                    fieldLabel: 'รูปสนาม '
                    labelAlign: 'top'
                    margin: '0 5 0 10'
                    buttonText: ''
                    buttonConfig:
                        iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                    bind: '{club.stadium_image}'
                    listeners:
                        change: 'stadiumImageUploadChanged'
                ]
            ,
                xtype: 'combobox'
                name: 'country'
                fieldLabel: '* ประเทศ '
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                allowBlank: no
                forceSelection: yes
                bind: '{club.country}'
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                xtype: 'combobox'
                name: 'clubClass'
                fieldLabel: '* ClubClass '
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                allowBlank: no
                forceSelection: yes
                bind: '{club.clubClass}'
                store:
                    type: 'store-club-classes'
                    autoLoad: yes
            ,
                xtype: 'textfield'
                fieldLabel: 'ปีที่ก่อตั้ง '
                bind: '{club.est_year}'
                allowBlank: yes
                minLength: 4
                maxLength: 4
                vtype: 'alphanum'
            ,
                xtype: 'numberfield'
                fieldLabel: 'ความจุของสนาม '
                bind: '{club.stadium_capacity}'
                allowBlank: yes
                minValue: 0
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
                handler: 'onSubmit'
                disabled: yes
                formBind: yes
            ]
        ]
