Ext.define 'Moboque.view.news.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-news-form'

    stores:
        newsCategories:
            type: 'store-news-categories'
            autoLoad: yes
            pageSize: 25

    formulas:
        isPhantom:
            get: -> @get('record').phantom

        newsCategory:
            get: -> @get('record').getNewsCategory()
            set: (val) -> @get('record').setNewsCategory val

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    beforeSubmit: (record) -> record.updateTranslations()
    beforeCancel: (record) -> record.updateTranslations()
    onSubmitSuccess: (record) -> @get('news').reload()
    reject: ->
        @get('record').reject()
        newsCategoryId = @get('record').getPrevious('newsCategory_id')

        if newsCategoryId
            @get('record').setNewsCategory @get('newsCategories').getById(newsCategoryId)
            record.commit()
