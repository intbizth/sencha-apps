Ext.define 'Balltoro.view.match.event.GoalListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-match-event-goallist'

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
        preSaveEvent: (grid, record) ->
            eventType = record.getType().get('id')

            if eventType == 18
                record.set 'isTouch', yes

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
        renderer: (value, meta, record, row, column, store, view) ->
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
        xtype: 'checkcolumn'
        text: 'OwnGoal'
        dataIndex: '_qualifierOwnGoal'
        width: 100
        stopSelection: no
        editor:
            xtype: 'checkbox'
    ]

    tbar:
        height: 50
        defaults:
            ui: 'default'
        reference: 'refGoalToolbar'

        items: [
            xtype: 'title'
            text: 'การยิงประตู'
        ,
            xtype: 'button'
            text: 'เพิ่ม'
            handler: 'onAddGoal'
        ,
            xtype: 'button'
            text: 'ลบ'
            handler: 'onDeleteEventRecord'
        ]
