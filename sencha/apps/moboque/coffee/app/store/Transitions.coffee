Ext.define 'Moboque.store.Transitions',
    extend: 'Ext.data.Store'
    alias: 'store.store-transitions'
    storeId: 'store-transitions'

    proxy:
        type: 'ajax'
        url: '/api/transitions/{name}/{id}'
        reader:
            type: 'json'

    updateState: (options) ->
        me = @
        options.params['_method'] = options.method || 'PATCH'
        callback = options.callback || Ext.emptyFn
        scope = options.scope || me

        Ext.Ajax.request
            method: 'POST'
            url: '/api/transitions/{name}/{id}/{transition}'
            params: options.params

            success: (response) ->
                # reload
                me.reload
                    callback: (rs, operation, success) ->
                        callback.call scope, yes, rs

            failure: (response) ->
                callback.call scope, no, Ext.decode(response.responseText)
