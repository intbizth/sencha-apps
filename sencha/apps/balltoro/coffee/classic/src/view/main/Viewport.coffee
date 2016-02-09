Ext.define 'Balltoro.view.main.Viewport',
    extend: 'Ext.container.Viewport'
    xtype: 'ux-main-viewport'

    cls: 'ui-dash-viewport'
    itemId: 'com-main-viewport'

    requires: [
        'Ext.list.Tree'
    ]

    controller: 'ctrl-main-viewport'
    viewModel:
        type: 'vm-main-viewport'

    layout:
        type: 'vbox'
        align: 'stretch'

    listeners:
        render: 'onMainViewRender'

    items: [
        xtype: 'toolbar'
        cls: 'ui-dash-dash-headerbar toolbar-btn-shadow'
        height: 64
        itemId: 'headerBar'
        items: [
            xtype: 'component'
            reference: 'refLogo'
            cls: 'ui-logo'
            html: '<div class="main-logo"><img src="resources/images/ui-logo.png">TORO</div>'
            width: 250
        ,
            margin: '0 0 0 8'
            cls: 'ui-delete-focus-bg'
            iconCls:'x-fa fa-navicon'
            id: 'main-navigation-btn'
            handler: 'onToggleNavigationSize'
        ,
            xtype: 'tbspacer'
            flex: 1
        ,
            cls: 'ui-delete-focus-bg'
            iconCls:'x-fa fa-search'
            href: '#search'
            hrefTarget: '_self'
            tooltip: 'See latest search'
        ,
            cls: 'ui-delete-focus-bg'
            iconCls:'x-fa fa-envelope'
            href: '#email'
            hrefTarget: '_self'
            tooltip: 'Check your email'
        ,
            cls: 'ui-delete-focus-bg'
            iconCls:'x-fa fa-bell'
        ,
            cls: 'ui-delete-focus-bg'
            iconCls:'x-fa fa-sign-out'
            tooltip: 'Sign out'
            handler: 'onSignOut'
        ,
            xtype: 'tbtext'
            cls: 'top-user-name'
            bind: '{userDisplayName}'
        ,
            xtype: 'image'
            cls: 'header-right-profile-image'
            height: 35
            width: 35
            alt:'current user image'
            src: 'resources/images/avatar-default.png'
            reference: 'refUserImage'
        ]
    ,
        xtype: 'ux-main-container-wrap'
        id: 'main-view-detail-wrap'
        reference: 'refMainContainerWrap'
        flex: 1
        items: [
            ui: 'navigation'
            xtype: 'treelist'
            store: 'store-menus'
            itemId: 'com-menu'
            reference: 'refMenu'
            width: 250
            expanderFirst: false
            expanderOnly: false
            listeners:
                selectionchange: 'onMenuSelectionChange'
        ,
            xtype: 'container'
            flex: 1
            #padding: 20
            reference: 'refMainCardPanel'
            cls: 'ui-dash-right-main-container'
            itemId: 'contentPanel'
            layout:
                type: 'card'
                anchor: '100%'
        ]
    ]
