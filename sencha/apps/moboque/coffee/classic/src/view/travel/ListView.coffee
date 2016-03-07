Ext.define 'Moboque.view.travel.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-travel-list'

    bind:
        store: '{travels}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ของฝากประจำจังหวัด'
    reference: 'refTravelList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อของฝาก'
        dataIndex: 'title'
        minWidth: 300
        flex: 1
    ,
        text: 'คำอธิบาย'
        dataIndex: 'description'
        minWidth: 300
        flex: 1
    ,
        xtype: 'datecolumn'
        text: 'วันที่เขียน'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        maxWidth: 250
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มรายการ'
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
                disabled: '{!refLinkList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refLinkList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{travels}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{travels}'
        displayInfo: yes
