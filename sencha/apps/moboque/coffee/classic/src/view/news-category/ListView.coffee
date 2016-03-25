Ext.define 'Moboque.view.news-category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-news-category-list'

    bind:
        store: '{newsCategories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'หมวดหมู่บริการ'
    reference: 'refNewsCategoryList'
    headerBorders: no

    columns: [
        text: 'ชื่อหมวดหมู่บริการ'
        dataIndex: 'title'
        width: 300
    ,
        text: 'คำบรรยาย'
        dataIndex: 'sub_title'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มหมวดหมู่บริการ'
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
            bind: widgetRecord: '{refNewsCategoryList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refNewsCategoryList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{newsCategories}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{newsCategories}'
        displayInfo: yes
