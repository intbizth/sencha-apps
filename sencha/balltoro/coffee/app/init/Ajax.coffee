Ext.define 'Toro.init.Ajax',
    constructor: (app, profile) ->
        IS_DEBUG = Toro.Application.IS_DEBUG

        # debug
        Ext.Ajax.on 'beforerequest', (conn, options, eOpts) ->
            options.url = options.url.replace '/api/', '/' + Toro.Application.API_VERSION + '/'

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
