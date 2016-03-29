Ext.define 'Moboque.model.News',
    extend: 'Moboque.model.Translatable'

    api: '/api/news/'

    fields: [
        name: 'title'
        persist: no
        convert: (v, r) -> r.getTitle()
    ,
        name: 'sub_title'
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
        name: 'newsCategory'
        reference:
            type: 'NewsCategory'
            role: 'newsCategory'
            associationKey: 'news_category'
            getterName: 'getNewsCategory'
            setterName: 'setNewsCategory'
    ]

    getTitle: -> @trans 'title'
    getSubTitle: -> @trans 'sub_title'
    getDetail: -> @trans 'detail'
        
    getNewsCategoryTitle: ->
        news = @getNewsCategory()
        return news.get("title") if news
        return ''

    writerTransform: fn: (data) ->
        if data.newsCategory
            data.newsCategory = data.newsCategory.id

        if data.parent
            data.parent = data.parent.id

        if data.translations
            for locale of data.translations
                if !locale
                    delete data.translations[locale]
                else
                    for prop of data.translations[locale]
                        # @see \Sylius\Bundle\TaxonomyBundle\Form\Type\TaxonTranslationType
                        if -1 == Ext.Array.indexOf ['title', 'sub_title', 'detail'], prop
                            delete data.translations[locale][prop]

        return data

    validators:
        link: 'presence'
#        state: 'presence'
