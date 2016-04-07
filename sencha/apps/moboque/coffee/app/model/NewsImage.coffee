Ext.define 'Moboque.model.NewsImage',
    extend: 'Moboque.model.Base'
    api: '/api/news/images/'
    hasFileUpload: true

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'news'
        reference:
            type: 'News'
            role: 'news'
            associationKey: 'news'
            getterName: 'getNews'
            setterName: 'setNews'
    ,
        name: 'image'
        type: 'auto'
    ]

    getNewsTitle: ->
        news = @getNews()
        return news.get("title") if news
        return ''

    validators:
        description: 'presence'

    writerTransform: fn: (data) ->
        if data.news
            data.news = data.news.id
        return data
