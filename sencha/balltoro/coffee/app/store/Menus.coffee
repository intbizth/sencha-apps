Ext.define 'Toro.store.Menus',
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
            text: 'News'
            view: 'news.LayoutView'
            iconCls: 'fa fa-newspaper-o'
            leaf: true
            routeId: 'news'
        ,
            text: 'Countries'
            view: 'country.LayoutView'
            iconCls: 'fa fa-flag'
            leaf: true
            routeId: 'countries'
        ,
            text: 'Matches'
            view: 'match.LayoutView'
            iconCls: 'fa fa-futbol-o'
            leaf: true
            routeId: 'matches'
        ,
            text: 'Competitions'
            view: 'competition.LayoutView'
            iconCls: 'fa fa-calendar-o'
            leaf: true
            routeId: 'competitions'
        ,
            text: 'Seasons'
            view: 'season.LayoutView'
            iconCls: 'fa fa-calendar'
            leaf: true
            routeId: 'seasons'
        ,
            text: 'Clubs'
            view: 'club.LayoutView'
            iconCls: 'fa fa-university'
            leaf: true
            routeId: 'clubs'
        ,
            text: 'Personals'
            view: 'personal.LayoutView'
            iconCls: 'fa fa-male'
            leaf: true
            routeId: 'personals'
        ,
            text: 'Users (profile)'
            view: 'profile.LayoutView'
            iconCls: 'fa fa-users'
            leaf: true
            routeId: 'profiles'
        ]
