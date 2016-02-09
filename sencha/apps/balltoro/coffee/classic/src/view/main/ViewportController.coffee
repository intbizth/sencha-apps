Ext.define 'Balltoro.view.main.ViewportController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.ctrl-main-viewport'

    listen:
        controller:
            '#': unmatchedroute: 'onRouteChange'

    routes:
        ':node': 'onRouteChange'

    init: ->
        Balltoro.app.on 'LOGIN_SUCCESS', @updateUserView, @

    updateUserView: (userData) ->
        vm = @getViewModel()
        vm.set 'userDisplayName', userData.displayname

    activateView: (hashTag) ->
        hashTag = (hashTag || '').toLowerCase()
        mainCard = @referTo 'MainCardPanel'
        mainLayout = mainCard.getLayout()
        navigationList = @referTo 'Menu'
        viewModel = @getViewModel()
        vmData = viewModel.getData()
        store = navigationList.getStore()
        node = store.findNode 'routeId', hashTag
        view = if node then node.get('view') else null
        lastView = vmData.currentView
        existingItem = mainCard.child 'component[existingId=' + hashTag + ']'

        # Kill any previously routed window
        lastView.destroy() if lastView and lastView.isWindow
        lastView = mainLayout.getActiveItem()

        Balltoro.app.routingToken.current = hashTag

        if lastView
            Balltoro.app.routingToken.previous = lastView.existingId
        else Balltoro.app.routingToken.previous = hashTag

        if !existingItem
            newView = Ext.create 'Balltoro.view.' + (view || 'pages.Error404Window'),
                hideMode: 'offsets'
                existingId: hashTag

        if !newView or !newView.isWindow
            # !newView means we have an existing view, but if the newView isWindow
            # we don't add it to the card layout.
            if  existingItem
                # We don't have a newView, so activate the existing view.
                if existingItem != lastView
                    mainLayout.setActiveItem existingItem
                newView = existingItem;
            else
                # newView is set (did not exist already), so add it and make it the
                # activeItem.
                Ext.suspendLayouts()
                mainLayout.setActiveItem mainCard.add newView
                Ext.resumeLayouts yes

        navigationList.setSelection node
        newView.focus() if newView.isFocusable yes

        vmData.currentView = newView
        return

    onMenuSelectionChange: (tree, node) ->
        this.redirectTo node.get 'routeId' if node and node.get 'view'
        return

    onToggleNavigationSize: ->
        navigationList = @referTo 'Menu'
        wrapContainer = @referTo 'MainContainerWrap'
        collapsing = !navigationList.getMicro()
        newWidth = if collapsing then 64 else 250

        if Ext.isIE9m or !Ext.os.is.Desktop
            Ext.suspendLayouts()

            @referTo('Logo').setWidth newWidth

            navigationList.setWidth newWidth
            navigationList.setMicro collapsing

            # do not flush the layout here...
            Ext.resumeLayouts()

            # No animation for IE9 or lower...
            wrapContainer.layout.animatePolicy = wrapContainer.layout.animate = null
            # ... since this will flush them
            wrapContainer.updateLayout()

        else
            if !collapsing
                # If we are leaving micro mode (expanding), we do that first so that the
                # text of the items in the navlist will be revealed by the animation.
                navigationList.setMicro no

            # Start this layout first since it does not require a layout
            @referTo('Logo').animate
                dynamic: yes
                to: width: newWidth

            # Directly adjust the width config and then run the main wrap container layout
            # as the root layout (it and its chidren). This will cause the adjusted size to
            # be flushed to the element and animate to that new size.
            navigationList.width = newWidth
            wrapContainer.updateLayout isRoot: yes

            # We need to switch to micro mode on the navlist *after* the animation (this
            # allows the "sweep" to leave the item text in place until it is no longer
            # visible.
            if collapsing
                navigationList.on
                    single: true
                    afterlayoutanimation: ->
                        navigationList.setMicro yes
        return

    onSignOut: -> Balltoro.app.logout()

    onMainViewRender: ->
        @redirectTo 'dashboard' if !window.location.hash

    onRouteChange: (id) ->
        @activateView id

    onSearchRouteChange: ->
        @activateView 'search'

    onEmailRouteChange: ->
        @activateView 'email'
