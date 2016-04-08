Ext.define 'Moboque.view.service-category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-service-category-list'

    bind:
        store: '{serviceCategories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'หมวดหมู่บริการ'
    reference: 'refServiceCategoryList'
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
    ,
        xtype: 'datecolumn'
        text: 'วันที่สร้าง'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 200
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
            bind: widgetRecord: '{refServiceCategoryList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refServiceCategoryList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{serviceCategories}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{serviceCategories}'
        displayInfo: yes
