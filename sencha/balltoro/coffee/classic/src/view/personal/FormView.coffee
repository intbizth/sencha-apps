Ext.define 'Toro.view.personal.FormView',
    extend: 'Toro.view.base.Window'
    alias: 'widget.wg-personal-form'

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
                fieldLabel: '* ชื่อ '
                allowBlank: no
                bind: '{personal.firstname}'
                minLength: 6
                maxLength: 20
            ,
                xtype: 'textfield'
                fieldLabel: 'นามสกุล '
                allowBlank: yes
                bind: '{personal.lastname}'
                minLength: 6
                maxLength: 20
            ,
                xtype: 'textfield'
                fieldLabel: 'ชื่อเล่น '
                allowBlank: yes
                bind: '{personal.nickname}'
                minLength: 3
                maxLength: 10
            ,
                xtype: 'datefield'
                fieldLabel: 'วันเกิด '
                format: "d/m/Y"
                bind: '{personal.birthday}'
                allowBlank: yes
            ,
                xtype: 'textfield'
                fieldLabel: 'หมายเลขเสื้อ '
                allowBlank: yes
                bind: '{personal.no}'
                minLength: 1
                maxLength: 2
                vtype: 'alphanum'
            ,
                xtype: 'textfield'
                fieldLabel: 'ส่วนสูง '
                allowBlank: yes
                bind: '{personal.height}'
                minLength: 3
                maxLength: 3
                vtype: 'alphanum'
            ,
                xtype: 'textfield'
                fieldLabel: 'น้ำหนัก '
                allowBlank: yes
                bind: '{personal.weight}'
                minLength: 2
                maxLength: 3
                vtype: 'alphanum'
            ]
        ,
            region:'east'
            floatable: no
            margin: '5 5 0 0'
            scrollable: yes
            referenceHolder: yes
            width: 320
            xtype: 'form'

            defaults:
                width: 280
                labelAlign: 'top'

            items: [
                xtype: 'container'
                layout: 'vbox'
                referenceHolder: yes
                items: [
                    xtype: 'image'
                    reference: 'refImage'
                    width: 150
                    height: 150
                    alt: 'image'
                    style:
                        backgroundColor: '#d9d9d9'
                    margin: '22 0 0 0'
                    listeners:
                        beforerender: 'setImagePreview'
                ,
                    name: 'image'
                    xtype: 'fileuploadfield'
                    emptyText: 'กรุณาเลือกรูปภาพ'
                    fieldLabel: 'รูปภาพ '
                    labelAlign: 'top'
                    margin: '0 5 0 10'
                    buttonText: ''
                    buttonConfig:
                        iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                    bind: '{personal.image}'
                    listeners:
                        change: 'imageUploadChanged'
                ]
            ,
                xtype: 'combobox'
                fieldLabel: '* ประเภท '
                bind: '{personal.type}'
                reference: 'refPersonalTypeCombo'
                editable: no
                allowBlank: no
                store: [
                    ['coacher', 'coacher']
                    ['referee', 'referee']
                    ['player', 'player']
                ]
                listeners:
                    select: 'selectPersonalType'
            ,
                xtype: 'combobox'
                name: 'position'
                fieldLabel: '* ตำแหน่ง '
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                forceSelection: yes
                bind: '{personal.position}'
                allowBlank: no
                store:
                    type: 'store-personal-positions'
                    autoLoad: yes
            ,
                xtype: 'combobox'
                name: 'country'
                fieldLabel: 'ประเทศ '
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                allowBlank: yes
                forceSelection: yes
                bind: '{personal.country}'
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                xtype: 'combobox'
                name: 'club'
                fieldLabel: 'สโมสร '
                displayField: 'name'
                valueField: 'id'
                queryMode: 'remote'
                queryParam: 'search'
                minChars: 1
                allowBlank: yes
                forceSelection: yes
                bind: '{personal.club}'
                store:
                    type: 'store-clubs'
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
