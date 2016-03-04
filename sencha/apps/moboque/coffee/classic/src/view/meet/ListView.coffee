Ext.define 'Moboque.view.meet.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-meet-list'

    bind:
        store: '{meets}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ลิงค์ภายนอก'
    reference: 'refMeetList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'คำอธิบาย'
        dataIndex: 'description'
        width: 200
    ,
        xtype: 'datecolumn'
        text: 'ลิงค์'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        flex: 1
        minWidth: 200
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
                store: '{meets}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{meets}'
        displayInfo: yes
