Ext.define 'Balltoro.view.news.FormView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-news-form'

    requires: [
        'Ext.uxs.html.editor.TinyMCE'
    ]

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
                fieldLabel: '* หัวข้อ '
                blankText: 'กรุณาระบุ..'
                bind: '{news.headline}'
                emptyText: 'กรุณาใส่หัวข้อ..'
                allowBlank: no
                maxLength: 50
            ,
                xtype: 'textareafield'
                fieldLabel: 'หัวข้อย่อย '
                bind: '{news.subhead}'
                maxLength: 100
            ,
                xtype: 'textareafield'
                fieldLabel: '* รายละเอียด '
                emptyText: 'กรุณาใส่รายละเอียด ..'
                allowBlank: no
                bind: '{news.description}'
            ,
                xtype: 'textareafield'
                fieldLabel: 'เหตุการณ์สำคัญ '
                bind: '{news.highlight}'
            ,
                xtype: 'tinymcefield'
                fieldLabel: '* เนื้อหา '
                name: 'content'
                emptyText: 'กรุณาใส่เนื้อหา..'
                allowBlank: no
                height: 300
                listeners:
                    beforerender: 'onContentBeforeRender'
                # TODO insert image
                # tinyConfig:
                #     file_browser_callback: (field_name, url, type, win) ->
                        # tinymce.activeEditor.windowManager.open
                        #     file: '/elfinder'
                        #     title: 'Finder'
                        #     width: 900
                        #     height: 450
                        #     resizable: 'yes'
                        # ,
                        #     setUrl: (url) -> win.document.getElementById(field_name).value = url

                        # return no
            ,
                xtype: 'tinymcefield'
                fieldLabel: 'เนื้อหาพิเศษ '
                name: 'extraContent'
                emptyText: 'กรุณาใส่เนื้อหา..'
                allowBlank: yes
                height: 300
                listeners:
                    beforerender: 'onExtraContentBeforeRender'
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
                xtype: 'combo'
                name: 'competition'
                fieldLabel: 'ลีก '
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind: '{news.competition}'
                store:
                    type: 'store-competitions'
                    autoLoad: yes
                listeners:
                    select: 'selectCompetition'
            ,
                xtype: 'combo'
                fieldLabel: 'ฤดูกาล '
                name: 'season'
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                forceSelection: yes
                bind:'{news.season}'
                store:
                    type: 'store-seasons'
                    autoLoad: yes
            ,
                xtype: 'combo'
                fieldLabel: '* หมวดหมู่ข่าว '
                name: 'category'
                allowBlank: no
                displayField: 'name'
                valueField: 'id'
                queryMode: 'remote'
                queryParam: 'search'
                minChars: 1
                forceSelection: yes
                bind: '{news.category}'
                store:
                    type: 'store-news-categories'
            ,
                xtype: 'tagfield'
                fieldLabel: 'สโมสรที่เกี่ยวข้อง '
                name: 'related_clubs'
                allowBlank: yes
                displayField: 'name'
                valueField: 'id'
                queryMode: 'remote'
                queryParam: 'search'
                minChars: 1
                bind: '{news.related_clubs}'
                multiSelect: yes
                # filterPickList not working.
                # because 1. use bind data.
                #         2. store filter was override (ft.property = undefine).
                # filterPickList: yes
                store:
                    type: 'store-clubs'
            ,
                xtype: 'checkboxfield'
                boxLabel: 'ข่าวแนะนำ '
                bind: '{news.featured}'
            ,
                xtype: 'checkboxfield'
                boxLabel: 'ข่าวร้อน '
                bind: '{news.hottest}'
            ,
                xtype: 'container'
                layout: 'hbox'
                defaults:
                    labelAlign: 'top'
                items: [
                    xtype: 'datefield'
                    name: 'date'
                    fieldLabel: 'วันที่เผยแพร่ '
                    submitFormat: 'Y-m-d'
                    format: 'Y-m-d'
                    bind: '{publishedDate}'
                    margin: '0 5 0 0'
                    width: 170
                ,
                    xtype: 'timefield'
                    name: 'time'
                    fieldLabel: 'เวลาเผยแพร่ '
                    format: 'H:i'
                    bind: '{publishedTime}'
                    margin: '0 0 0 5'
                    width: 100
                ]
            ,
                xtype: 'textfield'
                fieldLabel: 'แหล่งอ้างอิง '
                bind: '{news.credit}'
            ,
                xtype: 'textfield'
                fieldLabel: 'เว็บไซต์อ้างอิง '
                emptyText: 'https://www.balltoro.com'
                bind: '{news.credit_url}'
                vtype: 'url'
            ,
                xtype: 'tagfield'
                fieldLabel: 'Tags '
                name: 'tags'
                bind: '{news.tags}'
                store:
                    type: 'store-tags'
                    autoLoad: yes
                    pageSize: 100
                displayField: 'name'
                valueField: 'name'
                queryMode: 'local'
                multiSelect: yes
                createNewOnEnter: yes
                # filterPickList not working.
                # because 1. use bind data.
                #         2. store filter was override (ft.property = undefine).
                # filterPickList: yes
            ,
                xtype: 'container'
                layout: 'hbox'
                referenceHolder: yes
                items: [
                    xtype: 'image'
                    reference: 'refCover'
                    alt: 'image'
                    width: 60
                    height: 40
                    style:
                        backgroundColor: '#d9d9d9'
                    margin: '22 0 0 0'
                    listeners:
                        beforerender: 'setImagePreview'
                ,
                    name: 'cover'
                    xtype: 'fileuploadfield'
                    emptyText: 'Select an cover'
                    fieldLabel: 'Cover '
                    labelAlign: 'top'
                    margin: '0 5 0 10'
                    buttonText: ''
                    buttonConfig:
                        iconCls: 'right-icon hot-icon x-fa fa-file-image-o'
                    bind: '{news.cover}'
                    listeners:
                        change: 'coverUploadChanged'
                ]
            ,
                xtype: 'container'
                layout: 'hbox'
                referenceHolder: yes
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
                        click:
                            element: 'el'
                            fn: 'onClickImage'
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
                    bind: '{news.image}'
                    listeners:
                        change: 'imageUploadChanged'
                ]
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
