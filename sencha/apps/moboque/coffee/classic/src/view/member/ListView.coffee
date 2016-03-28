Ext.define 'Moboque.view.member.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-member-list'

    bind:
        store: '{members}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'ข้อมูลสมาชิก'
    reference: 'refMemberList'
    headerBorders: no

    columns: [
        text: 'ชื่อสมาชิก'
        dataIndex: 'fullname'
        width: 300
    ,
        text: 'อีเมล์'
        dataIndex: 'email'
        width: 300
    ,
        text: 'รหัสประจำตัวประชาชน'
        dataIndex: 'card_id'
        flex: 1
        minWidth: 250
    ,
        text: 'ชื่องาน'
        width: 300
        renderer: (v, m, r) ->
            return r.getGroupName()
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มข้อมูลสมาชิก'
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
            bind: widgetRecord: '{refMemberList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refMemberList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{members}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{members}'
        displayInfo: yes
