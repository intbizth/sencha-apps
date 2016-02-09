Ext.define 'Balltoro.view.match.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-match-list'

    requires: [
        'Ext.ux.form.SearchField'
    ]

    viewModel:
        type: 'vm-match'

    bind:
        store: '{matches}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    selModel:
        checkOnly: no
        selType: 'checkboxmodel'
        showHeaderCheckbox: yes
        pruneRemoved: yes

    listeners:
        selectionchange: 'onSelectionChange'

    reference: 'refMatchList'
    headerBorders: no
    title: 'แมทช์การแข่งขัน'

    columns: [
        text: 'สถานะ'
        dataIndex: 'state'
        cellWrap: yes
        width: 140
        align: 'center'
        xtype: 'widgetcolumn'
        widget:
            xtype: 'splitbutton'
            width: 120
            textAlign: 'left'
            listeners:
                afterrender: 'selectTransitions'
                textchange: 'selectTransitions'
    ,
        dataIndex: 'stadium'
        text: 'สนาม'
        flex: 1
        minWidth: 200
    ,
        xtype: 'datecolumn'
        formatter: 'date("d/m/Y")'
        dataIndex: 'start_time'
        text: 'วันแข่งขัน'
        align: 'center'
        width: 100
    ,
        xtype: 'datecolumn'
        formatter: 'date("H:i:m")'
        dataIndex: 'start_time'
        text: 'เวลาแข่งขัน'
        align: 'center'
        width: 100
    ,
        text: 'ทีมเจ้าบ้าน'
        width: 140
        renderer: (v, c, r) ->
            homeClub = r.getHomeClub()

            if homeClub?
                return homeClub.get 'name'
    ,
        text: 'ทีมเยือน'
        width: 140
        renderer: (v, c, r) ->
            awayClub = r.getAwayClub()

            if awayClub?
                return awayClub.get 'name'
    ,
        dataIndex: 'result'
        text: 'ผลการแข่งขัน'
        align: 'center'
    ]

    dockedItems: [
        xtype: 'toolbar'
        scrollable: yes
        default:
            xtype: 'button'
            width: 100
        items: [
            text: 'เพิ่มแมทช์'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            reference: 'refEditButton'
            text: 'แก้ไขแมทช์'
            iconCls: 'fa fa-pencil-square-o '
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            reference: 'refDeleteButton'
            text: 'ลบแมทช์'
            iconCls: 'fa fa-minus-square'
            disabled: yes
            handler: 'onDelete'
        ]
    ,
        xtype: 'toolbar'
        scrollable: yes
        border: 1
        default:
            xtype: 'button'
            width: 120
        items: [
            reference: 'refRefereeButton'
            text: 'กรรมการ'
            iconCls: 'fa fa-user'
            disabled: yes
            handler: 'onRefereeClick'
        ,
            '-'
        ,
            reference: 'refPersonalButton'
            text: 'นักเตะ'
            iconCls: 'fa fa-user-plus'
            disabled: yes
            handler: 'onPersonalClick'
        ,
            '-'
        ,
            reference: 'refEventButton'
            text: 'เหตุการณ์สำคัญ'
            iconCls: 'fa fa-futbol-o'
            disabled: yes
            handler: 'onEventClick'
        ,
            '-'
        ,
            reference: 'refSubstitutionButton'
            text: 'เปลี่ยนตัวนักเตะ'
            iconCls: 'fa fa-refresh'
            disabled: yes
            handler: 'onSubstitutionClick'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา '
            labelWidth: 50
            bind:
                store: '{matches}'
            margin: '0 10 0 0'
        ,
            reference: 'refAdvanceSearch'
            text: 'ค้นหาขั้นสูง'
            ui: 'default'
            handler: 'onAdvancedSearch'
        ]
    ]

    bbar:
       xtype: 'pagingtoolbar'
       scrollable: yes
       pageSize: 25
       bind:
           store: '{matches}'
       displayInfo: yes
