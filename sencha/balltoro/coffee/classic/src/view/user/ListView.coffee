Ext.define 'Toro.view.user.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-user-list'

    viewModel:
        type: 'vm-user'

    bind:
        store: '{users}'

    reference: 'refUserList'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes

    listeners:
        selectionchange: 'onSelectionChange'

    headerBorders: no
    title: 'ผู้ใช้ระบบ'

    columns: [
        dataIndex: 'username'
        text: 'ชื่อผู้ใช้งาน (Username)'
        flex: 1
        minWidth: 150
    ,
        dataIndex: 'displayname'
        text: 'ชื่อ (Displayname)'
        width: 150
    ,
        text: 'ประเทศ'
        width: 100
        trueText: 'true'
        renderer: (v, c, r) ->
            country = r.getCountry()

            if country?
                return country.get 'name'
    ,
        xtype: 'booleancolumn'
        dataIndex: 'enabled'
        text: 'สถานะการใช้งาน'
        trueText: '<span style="color:green;">เปิดการใช้งาน</span>'
        falseText: '<span style="color:red;">ปิดการใช้งาน</span>'
        align: 'center'
        width: 150
    ]

    tbar:
        defaultButtonUI: 'default'
        items: [
            xtype: 'button'
            text: 'สร้าง'
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
                store: '{users}'
            margin: '0 10 0 0'
        ,
            xtype: 'button'
            text: 'ค้นหาขั้นสูง'
            handler: 'onAdvancedSearch'
        ]

    viewConfig:
        emptyText: 'Empty Data'
        deferEmptyText: no

    bbar:
        xtype: 'pagingtoolbar'
        pageSize: 25
        bind:
            store: '{users}'
        displayInfo: yes
