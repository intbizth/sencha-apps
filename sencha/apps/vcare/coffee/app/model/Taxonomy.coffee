Ext.define 'Vcare.model.Taxonomy',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxonomies/'

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        persist: no
        convert: (v, r) -> r.getName()
    ]

    getName: -> @trans 'name'

    writerTransform: fn: (data) ->

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
