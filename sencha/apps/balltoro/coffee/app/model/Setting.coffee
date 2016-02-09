Ext.define 'Balltoro.model.Setting',
    extend: 'Balltoro.model.Base'
    idProperty: 'id'
    identifier: 'uuid'

    proxy:
        type: 'localstorage',
        id : 'toro.app.settings'

    fields: [
        name: 'id'
        type: 'string'
    ,
        name: 'value'
        type: 'auto'
    ]

    value: (key) ->
        value = @get 'value'

        return null if !value

        if Ext.isString value
            try value = Ext.decode value
            catch e # nothing

        return value if !key
        return value[key]

    has: (key) -> !!@value key
