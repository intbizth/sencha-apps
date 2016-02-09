Ext.define 'Balltoro.util.HttpStateProvider',
    extend: 'Ext.state.Provider'
    requires: ['Ext.state.Provider', 'Ext.Ajax']

    alias: 'http-state-provider'

    config:
        userId: null
        url: null
        stateRestoredCallback: null

    constructor: (config) ->

        if !config.userId
            throw 'App.util.HttpStateProvider: Missing userId'

        if !config.url
            throw 'App.util.HttpStateProvider: Missing url'

        @initConfig config
        @restoreState()
        @callParent arguments
        return

    set: (name, value) ->

        if typeof value == 'undefined' || value == null
            @clear name
            return

        @saveStateForKey name, value
        @callParent arguments
        return

    # private
    restoreState: ->

        callback = @getStateRestoredCallback();

        Ext.Ajax.request
            url: @getUrl()
            method: 'GET'
            params:
                userId: @getUserId()

            success: (response, options) ->
                result = JSON.parse response.responseText.trim()

                for property in result
                    if result.hasOwnProperty property
                        @state[property] = @decodeValue result[property]

                callback() if callback

            failure: ->
                console.log 'App.util.HttpStateProvider: restoreState failed', arguments
                callback() if callback

    # private
    clear: (name) ->
        @clearStateForKey name
        @callParent arguments
        return

    # private
    saveStateForKey: (key, value) ->
        Ext.Ajax.request
            url: me.getUrl()
            method: 'POST'
            params:
                userId: me.getUserId()
                key: key
                value: me.encodeValue value

            failure: ->
                console.log 'App.util.HttpStateProvider: saveStateForKey failed', arguments

    # private
    clearStateForKey: (key) ->
        Ext.Ajax.request
            url: me.getUrl()
            method: 'DELETE'
            params:
                userId: me.getUserId()
                key: key

            failure: ->
                console.log 'App.util.HttpStateProvider: clearStateForKey failed', arguments
