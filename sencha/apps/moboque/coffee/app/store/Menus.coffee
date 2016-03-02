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
            text: 'Appregisted'
            iconCls: 'fa fa-mobile'
            children: [
                text: 'Events'
                view: 'event.LayoutView'
                iconCls: 'fa fa-calendar'
                leaf: true
                routeId: 'events'
            ,
                text: 'Groups'
                view: 'group.LayoutView'
                iconCls: 'fa fa-cubes'
                leaf: true
                routeId: 'groups'
            ,
                text: 'Members'
                view: 'member.LayoutView'
                iconCls: 'fa fa-user'
                leaf: true
                routeId: 'members'
            ]
        ,
            text: 'Activity'
            view: 'activity.LayoutView'
            iconCls: 'fa fa-newspaper-o'
            leaf: true
            routeId: 'activities'
        ,
            text: 'Service'
            iconCls: 'fa fa-cubes'
            children: [
                text: 'Services'
                view: 'service.LayoutView'
                iconCls: 'fa fa-cube'
                leaf: true
                routeId: 'services'
            ,
                text: 'ServiceCategories'
                view: 'service_category.LayoutView'
                iconCls: 'fa fa-cube'
                leaf: true
                routeId: 'service-categories'
            ]
        ]
