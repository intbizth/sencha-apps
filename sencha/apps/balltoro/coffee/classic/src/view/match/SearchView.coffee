Ext.define 'Balltoro.view.match.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-match-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 440
    height: 460
    title: 'ค้นหาขั้นสูง'

    items:
        xtype: 'form'
        layout: 'vbox'
        scrollable: yes
        margin: '5 10 5 10'
        width: 400

        defaults:
            width: 400
            labelWidth: 90
            margin: '10 0 0 0'

        items: [
            xtype: 'combo'
            name: 'season'
            fieldLabel: 'ฤดูกาล '
            displayField: 'name'
            valueField: 'id'
            # มีจำนวนไม่มาก
            queryMode: 'local'
            store:
                type: 'store-seasons'
                autoLoad: yes
                pageSize: 50
        ,
            xtype: 'combo'
            name: 'homeClub'
            fieldLabel: 'ทีมเจ้าบ้าน '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'remote'
            queryParam: 'search'
            minChars: 1
            store:
                type: 'store-clubs'
        ,
            xtype: 'combo'
            name: 'awayClub'
            fieldLabel: 'ทีมเยือน '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'remote'
            queryParam: 'search'
            minChars: 1
            store:
                type: 'store-clubs'
        ,
            xtype: 'combo'
            name: 'country'
            fieldLabel: 'ประเทศ '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'remote'
            queryParam: 'search'
            minChars: 1
            store:
                type: 'store-countries'
        ,
            xtype: 'container'
            layout: 'vbox'
            margin: '20 0 0 0'
            items: [
                xtype: 'label'
                text: 'วันแข่งขัน'
            ,
                xtype: 'container'
                layout: 'hbox'
                margin: '10 0 0 50'
                width: 380
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
            name: 'endMatch'
            fieldLabel: 'แข่งขันจบ '
            store: [
                ['', 'ไม่ระบุ']
            ,
                [yes, 'ใช่']
            ,
                [no, "ไม่ใช่"]
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'textfield'
            name: 'stadium'
            fieldLabel: 'สนามแข่งขัน '
            maxLength: 255
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
