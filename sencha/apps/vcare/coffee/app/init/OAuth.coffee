Ext.define 'Vcare.init.OAuth',
    constructor: (app, profile) ->
        Ext.Ajax.on 'requestexception', (conn, response, options, eOpts) ->
            return if response.status isnt 401
            app.fireEvent Vcare.Application.events.LOGIN_REQUIRED
            app.expired()
            return

        Ext.Ajax.request
            cors: yes
            async: yes
            useDefaultXhrHeader: no
            url: Vcare.cfg.get 'api.info'
            method: 'GET'
            success: (res, opt) ->
                userInfo = Ext.decode(res.responseText)
                app.fireEvent Vcare.Application.events.LOGIN_SUCCESS, userInfo
                app.splashscreen.hide()
                app.authen.user = userInfo
