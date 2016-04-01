Ext.define 'Vcare.view.currency.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-currency-list'

    bind:
        store: '{currencies}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Currency'
    reference: 'refCurrencyList'
    headerBorders: no

    plugins:
        ptype: 'rowediting'
        pluginId: 'rowediting'
        clicksToEdit: 1
        listeners:
            cancelEdit: 'onCancelEdit'
            edit: 'onSubmit'

    columns: [
        xtype: 'yesnocolumn'
        dataIndex: 'enabled'
        text: 'Enabled'
        align: 'center'
        width: 80
        field:
            xtype: 'checkbox'
    ,
        text: 'Code'
        width: 80
        dataIndex: 'code'
        field:
            xtype: 'textfield'
    ,
        xtype: 'numbercolumn'
        text: 'Exchange Rate'
        dataIndex: 'exchange_rate'
        align: 'right'
        width: 200
        field:
            xtype: 'numberfield'
    ,
        flex: 1
    ]

    tbar:
        items: [
            text: 'Add New'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'Remove'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refCurrencyList.selection}'
            handler: 'onDelete'
            aclCheck: -> !@widgetRecord.phantom
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{currencies}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{currencies}'
        displayInfo: yes