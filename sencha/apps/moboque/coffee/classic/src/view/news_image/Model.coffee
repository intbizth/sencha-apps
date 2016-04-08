Ext.define 'Moboque.view.news_image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-news-image'

    stores:
        newsImage:
            type: 'store-news-images'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.newsImage.getModel())()

    prepareData: (record) ->
        record = @createRecord record
#        newsRecord = record.getNewsImage()
#
#        if newsRecord and record.get('news_id') != newsRecord.getId()
#            record.set('news_id', newsRecord.getId())
#            record.commit()
#
        return record
