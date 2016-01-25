###*
 * None Strict mode override
 * http://docs.sencha.com/extjs/6.0/6.0.1-classic/#!/api/Ext.data.proxy.Ajax
###

# Strict mode override
Ext.define 'Ext.overrides.data.proxy.Server',
    override: 'Ext.data.proxy.Server'

    encodeFilters: (filters) ->
        out = []
        for filter in filters
            out.push filter.serialize()

        filters = {}
        for o in out
            value = o.value

            if typeof value == 'object'
                if value.isModel
                    value = value.get value.idProperty
                else if value.hasOwnProperty 'id'
                    value = value.id
                else
                    new Error 'Not support none identifierable obejct.'

            filters[o.property] = value

        return filters

    # TODO
    # encodeSorters: function(sorters, preventArray) {
    #     var out = [],
    #         length = sorters.length,
    #         i;
    #     for (i = 0; i < length; i++) {
    #         out[i] = sorters[i].serialize();
    #     }
    #     return this.applyEncoding(preventArray ? out[0] : out);
    # },
