Ext.define 'Toro.init.OAuth',
    constructor: (app, profile) ->
        Ext.Ajax.on 'requestexception', (conn, response, options, eOpts) ->
            return if response.status isnt 401
            app.redirectTo 'authen.login'
            return

        app.getStore('Settings').load
            callback: ->
                authen = @getById 'authen.user'

                if app.authen.isLogged = !!authen
                    Toro.authen.LoginManager.addAccessTokenHeader()
                    Toro.authen.LoginManager.keepAliveMe()
