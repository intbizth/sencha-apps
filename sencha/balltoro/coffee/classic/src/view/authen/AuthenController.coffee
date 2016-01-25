Ext.define 'Toro.view.authen.AuthenController',
    extend: 'Ext.app.ViewController',
    alias: 'controller.ctrl-authen'

    onLoginButton: (button, e, eOpts) ->
        model = @getViewModel()
        authen = Toro.authen.LoginManager
        promise = authen.login(model.get('username'), model.get('password'), model.get('rememberMe'))

        button.disable()
        promise.always -> button.enable()

        promise.then =>
            authen.keepAliveMe()

            redirectRoute = Toro.app.routingToken.previous
            redirectRoute = null if redirectRoute is 'authen.login'

            @redirectTo redirectRoute || 'dashboard'
        # on error
        , (msg) ->
            Ext.Msg.alert msg.error, msg.error_description

        return

    onResetClick: (button, e, eOpts) ->
        @redirectTo 'dashboard'

    onLogoutCancleButton: (button, e, eOpts) ->
        @getView().up('window').close()

    onLogoutButton: (button, e, eOpts) ->
        promise = Toro.authen.LoginManager.logout()

        promise.then =>
            @getView().up('window').close()
            @redirectTo 'authen.login'
