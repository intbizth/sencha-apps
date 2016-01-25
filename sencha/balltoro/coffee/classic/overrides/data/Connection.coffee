Ext.define 'Ext.overrides.data.Connection',
    override: 'Ext.data.Connection'

    # support recursive object encode
    # see http://docs.sencha.com/extjs/6.0/6.0.1-classic/#!/api/Ext.Object
    setOptions: (options, scope) ->
        params = options.params || {}
        extraParams = @getExtraParams()

        if Ext.isFunction params
            params = params.call scope, options

        if Ext.isObject params
            params = Ext.Object.toQueryString params, yes

        if Ext.isObject extraParams
            @setExtraParams Ext.Object.toQueryString extraParams, yes

        options.params = params

        return @callParent [options, scope]
