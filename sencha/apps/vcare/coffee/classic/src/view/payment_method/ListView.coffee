Ext.define 'Vcare.view.payment_method.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-payment-method-list'

    bind:
        store: '{payment-methods}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Payment Methods'
    reference: 'refPaymentMethodList'
    headerBorders: no

    columns: [
        xtype: 'yesnocolumn'
        text: 'Enabled'
        dataIndex: 'enabled'
        align: 'center'
        width: 80
    ,
        text: 'Code'
        width: 100
        dataIndex: 'code'
    ,
        text: 'Name'
        dataIndex: 'name'
    ,
        text: 'Gateway'
        renderer: (v, m, r) -> r.getGatewayName()
    ,
        text: 'Description'
        flex: 1
        dataIndex: 'description'
    ]

    tbar:
        items: [
            text: 'Add New'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'Edit'
            iconCls:'pencil-square-o '
            bind: widgetRecord: '{refPaymentMethodList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'Remove'
            iconCls:'trash-o'
            bind: widgetRecord: '{refPaymentMethodList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{payment-methods}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{payment-methods}'
        displayInfo: yes
