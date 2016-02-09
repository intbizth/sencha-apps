/**
 * None Strict mode override
 * http://docs.sencha.com/extjs/6.0/6.0.1-classic/#!/api/Ext.data.proxy.Ajax
*/

// Strict mode override
Ext.define('Ext.overrides.data.proxy.Server', {
    override: 'Ext.data.proxy.Server',

    encodeFilters: function(filters) {
        var out = [], i;

        for (i = 0; i < filters.length; i++) {
            out.push(filters[i].serialize());
        }

        var filters = {};

        for (i = 0; i < out.length; i++) {
            var value = out[i].value;

            if (typeof value === 'object') {
                if (value.isModel) {
                    value = value.get(value.idProperty);
                }
                else if (value.hasOwnProperty('id')) {
                    value = value.id;
                }
                else {
                    new Error('Not support none identifierable obejct.');
                }
            }

            filters[out[i].property] = value;
        }

        return filters;
    }

    // # TODO
    // # encodeSorters: function(sorters, preventArray) {
    // #     var out = [],
    // #         length = sorters.length,
    // #         i;
    // #     for (i = 0; i < length; i++) {
    // #         out[i] = sorters[i].serialize();
    // #     }
    // #     return this.applyEncoding(preventArray ? out[0] : out);
    // # },
});
