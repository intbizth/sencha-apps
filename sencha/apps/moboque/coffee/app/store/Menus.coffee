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
            ,
                text: 'CheckTimes'
                view: 'check-time.LayoutView'
                iconCls: 'fa fa-clock-o'
                leaf: true
                routeId: 'check-times'
            ]
        ,
            text: 'Appregisted bind users'
            iconCls: 'fa fa-mobile'
            children: [
                text: 'Events'
                view: 'event-account.LayoutView'
                iconCls: 'fa fa-calendar'
                leaf: true
                routeId: 'account-events'
            ,
                text: 'Groups'
                view: 'group-account.LayoutView'
                iconCls: 'fa fa-cubes'
                leaf: true
                routeId: 'account-groups'
            ,
                text: 'Members'
                view: 'member-account.LayoutView'
                iconCls: 'fa fa-user'
                leaf: true
                routeId: 'account-members'
            ,
                text: 'CheckTimes'
                view: 'check-time-account.LayoutView'
                iconCls: 'fa fa-clock-o'
                leaf: true
                routeId: 'account-check-times'
            ]
        ,
            text: 'InfoBundle'
            iconCls: 'fa fa-info-circle'
            children: [
                text: 'Activity'
                view: 'activity.LayoutView'
                iconCls: 'fa fa-newspaper-o'
                leaf: true
                routeId: 'activities'
            ,
                text: 'ActivityImages'
                view: 'activity-image.LayoutView'
                iconCls: 'fa fa-picture-o'
                leaf: true
                routeId: 'activity-images'
            ,
                text: 'Services'
                view: 'service.LayoutView'
                iconCls: 'fa fa-cube'
                leaf: true
                routeId: 'services'
            ,
                text: 'ServiceCategories'
                view: 'service-category.LayoutView'
                iconCls: 'fa fa-cubes'
                leaf: true
                routeId: 'service-categories'
            ,
                text: 'ServiceImages'
                view: 'service-image.LayoutView'
                iconCls: 'fa fa-picture-o'
                leaf: true
                routeId: 'service-images'
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
            ,
                text: 'รูปภาพ'
                view: 'promote-image.LayoutView'
                iconCls: 'fa fa-photo'
                leaf: true
                routeId: 'promotes-image'
            ]
        ,

            text: 'AboutBundle'
            iconCls: 'fa fa-shirtsinbulk'
            children: [
                text: 'ของฝากประจำจังหวัด'
                view: 'gift.LayoutView'
                iconCls: 'fa fa-gift'
                leaf: true
                routeId: 'gift'
            ,
                text: 'สถานที่ท่องเที่ยว'
                view: 'travel.LayoutView'
                iconCls: 'fa fa-car'
                leaf: true
                routeId: 'travel'
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
        ,
            text: 'GalleryBundle'
            iconCls: 'fa fa-camera-retro'
            children: [
                text: 'GalleryCategories'
                view: 'gallery-category.LayoutView'
                iconCls: 'fa fa-picture-o'
                leaf: true
                routeId: 'gallery-categories'
            ,
                text: 'Galleries'
                view: 'gallery.LayoutView'
                iconCls: 'fa fa-file-image-o'
                leaf: true
                routeId: 'galleries'
            ]
        ,
            text: 'Personals'
            iconCls: 'fa fa-users'
            children: [
                text: 'PersonalDepartments'
                view: 'personal-department.LayoutView'
                iconCls: 'fa fa-server'
                leaf: true
                routeId: 'personal-departments'
            ,
                text: 'Personals'
                view: 'personal.LayoutView'
                iconCls: 'fa fa-male'
                leaf: true
                routeId: 'personals'
            ]
        ,
            text: 'Feeders'
            view: 'feeder.LayoutView'
            iconCls: 'fa fa-rss'
            leaf: true
            routeId: 'feeders'
        ,
            text: 'News'
            view: 'news.LayoutView'
            iconCls: 'fa fa-newspaper-o'
            leaf: true
            routeId: 'news'
        ,
            text: 'Reports'
            view: 'report.LayoutView'
            iconCls: 'fa fa-file-text-o'
            leaf: true
            routeId: 'reports'
        ,
            text: 'Reports Image'
            view: 'report-image.LayoutView'
            iconCls: 'fa fa-file-text-o'
            leaf: true
            routeId: 'reports-images'
        ,
            text: 'Locales'
            view: 'locale.LayoutView'
            iconCls: 'fa fa-file-text-o'
            leaf: true
            routeId: 'locales'
        ]
