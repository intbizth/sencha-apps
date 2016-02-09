Ext.define 'Balltoro.view.news.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-news-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 420
    height: 480

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'vbox'
        scrollable: yes
        margin: '5 10 5 10'
        width: 380

        defaults:
            width: 380
            labelWidth: 70
            margin: '10 0 0 0'

        items: [
            xtype: 'textfield'
            name: 'search'
            fieldLabel: 'คำค้น '
            maxLength: 255
        ,
            xtype: 'combo'
            name: 'published'
            fieldLabel: 'ข่าวเผยแพร่ '
            store: [
                ['', 'ไม่ระบุ']
            ,
                [yes, 'เผยแพร่แล้ว']
            ,
                [no, 'ยังไม่ถูกเผยแพร่']
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'container'
            layout: 'vbox'
            margin: '20 0 0 0'
            items: [
                xtype: 'label'
                text: 'วันที่เผยแพร่'
            ,
                xtype: 'container'
                layout: 'hbox'
                margin: '10 0 0 30'
                width: 360
                items: [
                    xtype: 'datefield'
                    name: 'startdate'
                    width: 170
                    format: 'd/m/Y'
                    margin: '0 5 0 0'
                    fieldLabel: 'เริ่ม '
                    labelWidth: 40
                ,
                    xtype: 'datefield'
                    name: 'enddate'
                    width: 170
                    format: 'd/m/Y'
                    margin: '0 0 0 5'
                    fieldLabel: 'สิ้นสุด '
                    labelWidth: 40
                ]
            ]
        ,
            xtype: 'combo'
            name: 'featured'
            fieldLabel: 'ข่าวแนะนำ '
            store: [
                ['', 'ไม่ระบุ']
            ,
                [yes, 'เป็นข่าวแนะนำ']
            ,
                [no, "ไม่ใช่ข่าวแนะนำ"]
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'combo'
            name: 'hottest'
            fieldLabel: 'ข่าวร้อน '
            store: [
                ['', 'ไม่ระบุ']
            ,
                [yes, 'เป็นข่าวร้อน']
            ,
                [no, "ไม่ใช่ข่าวร้อน"]
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'combo'
            name: 'season'
            fieldLabel: 'ฤดูกาล '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-seasons'
                autoLoad: yes
        ,
            xtype: 'combo'
            name: 'club'
            fieldLabel: 'สโมสร '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-clubs'
                autoLoad: yes
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
