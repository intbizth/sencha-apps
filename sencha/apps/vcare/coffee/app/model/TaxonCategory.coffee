Ext.define 'Vcare.model.TaxonCategory',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxons/category/'

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
            type: 'TaxonCategory'
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
                for prop of data.translations[locale]
                    # @see \Sylius\Bundle\TaxonomyBundle\Form\Type\TaxonTranslationType
                    if -1 == Ext.Array.indexOf ['name', 'permalink', 'description'], prop
                        delete data.translations[locale][prop]

        return data
