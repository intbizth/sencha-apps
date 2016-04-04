Ext.define 'Vcare.model.Product',
    extend: 'Vcare.model.Translatable'
    api: '/api/products/'

    translationFields: ['name', 'description', 'short_description', 'meta_description', 'meta_keywords']

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
        name: 'master_variant'
        persist: no
        reference:
            type: 'ProductVariant'
            role: 'master_variant'
            associationKey: 'master_variant'
            getterName: 'getMasterVariant'
            setterName: 'setMasterVariant'
    ,
        name: 'main_taxon'
        persist: no
        reference:
            type: 'Taxonomy'
            role: 'main_taxon'
            associationKey: 'main_taxon'
            getterName: 'getMainTaxon'
            setterName: 'setMainTaxon'
    ]

    getName: -> @trans 'name'
    getDescription: -> @trans 'description'

    writerTransform: fn: (data) ->
        delete data.master_variant if Ext.Object.isEmpty(data.master_variant)

        if data.master_variant
            delete data.master_variant.id

        if data.main_taxon
            mainTaxon = data.main_taxon.id
            data.main_taxon = mainTaxon

        return data
