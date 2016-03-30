Ext.define 'Vcare.model.PaymentMethod',
    extend: 'Vcare.model.Translatable'
    api: '/api/payment-methods/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'description'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getDescription()
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'gateway'
        mapping: (data) ->
            return Ext.data.StoreManager
                .lookup('store-payment-gateways')
                .getById(data.gateway)
    ]

    getName: -> @trans 'name'
    getDescription: -> @trans 'description'

    validators:
        code: 'presence'

    writerTransform: fn: (data) ->
        if data.gateway
            data.gateway = data.gateway.id

        if data.translations
            for locale of data.translations
                if !locale
                    delete data.translations[locale]
                else
                    for prop of data.translations[locale]
                        if -1 == Ext.Array.indexOf ['name', 'description'], prop
                            delete data.translations[locale][prop]

        return data
