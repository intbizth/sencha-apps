Ext.define 'Balltoro.view.personal.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-personal-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 420
    height: 400

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
            fieldLabel: 'คำค้นหา'
            maxLength: 255
        ,
            xtype: 'combobox'
            name: 'type'
            fieldLabel: 'ประเภท'
            store: [
                ['', 'ไม่ระบุ']
            ,
                ['manager', 'manager']
            ,
                ['coacher', 'coacher']
            ,
                ['referee', 'referee']
            ,
                ['player', 'player']
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'combobox'
            name: 'country'
            fieldLabel: 'ประเทศ'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-countries'
                autoLoad: yes
        ,
            xtype: 'combobox'
            name: 'club'
            fieldLabel: 'สโมสร '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-clubs'
                autoLoad: yes
        ,
            xtype: 'combobox'
            name: 'position'
            fieldLabel: 'ตำแหน่ง'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-personal-positions'
                autoLoad: yes
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
