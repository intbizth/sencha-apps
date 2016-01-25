Ext.define 'Toro.view.competition.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-competition-list'

    viewModel:
        type: 'vm-competition'

    bind:
        store: '{competitions}'

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

    reference: 'refCompetitionList'
    headerBorders: no
    title: 'ลีก'

    defaultAlign: 'center'

    columns: [
        dataIndex: 'name'
        text: 'ชื่อ'
        flex: 1
        minWidth: 200
    ,
        dataIndex: 'code'
        text: 'รหัส'
        width: 120
    ,
        dataIndex: 'type'
        text: 'ประเภท'
        width: 80
    ,
        dataIndex: 'country'
        text: 'ประเทศ'
        minWidth: 200
        renderer: (v, c, r) ->
            if country = r.getCountry()
                return country.get 'name'

            if country = r.get 'country'
                return country.name
    ,
        xtype: 'booleancolumn'
        dataIndex: 'enabled'
        text: 'เปิดใช้งาน'
        trueText: '<span style="color:green;">เปิดการใช้งาน</span>'
        falseText: '<span style="color:red;">ปิดการใช้งาน</span>'
    ]

    tbar:
        scrollable: yes
        defaultButtonUI: 'default'
        items: [
            xtype: 'button'
            text: 'เพิ่มลีก'
            iconCls: 'fa fa-pencil'
            ui: 'default-toolbar'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไขลีก'
            iconCls:'fa fa-pencil-square-o '
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบลีก'
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
                store: '{competitions}'
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
            store: '{competitions}'
        displayInfo: yes
