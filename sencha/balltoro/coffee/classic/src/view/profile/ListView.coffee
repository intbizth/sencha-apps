Ext.define 'Toro.view.profile.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-profile-list'

    viewModel:
        type: 'vm-profile'

    bind:
        store: '{profiles}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    listeners:
        selectionchange: 'onSelectionChange'

    reference: 'refProfileList'
    headerBorders: no
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
        defaultButtonUI: 'default'
        scrollable: yes
        items: [
            xtype: 'button'
            text: 'เพิ่มผู้ใช้งาน'
            iconCls: 'fa fa-pencil'
            ui: 'default-toolbar'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไข'
            iconCls:'fa fa-pencil-square-o '
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบ'
            iconCls:'fa fa-minus-square'
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา'
            labelWidth: 50
            bind:
                store: '{profiles}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{profiles}'
        displayInfo: yes
