Ext.define 'Balltoro.view.competition.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-competition-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 420
    height: 280

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
            name: 'type'
            fieldLabel: 'ประเภท '
            store: [
                ['', 'ไม่ระบุ']
            ,
                ['LEAGUE', 'LEAGUE']
            ,
                ['CUP', 'CUP']
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'combo'
            name: 'country'
            fieldLabel: 'ประเทศ '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-countries'
                autoLoad: yes
                pageSize: 100
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
