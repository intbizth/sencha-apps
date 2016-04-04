Ext.define 'Moboque.view.group.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-group-list'

    bind:
        store: '{groups}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'กลุ่ม'
    reference: 'refGroupList'
    headerBorders: no

    columns: [
        text: 'ชื่องาน'
        width: 400
        renderer: (v, m, r) ->
            return r.getEventName()
    ,
        text: 'ชื่อกลุ่ม'
        dataIndex: 'name'
        width: 300
    ,
        xtype: 'colorlabelcolumn'
        text: 'สีประจำกลุ่ม'
        dataIndex: 'color'
        colorBoxWidth: 20
        colorBoxHeight: 20
        flex: 1
        minWidth: 200
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
            text: 'เพิ่มกลุ่ม'
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
            bind: widgetRecord: '{refGroupList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refGroupList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{groups}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{groups}'
        displayInfo: yes
