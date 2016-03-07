Ext.define 'Moboque.view.activity.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-activity-list'

    bind:
        store: '{activities}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'

    title: 'กิจกรรม'
    reference: 'refActivityList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อเรื่อง'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        text: 'ลิงก์'
        dataIndex: 'link'
        width: 400
    ,
    	xtype: 'datecolumn'
    	text: 'วันที่สร้าง'
    	dataIndex: 'created_at'
    	format: 'd-m-Y H:i'
    	width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มกิจกรรม'
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
                disabled: '{!refActivityList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refActivityList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{activities}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{activities}'
        displayInfo: yes
