Ext.define 'Vcare.view.shipment.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-shipment-list'

    bind:
        store: '{shipments}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Shipments'
    reference: 'refShipmentList'
    headerBorders: no

    columns: [
        text: 'ID'
        width: 40
        dataIndex: 'id'
    ,
        text: 'Order'
        flex: 1
        dataIndex: 'order'
        renderer: (v, m, r) -> return '#'+v.number
    ,
        text: 'State'
        dataIndex: 'state'
    ,
        text: 'Method'
        dataIndex: 'method'
        flex: 1
        renderer: (v, m, r) -> return v.name
    ,
        text: 'Ship to'
        dataIndex: 'order'
        flex: 1
        renderer: (v, m, r) -> return v.customer.first_name+' '+v.customer.last_name+'<br/>'+v.shipping_address.street + ', ' + v.shipping_address.city
    ,
        text: 'Qty'
        dataIndex: 'order'
        width: 80
        renderer: (v, m, r) -> return v.items.length

    ,
        text: 'Creation date'
        dataIndex: 'created_at'
        flex: 1
        xtype: 'datecolumn'

    ]

    tbar:
        items: [

            text: 'Edit'
            iconCls:'pencil-square-o '
            bind: widgetRecord: '{refShipmentList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'Remove'
            iconCls:'trash-o'
            bind: widgetRecord: '{refShipmentList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'Update State'
            iconCls:'check-square'
            bind: widgetRecord: '{refShipmentList.selection}'
            handler: 'onUpdateState'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'Split Shipment'
            iconCls:'check-square'
            bind: widgetRecord: '{refShipmentList.selection}'
            handler: 'onSplit'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{shipments}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{shipments}'
        displayInfo: yes
