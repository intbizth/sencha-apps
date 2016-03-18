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
            iconCls: 'right-icon new-icon x-x-fa fa-desktop'
            routeId: 'dashboard'
        ,
            text: 'Security'
            iconCls: 'x-fa fa-lock'
            children: [
                text: 'Roles'
                view: 'rbac.role.LayoutView'
                iconCls: 'x-fa fa-key'
                leaf: true
                routeId: 'rbac-roles'
            ,
                text: 'Permissions'
                view: 'rbac.permission.LayoutView'
                iconCls: 'x-fa fa-unlock'
                leaf: true
                routeId: 'rbac-permissions'
            ]
        ,
            text: 'Customers'
            view: 'customer.LayoutView'
            iconCls: 'x-fa fa-user'
            leaf: true
            routeId: 'customers'
        ,
            text: 'Taxons'
            view: 'taxon.LayoutView'
            iconCls: 'x-fa fa-sitemap'
            leaf: true
            routeId: 'taxons'
        ,
            text: 'Orders'
            iconCls: 'x-fa fa-shopping-cart'
            children: [
                text: 'Current Orders'
                view: 'order.LayoutView'
                iconCls: 'x-fa fa-shopping-basket'
                leaf: true
                routeId: 'orders'
            ]
        ]
