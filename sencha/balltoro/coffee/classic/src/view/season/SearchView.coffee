Ext.define 'Toro.view.season.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-season-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 420
    height: 320

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
            labelWidth: 100
            margin: '10 0 0 0'

        items: [
            xtype: 'textfield'
            name: 'search'
            fieldLabel: 'คำค้น '
            maxLength: 255
        ,
            xtype: 'combo'
            name: 'competition'
            fieldLabel: 'ลีก '
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-competitions'
                autoLoad: yes
        ,
            xtype: 'datefield'
            name: 'startDate'
            fieldLabel: 'เริ่มการแข่งขัน '
            format: 'd/m/Y'
        ,
            xtype: 'datefield'
            name: 'endDate'
            fieldLabel: 'จบการแข่งขัน '
            format: 'd/m/Y'
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
