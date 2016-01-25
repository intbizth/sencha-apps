Ext.define 'Ext.overrides.data.Store',
    override: 'Ext.data.Store'

    filter: (filters, value, supressEvent) ->
        if Ext.isString filters
            filters = [
                property: filters
                value: value
            ]

        if !Ext.isArray filters
            filters = [filters]

        fts = filters
        if @remoteFilter == no
            fts = []
            for ft in filters
                if !ft.hasOwnProperty 'filterFn'
                    # ucfirst
                    property = ft.property.charAt(0).toUpperCase() + ft.property.slice(1)
                    value = ft.value

                    if typeof value == 'object'
                        ft = filterFn: (item) ->
                            result = no
                            # now only support compare object with referrence model.
                            if item = item['get' + property]()
                                idProperty = value.idProperty
                                result = item.get(idProperty) == value.get(idProperty)
                            return result
                fts.push ft

        @suppressNextFilter = !!supressEvent
        @getFilters().add fts
        @suppressNextFilter = no
        return
