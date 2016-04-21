Ext.define 'Vcare.view.order.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-order-list'

    bind:
        store: '{orders}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Orders'
    reference: 'refOrderList'
    headerBorders: no

    columns: [
        text: 'ID'
        width: 40
        dataIndex: 'id'
    ,
        text: 'Number'
        dataIndex: 'number'
    ,
        text: 'State'
        dataIndex: 'state'
        flex: 1
    ,
        text: 'Total'
        dataIndex: 'total'
        align: 'right'
        renderer: (v, m, r) -> r.getPrice(v)
    ,
        text: 'Currency'
        dataIndex: 'currency'
    ]

    tbar:
        items: [
            text: 'Show Items'
            iconCls: 'list-alt'
            bind: widgetRecord: '{refOrderList.selection}'
            handler: 'onShow'
            aclCheck: yes
        ,
            text: 'Edit'
            iconCls:'pencil-square-o '
            bind: widgetRecord: '{refOrderList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'Remove'
            iconCls:'trash-o'
            bind: widgetRecord: '{refOrderList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'Update State'
            iconCls:'check-square'
            bind: widgetRecord: '{refOrderList.selection}'
            handler: 'onUpdateState'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{orders}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{orders}'
        displayInfo: yes
