Ext.define 'Moboque.view.news.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-news'

    stores:
        news:
            type: 'store-news'
            autoLoad: yes
        locales:
            type: 'store-locale'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
#        return new (@data.news.getModel())()
        console.log @get('defaultLocale')
        return new (@data.news.getModel({
            current_locale: @get('defaultLocale')
        }))()

    prepareData: (record) ->
        record = @createRecord record

        newsCategoryRecord = record.getNewsCategory()

        console.log 'DDD', newsCategoryRecord
        if newsCategoryRecord and record.get('newsCategory_id') != newsCategoryRecord.getId()
            record.set('newsCategory_id', newsCategoryRecord.getId())
            record.commit()

        return record
