Ext.define 'Vcare.view.tax.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-tax-list'

    bind:
        store: '{taxs}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ภาษี'
    reference: 'refTaxList'
    headerBorders: no


    columns: [
        text: 'Code'
        dataIndex: 'code'
        width: 50
    ,
        text: 'Name'
        flex: 1
        dataIndex: 'name'
    ,

        text: 'Category'
        width: 150
        dataIndex: 'category'
        renderer: (v, c, r) ->
            return r.getCategory().get 'name'
    ,
        text: 'Zone'
        width: 150
        dataIndex: 'zone'
        renderer: (v, c, r) ->
            return r.getZone().get 'name'
    ,
        text: 'Amount'
        width: 150
        format: 'number'
        dataIndex: 'amount'
    ,
        text: 'Included in price'
        width: 80
        dataIndex: 'included_in_price'
    ,
        text: 'Calculator'
        width: 80
        dataIndex: 'calculator'


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
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls:'fa fa-pencil-square-o '
            bind:
                disabled: '{!refTaxList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refTaxList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{taxs}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{taxs}'
        displayInfo: yes
