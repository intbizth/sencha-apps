Ext.define 'Vcare.view.product.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-product-list'

    bind:
        store: '{products}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Products'
    reference: 'refProductList'
    headerBorders: no

    columns: [
        dataIndex: 'name'
        text: 'Name'
        width: 200
    ,
        dataIndex: 'sku'
        text: 'SKU'
        flex: 1
    ]

    tbar:
        items: [
            text: 'Add New'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'Edit'
            iconCls:'pencil-square-o '
            bind: widgetRecord: '{refProductList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'Remove'
            iconCls:'trash-o'
            bind: widgetRecord: '{refProductList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{products}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{products}'
        displayInfo: yes
