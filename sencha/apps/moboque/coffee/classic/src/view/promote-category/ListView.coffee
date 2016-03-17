Ext.define 'Moboque.view.promote-category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-promote-category-list'

    bind:
        store: '{promotes}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ลิงค์ภายนอก'
    reference: 'refPromoteCategoryList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'หัวเรื่อง'
        dataIndex: 'title'
        width: 200
    ,
        xtype: 'datecolumn'
        text: 'วันที่เขียน'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มรายการ'
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
            bind:
                disabled: '{!refPromoteCategoryList.selection}'
                widgetRecord: '{refPromoteCategoryList.selection}'
            aclCheck: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refPromoteCategoryList.selection}'
                widgetRecord: '{refPromoteCategoryList.selection}'
            aclCheck: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{promote-categories}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{promotes}'
        displayInfo: yes
