Ext.define 'Moboque.view.news.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-news-list'

    bind:
        store: '{news}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'ข่าว'
    reference: 'refNewsList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'สถานะ'
        dataIndex: 'state'
    ,
        text: 'หัวข้อข่าว'
        dataIndex: 'title'
        minWidth: 300
        flex: 1
    ,
        text: 'คำอธิบาย'
        dataIndex: 'subTitle'
        minWidth: 300
        flex: 1
    ,
        text: 'ประเภท'
        minWidth: 300
        flex: 1
        renderer: (value, metaData, record) ->
            return record.getNewsCategoryTitle()
    ,
        text: 'ลิงค์'
        dataIndex: 'link'
        minWidth: 100
        flex: 1
    ,
        xtype: 'datecolumn'
        text: 'วันที่เขียน'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        maxWidth: 250
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มรายการ'
            xtype: 'button'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls: 'pencil-square-o'
            handler: 'onEdit'
            bind: widgetRecord: '{refNewsList.selection}'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            handler: 'onDelete'
            bind: widgetRecord: '{refNewsList.selection}'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{news}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{news}'
        displayInfo: yes
