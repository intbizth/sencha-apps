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
            text: 'Orders'
            iconCls: 'x-fa fa-shopping-cart'
            children: [
                text: 'Current Orders'
                view: 'order.LayoutView'
                iconCls: 'x-fa fa-shopping-basket'
                leaf: true
                routeId: 'orders'
            ]
        ,

            text: 'Shipments'
            view: 'shipment.LayoutView'
            iconCls: 'x-fa fa-plane'
            leaf: true
            routeId: 'shipments'

        ,
            text: 'Configuration'
            iconCls: 'x-fa fa-cog'
            children: [
                text: 'Channels'
                view: 'channel.LayoutView'
                iconCls: 'x-fa fa-database'
                leaf: true
                routeId: 'channel'
            ,
                text: 'Taxons'
                view: 'taxon.LayoutView'
                iconCls: 'x-fa fa-sitemap'
                leaf: true
                routeId: 'taxon'
            ,
                text: 'Currency'
                view: 'currency.LayoutView'
                iconCls: 'x-fa fa-dollar'
                leaf: true
                routeId: 'currency'
            ,
                text: 'Country'
                view: 'country.LayoutView'
                iconCls: 'x-fa fa-flag'
                leaf: true
                routeId: 'country'
            ,
                text: 'Locale'
                view: 'locale.LayoutView'
                iconCls: 'x-fa fa-language'
                leaf: true
                routeId: 'locale'
            ,
                text: 'Zone'
                view: 'zone.LayoutView'
                iconCls: 'x-fa fa-globe'
                leaf: true
                routeId: 'zone'
            ,
                text: 'Payment Methods'
                view: 'payment_method.LayoutView'
                iconCls: 'x-fa fa-credit-card'
                leaf: true
                routeId: 'payment-method'
            ]
        ]
