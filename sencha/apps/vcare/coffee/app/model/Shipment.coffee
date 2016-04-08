Ext.define 'Vcare.model.Shipment',
    extend: 'Vcare.model.Translatable'
    api: '/api/shipments/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'state'
        type: 'string'
        persist: no
    ,
        name: 'tracking'
        type: 'string'
    ,
        name: 'units'
        persist: no
    ,
        name: 'method'
        persist: no
    ,
        name: 'order'
        persist: no

    ]

    getMethodName: ->
        data = @data.method
        locale = data.translations[data.current_locale]
        locale = data.translations[data.fallback_locale] if !locale
        locale = (data.translations[data.current_locale] = {}) if !locale

        return locale['name']
