Ext.define 'Toro.view.news.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-news-list'

    requires: [
        'Ext.ux.form.SearchField'
    ]

    viewModel:
        type: 'vm-news'

    bind:
        store: '{news}'

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

    reference: 'refNewsList'
    headerBorders: no
    title: 'ข่าว'

    columns: [
        text: 'สถานะ'
        dataIndex: 'state'
        cellWrap: yes
        width: 140
        xtype: 'widgetcolumn'
        widget:
            xtype: 'splitbutton'
            width: 120
            textAlign: 'left'
            listeners:
                afterrender: 'selectTransitions'
                textchange: 'selectTransitions'
    ,
        dataIndex: 'headline'
        text: 'หัวข้อ'
        minWidth: 200
        flex: 1
    ,
        text: 'สโมสร'
        width: 150
        renderer: (v, c, r) ->
            club = r.getClub()

            if club?
                return club.get('name')
    ,
        xtype: 'booleancolumn'
        dataIndex: 'featured'
        text: 'ข่าวแนะนำ'
        trueText: 'Featured !'
        falseText: ''
        width: 100
    ,
        xtype: 'booleancolumn'
        dataIndex: 'hottest'
        text: 'ข่าวร้อน'
        trueText: 'Hot !'
        falseText: ''
        width: 100
    ,
        xtype: 'datecolumn'
        formatter: 'date("d/m/Y")'
        dataIndex: 'published_date'
        text: 'วันที่เผยแพร่'
        width: 100
    ]

    dockedItems: [
        xtype: 'toolbar'
        scrollable: yes
        items: [
            xtype: 'button'
            text: 'เพิ่มข่าว'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไขข่าว'
            iconCls:'fa fa-pencil-square-o '
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบข่าว'
            iconCls:'fa fa-minus-square'
            disabled: yes
            handler: 'onDelete'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refFeaturedButton'
            text: 'ข่าวแนะนำ'
            iconCls: 'fa fa-bullhorn'
            enableToggle: yes
            disabled: yes
            handler: 'selectFeatured'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refHottestButton'
            text: 'ข่าวร้อน'
            iconCls: 'fa fa-rss'
            enableToggle: yes
            disabled: yes
            handler: 'selectHottest'
        ]
    ,
        xtype: 'toolbar'
        scrollable: yes
        border: 1
        items: [
            xtype: 'button'
            reference: 'refCategoryButton'
            text: 'จัดการหมวดหมู่ข่าว'
            ui: 'default'
            iconCls: 'fa fa-folder'
            handler: 'onManageCategories'
        ,
            '->'
        # TODO search with local
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา '
            labelWidth: 50
            bind:
                store: '{news}'
            margin: '0 10 0 0'
        ,
            xtype: 'button'
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
            store: '{news}'
        displayInfo: yes

    #TODO not use paginator, but will use grid buffer
