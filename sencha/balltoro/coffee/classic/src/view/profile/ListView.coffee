Ext.define 'Toro.view.profile.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-profile-list'

    bind:
        store: '{profiles}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    reference: 'refProfileList'
    title: 'ผู้ใช้งานระบบ'

    columns: [
        text: 'สถานะ'
        align: 'center'
        width: 80
        renderer: (v, c, r) ->
            if r.getUser().get('enabled')
                return '<span style="color:green;">เปิด</span>'

            return '<span style="color:red;">ปิด</span>'
    ,
        text: 'ชื่อ - นามสกุล'
        flex: 1
        minWidth: 200
        renderer: (v, c, r) ->
            return r.get('first_name') + '  ' + r.get('last_name')
    ,
        text: 'Username'
        width: 200
        renderer: (v, c, r) ->
            return r.getUser().get('username')
    ,
        dataIndex: 'email'
        text: 'อีเมล์'
        width: 200
    ,
        text: 'สิทธิ์การใช้งาน'
        width: 200
        renderer: (v, c, r) ->
            roles = r.getUser().get('roles')

            if roles
                return roles.join ', '
    ]

    tbar:
        items: [
            text: 'เพิ่มผู้ใช้งาน'
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
                disabled: '{!refProfileList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refProfileList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{profiles}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{profiles}'
        displayInfo: yes
