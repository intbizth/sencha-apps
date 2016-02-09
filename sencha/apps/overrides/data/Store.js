Ext.define('Ext.overrides.data.Store', {
    override: 'Ext.data.Store',

    filter: function(filters, value, supressEvent) {
        var filters, i;

        if (Ext.isString(filters)) {
            filters = [{
                property: filters,
                value: value
            }];
        }

        if (!Ext.isArray(filters)) {
            filters = [filters];
        }

        var fts = filters;

        if (this.remoteFilter === false) {
            fts = []

            for(i = 0; i < filters.length; i++) {
                var ft = filters[i];

                if (!ft.hasOwnProperty('filterFn')) {
                    // ucfirst
                    var property = ft.property.charAt(0).toUpperCase() + ft.property.slice(1);
                    var value = ft.value;

                    if (typeof value === 'object') {
                        ft = {
                            filterFn: function(item) {
                                var result = false;

                                // now only support compare object with referrence model.
                                if (item = item['get' + property]()) {
                                    var idProperty = value.idProperty
                                    result = item.get(idProperty) == value.get(idProperty)
                                }

                                return result
                            }
                        };
                    }
                }

                fts.push(ft);
            }
        }

        this.suppressNextFilter = !!supressEvent;
        this.getFilters().add(fts);
        this.suppressNextFilter = false;
    }
});
