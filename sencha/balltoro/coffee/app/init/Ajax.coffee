Ext.define 'Toro.init.Ajax',
    constructor: (app, profile) ->
        # debug
        Ext.Ajax.on 'beforerequest', (conn, options, eOpts) ->
            if options.proxy and options.proxy.model and options.proxy.model.xhrOverrideOptions
                options = options.proxy.model.xhrOverrideOptions options

            if app.isDebug
                console.info 'REQUEST: ==> ', options.url, options

        Ext.Ajax.on 'requestexception', (conn, response, options, eOpts) ->
            if app.isDebug
                console.warn 'ERROR: ==> ', options.url, options

        Ext.Ajax.on 'requestcomplete', (conn, response, options, eOpts) ->
            if options.proxy and options.proxy.model and options.proxy.model.xhrOverrideResponse
                response = options.proxy.model.xhrOverrideResponse response, options

            if app.isDebug
                console.info 'RESPONSE: ==> ', options.url, response, options
