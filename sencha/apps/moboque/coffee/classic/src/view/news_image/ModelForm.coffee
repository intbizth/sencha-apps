Ext.define 'Moboque.view.news_image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-news-image-form'

    stores:
        newsList:
            type: 'store-news'
            autoLoad: yes
            pageSize: 25

    formulas:
        news:
            get: ->
                @get('record').getNews()

            set: (val) ->
                @get('record').setNews val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        newsId = @get('record').getPrevious('news_id')

        if newsId
            @get('record').setNews @get('newsList').getById(newsId)
            record.commit()
