Ext.define 'Vcare.view.rbac-permission.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-rbac-permission-list'

    bind:
        store: '{rbac-permissions}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Permissions'
    reference: 'refRbacPermissionList'
    headerBorders: no

    getTreePadding: (meta, r, label) ->
        padding = (r.get('level') * 20) + 10
        meta.style = "padding-left: #{padding}px"

        return label

    columns: [
        xtype: 'rownumberer'
        width: 40
        sortable: no
    ,
        width: 300
        text: 'Code'
        dataIndex: 'code'
        renderer: (v, m, r) -> @getTreePadding(m, r, v)
    ,
        flex: 1
        text: 'Description'
        dataIndex: 'description'
    ]

    tbar:
        items: [
            text: 'เพิ่มรายการ'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'pencil-square-o'
            bind: widgetRecord: '{refRbacPermissionList.selection}'
            handler: 'onEdit'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            text: 'ลบ'
            iconCls:'trash-o'
            bind: widgetRecord: '{refRbacPermissionList.selection}'
            handler: 'onDelete'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ]
