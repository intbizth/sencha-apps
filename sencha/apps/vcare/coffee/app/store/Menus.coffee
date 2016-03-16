Ext.define 'Vcare.store.Menus',
    extend: 'Ext.data.TreeStore'
    storeId: 'store-menus'

    fields: [
        name: 'text'
    ]

    root:
        expanded: true
        children: [
            text: 'Dashboard'
            view: 'dashboard.Dashboard'
            leaf: true
            iconCls: 'right-icon new-icon x-fa fa-desktop'
            routeId: 'dashboard'
        ,
            text: 'Customers'
            view: 'customer.LayoutView'
            iconCls: 'fa fa-users'
            leaf: true
            routeId: 'customers'
        ,
            text: 'Taxons'
            view: 'taxon.LayoutView'
            iconCls: 'fa fa-users'
            leaf: true
            routeId: 'taxons'
        ,
            text: 'Rbac'
            iconCls: 'fa fa-users'
            children: [
                text: 'Roles'
                view: 'rbac.role.LayoutView'
                iconCls: 'fa fa-calendar'
                leaf: true
                routeId: 'rbac-roles'
            ,
                text: 'Permissions'
                view: 'rbac.permission.LayoutView'
                iconCls: 'fa fa-calendar'
                leaf: true
                routeId: 'rbac-permissions'
            ]
        ]
