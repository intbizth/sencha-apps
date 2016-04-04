Ext.define 'Moboque.view.service.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-service-list'

    bind:
        store: '{services}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'บริการ'
    reference: 'refServiceList'
    headerBorders: no

    columns: [
        text: 'ชื่อบริการ'
        dataIndex: 'title'
        width: 300
    ,
        text: 'หมวดหมู่'
        width: 250
        renderer: (v, m, r) ->
            return r.getServiceCategoryName()
    ,
        xtype: 'numbercolumn'
        text: 'ราคา'
        dataIndex: 'price'
        format: '0,000.00'
        align: 'right'
        width: 100
    ,
        text: 'สกุลเงิน'
        dataIndex: 'price_currency'
        align: 'center'
        width: 100
    ,
        text: 'ลิงก์'
        dataIndex: 'link'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มบริการ'
            xtype: 'button'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls: 'pencil-square-o'
            bind: widgetRecord: '{refServiceList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refServiceList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{services}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{services}'
        displayInfo: yes
