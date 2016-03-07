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

            text: 'ContentBundle'
            iconCls: 'fa fa-book'
            children: [
                text: 'เบอร์โทรฉุกเฉิน'
                view: 'emergency-call.LayoutView'
                iconCls: 'fa fa-ambulance'
                leaf: true
                routeId: 'emergency-call'
            ,
                text: 'ลิงค์'
                view: 'link.LayoutView'
                iconCls: 'fa fa-link'
                leaf: true
                routeId: 'link'
            ,
                text: 'นายกพบประชาชน'
                view: 'meet.LayoutView'
                iconCls: 'fa fa-weixin'
                leaf: true
                routeId: 'meet'
            ,
                text: 'พื้นที่แนะนำสินค้าและบริการ'
                view: 'promote.LayoutView'
                iconCls: 'fa fa-slideshare'
                leaf: true
                routeId: 'promotes'
            ,
                text: 'หมวดหมู่แนะนำ'
                view: 'promote-category.LayoutView'
                iconCls: 'fa fa-slideshare'
                leaf: true
                routeId: 'promotes-category'
            ]
        ,
            text: 'LocaleBundle'
            iconCls: 'fa fa-location-arrow'
            children: [
                text: 'Provinces'
                view: 'province.LayoutView'
                iconCls: 'fa fa-globe'
                leaf: true
                routeId: 'provinces'
            ,
                text: 'Districts'
                view: 'district.LayoutView'
                iconCls: 'fa fa-map-marker'
                leaf: true
                routeId: 'districts'
            ,
                text: 'SubDistricts'
                view: 'sub-district.LayoutView'
                iconCls: 'fa fa-street-view'
                leaf: true
                routeId: 'sub-districts'
            ]
        ]
