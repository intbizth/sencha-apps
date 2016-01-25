Ext.define 'Toro.view.club.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-club-search'

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
            name: 'country'
            fieldLabel: 'ประเทศ'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            forceSelection: yes
            bind: '{club.country}'
            store:
                type: 'store-countries'
                autoLoad: yes
                pageSize: 100
        ,
            xtype: 'combobox'
            name: 'clubClass'
            fieldLabel: 'ระดับสโมสร'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            forceSelection: yes
            bind: '{club.clubClass}'
            store:
                type: 'store-club-classes'
                autoLoad: yes
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
