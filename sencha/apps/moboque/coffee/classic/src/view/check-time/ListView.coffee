Ext.define 'Moboque.view.check-time.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-check-time-list'

    bind:
        store: '{checkTimes}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ตารางเวลาเข้าออก'
    reference: 'refCheckTimeList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อสมาชิก'
        width: 300
        renderer: (v, m, r) ->
            return r.getMemberName()
    ,
        text: 'ประเภทการลงเวลา'
        dataIndex: 'type'
        flex: 1
        minWidth: 200
    ,
        xtype: 'datecolumn'
        text: 'เวลาเข้าออก'
        dataIndex: 'checktime'
        format: 'd-m-Y H:i'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มข้อมูลเวลาเข้าออก'
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
                disabled: '{!CheckTimeList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!CheckTimeList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{checkTimes}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{checkTimes}'
        displayInfo: yes
