Ext.define 'Toro.view.season.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-season-list'

    viewModel:
        type: 'vm-season'

    bind:
        store: '{seasons}'

    viewConfig:
        emptyText: 'Empty Data'
        deferEmptyText: no
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes

    selModel:
        checkOnly: no
        selType: 'checkboxmodel'
        showHeaderCheckbox: yes
        pruneRemoved: yes

    listeners:
        selectionchange: 'onSelectionChange'

    headerBorders: no
    title: 'ฤดูกาล'
    reference: 'refSeasonList'

    columns: [
        dataIndex: 'name'
        text: 'ฤดูกาล'
        minWidth: 200
        flex: 1
    ,
        dataIndex: 'code'
        text: 'รหัส'
        width: 100
    ,
        dataIndex: 'competition'
        text: 'ลีก'
        width: 200
        renderer: (v, c, r) ->
            if competition = r.getCompetition()
                return competition.get 'name'

            if competition = r.get 'competition'
                return competition.name
    ,
        xtype: 'datecolumn'
        dataIndex: 'start_date'
        text: 'เริ่มการแข่งขัน'
        format:'d/m/Y'
        width: 150
    ,
        xtype: 'datecolumn'
        dataIndex: 'end_date'
        text: 'จบการแข่งขัน'
        format:'d/m/Y'
        width: 150
    ]

    tbar:
        scrollable: yes
        defaultButtonUI: 'default'
        items: [
            xtype: 'button'
            text: 'เพิ่มฤดูกาล'
            iconCls: 'fa fa-pencil'
            ui: 'default-toolbar'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไขฤดูกาล'
            iconCls:'fa fa-pencil-square-o '
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบฤดูกาล'
            iconCls:'fa fa-minus-square'
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา '
            labelWidth: 50
            bind:
                store: '{seasons}'
            margin: '0 10 0 0'
        ,
            xtype: 'button'
            reference: 'refAdvanceSearch'
            text: 'ค้นหาขั้นสูง'
            ui: 'default'
            handler: 'onAdvancedSearch'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{seasons}'
        displayInfo: yes
