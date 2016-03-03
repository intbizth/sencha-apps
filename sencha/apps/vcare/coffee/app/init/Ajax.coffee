Ext.define 'Vcare.init.Ajax',
    constructor: (app, profile) ->
        IS_DEBUG = Vcare.Application.IS_DEBUG

        # debug
        Ext.Ajax.on 'beforerequest', (conn, options, eOpts) ->
            # custom path
            options.url = Vcare.cfg.get('api.baseUrl') + options.path if options.path

            # custom api proxy
            options.url = options.url.replace '/api/', '/' + Vcare.cfg.get('api.version') + '/'

            # url with holder in sf style.
            options.url = options.url.replace /\{\w+?\}/g, (holder) ->
                return if !options.params

                holder = holder.replace /\{|\}/g, ''
                replacements = options.params

                return holder if !replacements

                if Object.prototype.hasOwnProperty.call(replacements, holder)
                    value = replacements[holder]
                    delete replacements[holder]
                    return value
                else holder

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
