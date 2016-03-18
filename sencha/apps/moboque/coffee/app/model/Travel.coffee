Ext.define 'Moboque.model.Travel',
    extend: 'Moboque.model.Translatable'

    api: '/api/travel/'

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'title'
        persist: no
        convert: (v, r) -> r.getTitle()
    ,
        name: 'description'
        persist: no
        convert: (v, r) -> r.getDescription()

#    ,
#        name: 'parent'
#        reference:
#            type: 'Travel'
#            role: 'parent'
#            associationKey: 'parent'
#            getterName: 'getTravel'
#            setterName: 'setParent'
    ]

    getTitle: -> @trans 'title'
    getDescription: -> @trans 'description'

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
                        if -1 == Ext.Array.indexOf ['title', 'description'], prop
                            delete data.translations[locale][prop]

        return data
