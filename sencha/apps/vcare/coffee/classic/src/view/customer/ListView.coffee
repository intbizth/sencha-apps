Ext.define 'Vcare.view.customer.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-customer-list'

    bind:
        store: '{customers}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ผู้ใช้งานระบบ'
    reference: 'refCustomerList'
    headerBorders: no

    columns: [
        text: 'สถานะ'
        align: 'center'
        width: 80
        dataIndex: 'user'
        renderer: (v, c, r) ->
            if r.getUser() && r.getUser().isEnabled()
                return '<span style="color:green;">เปิด</span>'

            return '<span style="color:red;">ปิด</span>'
    ,
        text: 'ชื่อ - นามสกุล'
        width: 200
        dataIndex: 'fullname'
    ,
        text: 'Username'
        width: 200
        renderer: (v, c, r) -> r.getUser() && r.getUser().get('username')
    ,
        dataIndex: 'email'
        text: 'อีเมล์'
        width: 200
    ,
        text: 'สิทธิ์การใช้งาน'
        flex: 1
        renderer: (v, c, r) -> r.getUser() && r.getUser().getReadableRoles()
    ]

    tbar:
        items: [
            text: 'เพิ่มผู้ใช้งาน'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'fa fa-pencil-square-o '
            bind: widgetRecord: '{refCustomerList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            text: 'ลบ'
            iconCls:'fa fa-minus-square'
            bind: widgetRecord: '{refCustomerList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            labelWidth: 50
            bind: store: '{customers}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{customers}'
        displayInfo: yes
