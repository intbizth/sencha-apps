Ext.define 'Moboque.model.News',
    extend: 'Moboque.model.Translatable'

    api: '/api/news/'

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'title'
        persist: no
        convert: (v, r) -> r.getTitle()
    ,
        name: 'subTitle'
        persist: no
        convert: (v, r) -> r.getSubTitle()
    ,
        name: 'detail'
        persist: no
        convert: (v, r) -> r.getDetail()
    ,
        name: 'link'
        type: 'string'
    ,
        name: 'state'
        type: 'string'
#    ,
#        name: 'parent'
#        reference:
#            type: 'News'
#            role: 'parent'
#            associationKey: 'parent'
#            getterName: 'getNews'
#            setterName: 'setParent'
    ]

    getTitle: -> @trans 'title'
    getSubTitle: -> @trans 'sub_title'
    getDetail: -> @trans 'detail'

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
                        if -1 == Ext.Array.indexOf ['title', 'subTitle', 'description'], prop
                            delete data.translations[locale][prop]

        return data
