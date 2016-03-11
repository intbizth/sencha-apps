Ext.define 'Moboque.view.service.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-service-list'

    bind:
        store: '{services}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'บริการ'
    reference: 'refServiceList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อบริการ'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        text: 'หมวดหมู่'
        width: 350
        renderer: (v, m, r) ->
            return r.getServiceCategoryName()
    ,
        xtype: 'numbercolumn'
        text: 'ราคา'
        dataIndex: 'price'
        format: '0,000'
        width: 100
    ,
        text: 'สกุลเงิน'
        dataIndex: 'price_currency'
        width: 100
    ,
        text: 'ลิงก์'
        dataIndex: 'link'
        width: 300
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มบริการ'
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
                disabled: '{!refServiceList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refServiceList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{services}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{services}'
        displayInfo: yes
