Ext.define 'Moboque.view.event.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-event-list'

    bind:
        store: '{events}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'งานอีเวนท์'
    reference: 'refEventList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่ออีเวนท์'
        dataIndex: 'name'
        width: 200
    ,
        text: 'สถานที่จัดงาน'
        dataIndex: 'location'
        flex: 1
        minWidth: 200
    ,
        xtype: 'datecolumn'
        text: 'วันและเวลาเริ่มงาน'
        dataIndex: 'start_date'
        format: 'd-m-Y H:i'
        width: 150
    ,
        xtype: 'datecolumn'
        text: 'วันและเวลาสิ้นสุดงาน'
        dataIndex: 'end_date'
        format: 'd-m-Y H:i'
        width: 150
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มงานอีเวนท์'
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
                disabled: '{!refEventList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refEventList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{events}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{events}'
        displayInfo: yes
