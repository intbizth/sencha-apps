Ext.define 'Vcare.view.rbac-role.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-rbac-role-list'

    bind:
        store: '{rbac-roles}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Roles'
    reference: 'refRbacRoleList'
    headerBorders: no

    getTreePadding: (meta, r, label) ->
        padding = (r.get('level') * 20) + 10
        meta.style = "padding-left: #{padding}px"

        return label

    columns: [
        width: 300
        text: 'Name'
        dataIndex: 'name'
        sortable: no
        menuDisabled: yes
        renderer: (v, m, r) -> @getTreePadding(m, r, v)
    ,
        width: 200
        text: 'Code'
        dataIndex: 'code'
        sortable: no
        menuDisabled: yes
    ,
        flex: 1
        text: 'Description'
        dataIndex: 'description'
        sortable: no
        menuDisabled: yes
    ]

    tbar:
        items: [
            text: 'เพิ่มรายการ'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'pencil-square-o'
            bind: widgetRecord: '{refRbacRoleList.selection}'
            handler: 'onEdit'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            text: 'ลบ'
            iconCls:'trash-o'
            bind: widgetRecord: '{refRbacRoleList.selection}'
            handler: 'onDelete'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ]
