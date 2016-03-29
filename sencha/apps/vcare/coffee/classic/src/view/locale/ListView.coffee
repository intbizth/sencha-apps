Ext.define 'Vcare.view.locale.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-locale-list'

    bind:
        store: '{locales}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Locale'
    reference: 'refLocaleList'
    headerBorders: no

    plugins:
        ptype: 'rowediting'
        pluginId: 'rowediting'
        clicksToEdit: 1
        listeners:
            cancelEdit: 'onCancelEdit'
            edit: 'onSubmit'

    columns: [
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
        dataIndex: 'enabled'
        text: 'Enabled'
        align: 'center'
        width: 80
        field:
            xtype: 'checkbox'

        renderer: (v, c, r) ->
            return '<span style="color:green;">Yes</span>' if v
            return '<span style="color:red;">No</span>'
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
            bind: widgetRecord: '{refLocaleList.selection}'
            handler: 'onDelete'
            aclCheck: -> !@widgetRecord.phantom
        ,
            '->'
        ,
            fieldLabel: 'Search'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{locales}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{locales}'
        displayInfo: yes
