Ext.define 'Vcare.model.Product',
    extend: 'Vcare.model.Translatable'
    api: '/api/products/'

    associationWriterIdBased: yes
    translationFields: ['name', 'description', 'short_description', 'meta_description', 'meta_keyword']

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'description'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'sku'
        type: 'string'
    ,
        name: 'master_variant'
        reference:
            type: 'ProductVariant'
            role: 'master_variant'
            unique: yes
            associationKey: 'master_variant'
            getterName: 'getMasterVariant'
            setterName: 'setMasterVariant'
    ]

    getName: -> @trans 'name'
    getDescription: -> @trans 'description'

    writerTransform: fn: (data) ->
        delete data.master_variant if Ext.Object.isEmpty(data.master_variant)

        if data.master_variant
            delete data.master_variant.id
            #todo manage other data in master variant

        return data
