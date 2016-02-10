Ext.define 'Moboque.init.Ajax',
    constructor: (app, profile) ->
        IS_DEBUG = Moboque.Application.IS_DEBUG

        # debug
        Ext.Ajax.on 'beforerequest', (conn, options, eOpts) ->
            # custom path
            options.url = Moboque.cfg.get('api.baseUrl') + options.path if options.path

            # custom api proxy
            options.url = options.url.replace '/api/', '/' + Moboque.cfg.get('api.version') + '/'

            if options.proxy and options.proxy.model and options.proxy.model.xhrOverrideOptions
                options = options.proxy.model.xhrOverrideOptions options

            if IS_DEBUG
                console.info 'REQUEST: ==> ', options.url, options

        Ext.Ajax.on 'requestexception', (conn, response, options, eOpts) ->
            if IS_DEBUG
                console.warn 'ERROR: ==> ', options.url, options

        Ext.Ajax.on 'requestcomplete', (conn, response, options, eOpts) ->
            if options.proxy and options.proxy.model and options.proxy.model.xhrOverrideResponse
                response = options.proxy.model.xhrOverrideResponse response, options

            if IS_DEBUG
                console.info 'RESPONSE: ==> ', options.url, response, options
