Ext.define 'Toro.store.Base',
    extend: 'Ext.data.Store'

    # private function
    doRequest: (config) ->
        return Ext.Ajax.request
            cors: yes
            async: yes
            useDefaultXhrHeader: no
            url: config.path || Toro.cfg.getWith 'api.baseUrl'
            method: config.method || 'GET'
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

    # get all model's id
    getIds: ->
        return null if !@count()
        ids = []
        @each (rec) -> ids.push rec.getId()
        return ids

    getByIds: (ids) ->
        rs = []
        @each (rec) ->
            rs.push rec if Ext.Array.contains ids, rec.getId()
        return if rs.length then rs else null

    ## delete records
    deletes: (records, options) ->

        if !records or !records.length
            throw Error 'No records found.'

        if !options
            options = {}

        if Ext.isFunction options
            options = callback: options

        if !options.scope
            options.scope = @

        if records.length == 1
            rowIndex = @indexOf(records[0])

            records[0].erase
                callback: (record, operation, success) =>
                    if options.callback
                        options.callback.call options.scope, [record], @, success

                success: (record, operation) =>
                    if options.success
                        options.success.call options.scope, [record], @

                failure: (record, operation) =>
                    @insert(rowIndex, record)
                    if options.failure
                        options.failure.call options.scope, [record], @

            return

        # mutiple records
        if !options.url
            url = @checkApiUrl('deletes')

        ids = []
        Ext.each records, (record) ->
            if Ext.isNumber record
                ids.push(record)
            else
                ids.push(record.id)

        @doRequest
            path: url
            method: 'POST'
            params:
                _method: 'DELETE'
                ids: ids
            success: (response, opts) =>
                # ถ้าใ้ช @remove(records) จะไม่มีปัญหากรณี row ของ grid อยู่ห่างกัน
                Ext.each (records), (record) =>
                    @remove([record])

                if options.success
                    options.success.call options.scope, records, @
            failure: (response, opts) =>
                if options.failure
                    options.failure.call options.scope, records, @

        return

    ## enabled states
    enabledStates: (records, state, fieldname, options) ->
        if !records or !records.length
            throw Error 'No records found.'

        if !options
            options = {}

        if Ext.isFunction options
            options = callback: options

        if !options.scope
            options.scope = @

        if records.length == 1
            record = records[0]

            # route_api_news_enabled_state
            path = record.get('id') + '/' + state + '/' + fieldname + '/enabled-state'

            record.manageUpdateRecord record, path,
                success: (response, opts) =>
                    if options.success
                        options.success.call options.scope, [record], response, opts

                failure: (response, opts) =>
                    if options.failure
                        options.failure.call options.scope, [record], response, opts

            return

        # mutiple records
        if !options.url
            url = @checkApiUrl('update')

        ids = []
        Ext.each records, (record) ->
            ids.push(record.id)

        @doRequest
            path: url + state + '/' + fieldname + '/enabled-state'
            method: 'POST'
            params:
                _method: 'PATCH'
                ids: ids
            success: (response, opts) =>
                if options.success
                    options.success.call options.scope, records, response, opts
            failure: (response, opts) =>
                if options.failure
                    options.failure.call options.scope, records, response, opts
