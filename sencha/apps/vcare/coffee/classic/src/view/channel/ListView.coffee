Ext.define 'Vcare.view.channel.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-channel-list'

    bind:
        store: '{channels}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Channels'
    reference: 'refChannelList'
    headerBorders: no

    columns: [
        xtype: 'yesnocolumn'
        dataIndex: 'enabled'
        text: 'Enabled'
        align: 'center'
        width: 80
    ,
        text: 'Name'
        dataIndex: 'name'
    ,
        text: 'Hostname'
        dataIndex: 'hostname'
    ,
        xtype: 'templatecolumn'
        text: 'Currency'
        tpl: '{default_currency.name}'
    ,
        xtype: 'templatecolumn'
        text: 'Locale'
        tpl: '{default_locale.name}'
    ,
        text: 'Description'
        dataIndex: 'description'
        flex: 1
    ]

    tbar:
        items: [
            text: 'Add New'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'Edit'
            iconCls: 'pencil-square-o'
            bind: widgetRecord: '{refChannelList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'Remove'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refChannelList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{channels}'
        displayInfo: yes
