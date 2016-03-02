Ext.define 'Vcare.model.Base',
    extend: 'Ext.data.Model'

    schema:
        namespace: 'Vcare.model'

    config:
        updateMethod: 'PATCH'

    rawData: null

    getSubmitData: ->
        data = if @phantom then @getData() else @getChanges()
        return null if Ext.Object.isEmpty(data)
        return data


    # private function
    doRequest: (config) ->
        return Ext.Ajax.request
            cors: yes
            async: yes
            useDefaultXhrHeader: no
            url: config.path || Vcare.cfg.getWith 'api.baseUrl'
            method: config.method || 'POST'
            params: config.params || null
            success: config.success || null
            failure: config.failure || null

    # private function
    checkApiUrl: (action) ->
        apis = @getProxy().getApi()

        if !Ext.isString action
            action = 'update'

        if apis[action]? and apis.hasOwnProperty(action)
            return url = apis[action]

        return apis['update']

    manageUpdateRecord: (record, path, options) ->
        url = @checkApiUrl('update')

        if !options
            options = {}

        if Ext.isFunction options
            options = callback: options

        if !options.scope
            options.scope = @

        @doRequest
            path: url + path
            params:
                _method: 'PATCH'
            callback: (opts, success, response) =>
                if options.callback
                    options.callback.call options.scope, opts, success, response

            success: (response, opts) =>
                if options.success
                    options.success.call options.scope, response, opts

            failure: (response, opts) =>
                if options.failure
                    options.failure.call options.scope, response, opts

    hasRawData: (key) ->
        return no unless @rawData
        return @rawData[key]? and @rawData.hasOwnProperty(key)

    setRawData: (key, value, override) ->
        @rawData = @rawData || {}

        if override
            @rawData[key] = value
            return

        if !@hasRawData(key)
            @rawData[key] = value
            return

    getRawData: (key, def) ->
        if @hasRawData(key)
            data = @rawData[key]
            data = def if def and data is null
            return data

    arrayConverter: (field, models, record, key) ->
        record.setRawData(field.name, models)

        if !key || !Ext.isString key
            key = 'name'

        _store = []

        if models?
            for model in models
                _store.push model[key] || model
        return _store

, (self) ->
    @onExtended (cls, config) ->

        cls.xhrOverrideResponse = (response, options) ->
            # simulate response for proxy reader
            if response.status == 201 and options.operation.action == 'create'
                response.responseText = Ext.encode
                    _embedded:
                        items: Ext.decode response.responseText

            if response.status == 200 and options.operation.action == 'read'
                res = Ext.decode response.responseText

                if !res._embedded
                    response.responseText = Ext.encode
                        _embedded:
                            items: res

            return response

        cls.xhrOverrideOptions = (options) ->
            options.cors = yes if typeof options.cors is 'undefined'
            options.async = yes if typeof options.async is 'undefined'
            options.useDefaultXhrHeader = no if typeof options.useDefaultXhrHeader is 'undefined'

            # runtime config
            # record.save({modthod: 'PUT', ....})
            if options.operation.method
                options.method = options.operation.method
                delete options.operation.method

            switch options.method
                when 'POST', 'PUT', 'PATCH', 'DELETE'

                    options.params = {} if !options.params

                    Ext.merge options.params, '_method': options.method

                    # runtime writer transform
                    if options.jsonData and options.writerTransform
                        options.jsonData = options.writerTransform(options.jsonData)

                    # sloved by writer.writeRecordId = no
                    # if options.jsonData
                    #     # remove id property no need on server side
                    #     delete options.jsonData[options.proxy.model.idProperty]

                    # if options.jsonData
                    #     options.params = {}
                    #     params = options.jsonData
                    #     # remove id property no need on server side
                    #     delete params[options.proxy.model.idProperty]
                    #     options.jsonData = null

                    #     # convert submit form's field case
                    #     # fos_rest.body_listener.array_normalizer.forms = true still not work due to:
                    #     # https://github.com/FriendsOfSymfony/FOSRestBundle/blob/master/EventListener/BodyListener.php#L162-L171
                    #     for key, value of params
                    #         key = key.replace /_([a-z])/g, (g) -> g[1].toUpperCase()
                    #         options.params[key] = value

                    options.method = 'POST'

            if (['POST', 'PUT', 'PATCH'].indexOf(options.method.toUpperCase()) isnt -1) and config.hasFileUpload
                options.params = {}
                options.params['_fileupload'] = yes

            return options

        ###*
         * handle shorthand config
         * api: 'endpoint'
        ###
        if typeof cls.proxyConfig is 'undefined' and typeof config.api isnt 'undefined'
            url = Vcare.cfg.get 'api.baseUrl'

            if typeof config.api is 'object'
                apis = {}
                for k, v of cfg.api
                    apis[k] = v

            if typeof config.api is 'string'
                endpoint = url + config.api
                delete config.api
                apis =
                    create: endpoint
                    read: endpoint
                    update: endpoint
                    destroy: endpoint
                    deletes: endpoint

            cls.proxyConfig =
                type: 'rest'
                cors: yes
                async: yes
                useDefaultXhrHeader: no
                filterParam: 'criteria'
                api: apis
                actionMethods:
                    create: 'POST'
                    read: 'GET'
                    update: config.updateMethod || 'PATCH'
                    destroy: 'DELETE'
                writer:
                    type: 'json'
                    writeRecordId: no
                    allDataOptions:
                        associated: yes
                        persist: yes
                    partialDataOptions:
                        changes: yes
                        critical: yes
                        associated: yes
                        persist: yes
                        serialize: yes
                reader:
                    type: 'json'
                    rootProperty: '_embedded.items'

            if config.writerTransform
                cls.proxyConfig.writer.transform = config.writerTransform
