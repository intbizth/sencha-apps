Ext.define 'Vcare.view.locale.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-locale-list'

    bind:
        store: '{locales}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ภาษา'
    reference: 'refLocaleList'
    headerBorders: no


    columns: [
        text: 'Code'
        dataIndex: 'code'
        width: 150
    ,
        text: 'Name'
        flex: 1
        renderer: 'getLocalName'

    ,
        text: 'Status'
        width: 80
        dataIndex: 'enabled'
        renderer: (v, m, r) ->
            v = if v then '<span style="color:green">Enabled</span>' else '<span style="color:red">Disabled</span>'
            return v
    ,
        menuDisabled: true
        sortable: false
        xtype: 'actioncolumn'
        width: 80
        items: [
            handler: 'changeEnableState'
            getClass: (v, m, r) ->
                e = r.get 'enabled'
                if e
                    return 'fa fa-times'
                else
                    return 'fa fa-check'
            getTip: (v, m, r) ->
                e = r.get 'enabled'
                if e
                    return 'Disable'
                else
                    return 'Enable'
        ]
    ]
    tbar:
        items: [
            text: 'เพิ่มภาษา'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refCustomerList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
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
