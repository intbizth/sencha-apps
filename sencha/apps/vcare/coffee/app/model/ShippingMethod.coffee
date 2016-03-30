Ext.define 'Vcare.model.ShippingMethod',
    extend: 'Vcare.model.Translatable'
    api: '/api/shipping-methods/'

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
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'category'
        reference:
            type: 'Category'
            role: 'category'
            associationKey: 'category'
            getterName: 'getCategory'
            setterName: 'setCategory'
    ]

    getName: -> @trans 'name'

    validators:
        code: 'presence'

    writerTransform: fn: (data) ->
        if data.category
            data.category = data.category.id

        if data.translations
            for locale of data.translations
                if !locale
                    delete data.translations[locale]
                else
                    for prop of data.translations[locale]
                        if -1 == Ext.Array.indexOf ['name'], prop
                            delete data.translations[locale][prop]

        return data
