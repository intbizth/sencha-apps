Ext.define 'Vcare.model.TaxonBrand',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxons/brand/'

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'parent'
        reference:
            type: 'TaxonBrand'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    getName: -> @trans 'name'

    writerTransform: fn: (data) ->
        if data.parent
            data.parent = data.parent.id

        if data.translations
            for locale of data.translations
                if !locale
                    delete data.translations[locale]
                else
                    for prop of data.translations[locale]
                        # @see \Sylius\Bundle\TaxonomyBundle\Form\Type\TaxonTranslationType
                        if -1 == Ext.Array.indexOf ['name', 'permalink', 'description'], prop
                            delete data.translations[locale][prop]

        return data
