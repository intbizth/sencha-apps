Ext.define 'Toro.view.match.event.CardListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-match-event-cardlist'

    store:
        type: 'store-match-events'

    headerBorders: no
    header: no
    selModel: 'rowmodel'

    plugins: [
        ptype: 'rowediting'
        clicksToEdit: 1
    ]

    listeners:
        edit: 'updateEventRecord'
        canceledit: 'cancelEditRecord'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no
        successSaveEvent: (records, isNewRecord, grid, substitutionRecord) ->
            grid.unmask()

    columns: [
        dataIndex: 'minute'
        text: 'นาที'
        width: 80
        align: 'center'
        editor:
            xtype: 'numberfield'
            minValue: 0
    ,
        dataIndex: 'second'
        text: 'วินาที'
        width: 80
        align: 'center'
        editor:
            xtype: 'numberfield'
            minValue: 0
            maxValue: 59
    ,
        dataIndex: 'side'
        text: 'Side'
        width: 100
        editor:
            xtype: 'combo'
            forceSelection: yes
            store: [
                ['home', 'home']
            ,
                ['away', 'away']
            ]
    ,
        text: 'นักเตะ'
        flex: 1
        minWidth: 200
        dataIndex: 'player'
        renderer: (value, meta, record) ->
            player = record.getPlayer()

            if player?
                return player.get 'fullname'
        editor:
            xtype: 'combo'
            forceSelection: yes
            displayField: 'fullname'
            queryMode: 'local'
            valueField: 'id'
            allowBlank: no
            listeners:
                focus: 'onEditorPlayerFocus'
    ,
        text: 'ประเภท'
        dataIndex: '_qualifierCard'
        editor:
            xtype: 'combo'
            forceSelection: yes
            store: [
                ['Red', 'Red']
            ,
                ['Yellow', 'Yellow']
            ,
                ['SecondYellow', 'Second Yellow']
            ]
    ]

    tbar:
        height: 50
        defaults:
            ui: 'default'

        items: [
            xtype: 'title'
            text: 'ใบเหลือง/ใบแดง'
        ,
            xtype: 'button'
            text: 'เพิ่ม'
            handler: 'onAddCard'
        ,
            xtype: 'button'
            text: 'ลบ'
            handler: 'onDeleteEventRecord'
        ]
