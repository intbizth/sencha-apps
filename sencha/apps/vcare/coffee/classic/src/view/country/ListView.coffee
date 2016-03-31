Ext.define 'Vcare.view.country.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-country-list'

    bind:
        store: '{countries}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Country'
    reference: 'refCountryList'
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
        text: 'Name'
        dataIndex: 'name'
        width: 200
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
            bind: widgetRecord: '{refCountryList.selection}'
            handler: 'onDelete'
            aclCheck: -> !@widgetRecord.phantom
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{countries}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{countries}'
        displayInfo: yes
