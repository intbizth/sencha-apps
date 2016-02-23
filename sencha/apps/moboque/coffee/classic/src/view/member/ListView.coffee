Ext.define 'Moboque.view.member.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-member-list'

    bind:
        store: '{members}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ข้อมูลสมาชิก'
    reference: 'refMemberList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อ - สกุล'
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
        text: 'วันที่เผยแพร่'
        dataIndex: 'published_date'
        width: 200
        # flex: 1
        # minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มข้อมูลสมาชิก'
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
                disabled: '{!refMemberList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refMemberList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{members}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{members}'
        displayInfo: yes