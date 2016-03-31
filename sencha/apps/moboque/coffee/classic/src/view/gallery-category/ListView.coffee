Ext.define 'Moboque.view.gallery-category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-gallery-category-list'

    bind:
        store: '{galleryCategories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'หมวดหมู่รูปภาพ'
    reference: 'refGalleryCategoryList'
    headerBorders: no

    columns: [
        text: 'ชื่อ'
        dataIndex: 'title'
        width: 250
    ,
        text: 'คำบรรยาย'
        dataIndex: 'sub_title'
        minWidth: 250
        flex: 1
    ,
        xtype: 'datecolumn'
        text: 'สร้างเมื่อ'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มหมวดหมู่รูปภาพ'
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
            bind: widgetRecord: '{refGalleryCategoryList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refGalleryCategoryList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{galleryCategories}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{galleryCategories}'
        displayInfo: yes
