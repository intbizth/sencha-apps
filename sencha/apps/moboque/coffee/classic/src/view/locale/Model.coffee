Ext.define 'Moboque.view.locale.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-locale'

    stores:
        locales:
            type: 'store-locale'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.locales.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        localeCategoryRecord = record.getLocaleCategory()

        if localeCategoryRecord and record.get('localeCategory_id') != localeCategoryRecord.getId()
            record.set('localeCategory_id', localeCategoryRecord.getId())
            record.commit()

        return record
