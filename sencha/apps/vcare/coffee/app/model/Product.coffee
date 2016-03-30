Ext.define 'Vcare.model.Product',
    extend: 'Vcare.model.Translatable'
    api: '/api/products/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'sku'
        type: 'string'
    ,
        name: 'master_variant'
        reference:
            type: 'ProductVariant'
            role: 'master_variant'
            associationKey: 'master_variant'
            getterName: 'getMasterVariant'
            setterName: 'setMasterVariant'
    ]

    writerTransform: fn: (data) ->
        if data.translations
            for locale of data.translations
                if !locale
                    delete data.translations[locale]
                else
                    for prop of data.translations[locale]
                        if -1 == Ext.Array.indexOf ['name', 'description', 'short_description', 'meta_description', 'meta_keywords'], prop
                            delete data.translations[locale][prop]

        return data
