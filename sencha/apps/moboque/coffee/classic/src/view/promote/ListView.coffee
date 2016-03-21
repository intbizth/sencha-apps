Ext.define 'Moboque.view.promote.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-promote-list'

    bind:
        store: '{promotes}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'แนะนำสถานที่ท่องเที่ยว'
    reference: 'refPromoteList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อกลุ่ม'
        dataIndex: 'title'
        width: 300
    ,
        text: 'คำอธิบาย'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
    ,
        text: 'หมวด'
        maxWidth: 300
        flex: 1
        renderer: (value, metaData, record) ->
            return record.getPromoteCategoryName()
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
            bind: widgetRecord: '{refPromoteList.selection}'
            aclCheck: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind: widgetRecord: '{refPromoteList.selection}'
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
                store: '{promotes}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{promotes}'
        displayInfo: yes
