Ext.define('Ext.overrides.data.Connection', {
    override: 'Ext.data.Connection',

    // support recursive object encode
    // see http://docs.sencha.com/extjs/6.0/6.0.1-classic/#!/api/Ext.Object
    setOptions: function(options, scope) {
        var params = options.params || {};
        var extraParams = this.getExtraParams();

        if (Ext.isFunction(params)) {
            params = params.call(scope, options);
        }

        if (Ext.isObject(params)) {
            params = Ext.Object.toQueryString(params, true);
        }

        if (Ext.isObject(extraParams)) {
            this.setExtraParams(Ext.Object.toQueryString(extraParams, true));
        }

        options.params = params

        return this.callParent([options, scope]);
    }
});
