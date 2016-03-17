Ext.define 'Moboque.view.link.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-link-list'

    bind:
        store: '{links}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ลิงค์ภายนอก'
    reference: 'refLinkList'
    headerBorders: no

    columns: [
        text: 'สถานะ'
        align: 'center'
        width: 80
        dataIndex: 'link'
    ,
        text: 'คำอธิบาย'
        dataIndex: 'label'
        width: 200
    ,
        text: 'ลิงค์'
        dataIndex: 'url'
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
                disabled: '{!refLinkList.selection}'
                widgetRecord: '{refLinkList.selection}'
            handler: 'onEdit'
            aclCheck: yes
#            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refLinkList.selection}'
                widgetRecord: '{refLinkList.selection}'
            handler: 'onDelete'
            aclCheck: yes
#            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{links}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{links}'
        displayInfo: yes
