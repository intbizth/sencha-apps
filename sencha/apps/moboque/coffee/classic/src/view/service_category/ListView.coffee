Ext.define 'Moboque.view.service_category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-service-category-list'

    bind:
        store: '{serviceCategories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'กลุ่ม'
    reference: 'refServiceCategoryList'
    headerBorders: no

    columns: [
        text: 'ชื่อบริการ'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        text: 'คำบรรยาย'
        dataIndex: 'sub_title'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มกลุ่ม'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls:'fa fa-pencil-square-o '
            bind: widgetRecord: '{refServiceCategoryList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
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
