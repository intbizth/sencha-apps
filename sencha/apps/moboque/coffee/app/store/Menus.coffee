Ext.define 'Moboque.store.Menus',
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
            text: 'Users (Profile)'
            view: 'profile.LayoutView'
            iconCls: 'fa fa-users'
            leaf: true
            routeId: 'profiles'
        ,
            text: 'Events'
            view: 'event.LayoutView'
            iconCls: 'fa fa-male'
            leaf: true
            routeId: 'events'
        ]
