Ext.define 'Moboque.init.OAuth',
    constructor: (app, profile) ->
        Ext.Ajax.on 'requestexception', (conn, response, options, eOpts) ->
            return if response.status isnt 401
            app.fireEvent Moboque.Application.events.LOGIN_REQUIRED
            app.expired()
            return

        Ext.Ajax.request
            cors: yes
            async: yes
            useDefaultXhrHeader: no
            url: Moboque.cfg.get 'api.info'
            method: 'GET'
            success: (res, opt) ->
                userInfo = Ext.decode(res.responseText)
                app.fireEvent Moboque.Application.events.LOGIN_SUCCESS, userInfo
                app.splashscreen.hide()
                app.authen.user = userInfo
