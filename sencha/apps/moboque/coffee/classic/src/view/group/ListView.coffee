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
        width: 300
        renderer: (v, m, r) ->
            return r.getEventName()
    ,
        text: 'ชื่อกลุ่ม'
        dataIndex: 'name'
        width: 300
    ,
        text: 'สีประจำกลุ่ม'
        dataIndex: 'color'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มกลุ่ม'
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
            bind: widgetRecord: '{refGroupList.selection}'                
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
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
