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
        ]
