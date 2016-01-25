Ext.define 'Toro.authen.LoginManager',
    singleton: yes
    data: {}

    _defaults:
        username: null
        password: null
        remember_me: no
        access_token: null
        refresh_token: null
        expires_in: null
        token_type: null
        scope: null
        token_timestamp: null
        user: null

    constructor: ->
        @resetData()
        return

    # public
    get: (key) -> @data[key]

    # public
    set: (key, value) ->
        if typeof key is 'object'
            for k, v of key
                @data[k] = v
        else @data[key] = value

    # private
    resetData: ->
        for key, value of @_defaults
            @set key, value

    # private
    decode: (xhr) -> Ext.decode xhr.responseText

    # public
    addAccessTokenHeader: ->
        ### Not work in cors origin.
        defaultHeaders = Ext.Ajax.getDefaultHeaders() || {}
        defaultHeaders = Authorization: 'Bearer ' + @get 'access_token'
        Ext.Ajax.setDefaultHeaders defaultHeaders
        ###
        Ext.Ajax.on 'beforerequest', (conn, options, eOpts) =>
            try
                if @get('access_token') and options.method isnt 'POST'
                    options.params = {} if !options.params
                    options.params['access_token'] = @get 'access_token'
            catch e
                # ...

    # private
    clearAccessTokenHeader: ->
        ### Not work in cors origin.
        defaultHeaders = Ext.Ajax.getDefaultHeaders() || {}
        if defaultHeaders['Authorization']
            delete defaultHeaders['Authorization']
            Ext.Ajax.setDefaultHeaders defaultHeaders
        ###

    # private
    doRequest: (config) ->
        return Ext.Ajax.request
            cors: yes
            async: yes
            useDefaultXhrHeader: no
            url: Toro.cfg.getWith 'api.baseUrl', config.path
            method: config.method || 'GET'
            params: config.params || null
            success: config.success || null
            failure: config.failure || null

    # private
    persistUserData: (deferred) ->
        # persist authen info
        store = @getSettingStore()
        store.load
            scope: @
            callback: ->
                # find existing record otherwise create new
                user = store.getById('authen.user') || new store.model
                rememberMe = store.getById('authen.remember_me') || new store.model

                store.add user if user.phantom
                store.add rememberMe if rememberMe.phantom

                # update record
                rememberMe.set
                    id: 'authen.remember_me'
                    value: @get 'remember_me'

                user.set
                    id: 'authen.user'
                    value: Ext.encode
                        user: @get 'user'
                        expires_in: @get 'expires_in'
                        access_token: @get 'access_token'
                        refresh_token: @get 'refresh_token'
                        token_timestamp: @get 'token_timestamp'

                store.sync
                    scope: @
                    success: ->
                        console.info 'User data was persisted.'
                        Toro.app.authen.isLogged = yes
                        deferred.resolve @get 'user'

                    failure: ->
                        console.warn 'Cannot persist user data.'
                        deferred.reject 'Cannot persist user data.'

    # public
    getSettingStore: -> Ext.getStore 'store-settings'

    # public
    loadUser: ->
        deferred = new Ext.Deferred()

        @getSettingStore().load (records, operation, success) ->
            try
                deferred.resolve @getById 'authen.user' if success
                deferred.resolve null if !success
            catch e
                deferred.reject e

        return deferred.promise

    # public
    logout: ->
        deferred = new Ext.Deferred()
        store = @getSettingStore()

        @resetData()

        # clear time-out
        clearInterval window["ToroKeepAliveTime"]
        window["ToroKeepAliveTime"] = null

        @loadUser().then (user) =>
            if !user
                deferred.resolve yes
                return

            store.remove user
            store.sync()
            Toro.app.authen.isLogged = no
            deferred.resolve yes

        , (e) -> deferred.reject e

        return deferred.promise

    # private
    _keepAliveTime: null

    # public
    keepAliveMe: ->
        return if window["ToroKeepAliveTime"]

        @loadUser().then (user) =>
            if !user
                deferred.resolve yes
                return

            data = user.get('value')
            obj = Ext.decode data

            @displayUserInfo(obj.user)

            tokenTimestamp = obj.token_timestamp
            refreshToken = obj.refresh_token
            lifetime = obj.expires_in / 60 # minutes

            if !@get 'access_token'
                @set 'access_token', obj.access_token

            window["ToroKeepAliveTime"] = setInterval =>

                if !@get 'token_timestamp'
                    @set 'token_timestamp', tokenTimestamp

                if !@get 'refresh_token'
                    @set 'refresh_token', refreshToken

                difftime = (Date.now() - @get('token_timestamp')) / (1000 * 60)
                padding = lifetime - difftime
                @refreshToken() if padding < 10
            , (60000 * 5) # every 5 munites check!

    # public
    refreshToken: ->
        # reset access token
        @set 'access_token', null

        @afterToken @doRequest
            path: '/oauth/v2/token'
            params:
                client_id: Toro.cfg.get 'api.client'
                client_secret: Toro.cfg.get 'api.secret'
                grant_type: 'refresh_token'
                refresh_token: @get 'refresh_token'

    # public
    # TODO: secure it with make over proxy, client just kept some cookie.
    login: (username, password, rememberMe) ->
        @set 'remember_me', rememberMe
        @afterToken @doRequest
            path: '/oauth/v2/token'
            params:
                client_id: Toro.cfg.get 'api.client'
                client_secret: Toro.cfg.get 'api.secret'
                grant_type: 'password'
                username: username
                password: password

    # private
    afterToken: (promise) ->
        me = @
        deferred = new Ext.Deferred()
        promise.then (xhr) ->
            # update data
            me.set me.decode xhr
            me.set 'token_timestamp', Date.now()

            # add authen token to all request
            me.addAccessTokenHeader()

            # getting user info
            me.doRequest(path: '/api/me').then (xhr) ->
                me.set 'user', me.decode xhr
                me.persistUserData(deferred)
            # reject
            , (xhr) -> deferred.reject me.decode xhr
        ,(xhr) ->
            me.clearAccessTokenHeader()
            deferred.reject me.decode xhr

        return deferred.promise

    displayUserInfo: (user) ->
        if user?
            record = Ext.create 'Toro.model.User', user

            main = Toro.app.getMainView()

            displayname = main.lookupReference 'refUsernameText'
            displayname.setText(record.get('displayname'))

            image = main.lookupReference 'refUserImage'
            image.setSrc(if avatar = record.getProfilePictureUrl() then avatar else 'resources/images/avatar-default.png')
