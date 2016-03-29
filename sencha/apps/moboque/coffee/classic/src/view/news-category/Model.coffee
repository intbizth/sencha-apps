Ext.define 'Moboque.view.news-category.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-news-category'

    stores:
        newsCategories:
            type: 'store-news-categories'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.newsCategories.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
