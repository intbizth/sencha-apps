Ext.define 'Vcare.view.rbac-role.PermissionListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-rbac-role-permission-list'

    bind:
        store: '{rbac-permissions}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    headerBorders: yes

    getTreePadding: (meta, r, label) ->
        padding = (r.get('level') * 20) + 10
        meta.style = "padding-left: #{padding}px"

        return label

    columns: [
        flex: 1
        text: 'Permissions Group'
        dataIndex: 'description'
        sortable: no
        menuDisabled: yes
        renderer: (v, m, r) -> @getTreePadding(m, r, v)
    # ,
    #     width: 50
    #     text: 'Selected'
    #     dataIndex: 'selected'
    #     sortable: no
    #     menuDisabled: yes
    ]
