Ext.define 'Toro.view.user.SearchView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-user-search'

    layout: 'vbox'
    modal: yes
    closable: yes
    scrollable: yes
    width: 420
    height: 300

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
            name: 'enabled'
            fieldLabel: 'สถานะ'
            store: [
                ['', 'ไม่ระบุ']
            ,
                [yes, 'เปิดการใช้งาน']
            ,
                [no, 'ปิดการใช้งาน']
            ]
            value: ['']
            forceSelection: yes
        ,
            xtype: 'combo'
            name: 'country'
            value: 1
            fieldLabel: 'ประเทศ'
            displayField: 'name'
            valueField: 'id'
            queryMode: 'local'
            store:
                type: 'store-countries'
                autoLoad: yes
        ]

    buttons: [
        text: 'ค้นหา'
        handler: 'onSearch'
    ,
        text: 'ยกเลิก'
        handler: 'onCancel'
    ]
