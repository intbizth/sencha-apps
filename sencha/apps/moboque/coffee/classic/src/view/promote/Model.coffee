Ext.define 'Moboque.view.promote.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-promote'

    stores:
        promotes:
            type: 'store-promote'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.promotes.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        promoteCatRecord = record.getPromoteCategory()
        if promoteCatRecord and record.get('promoteCategory_id') != promoteCatRecord.getId()
            record.set('promoteCategory_id', promoteCatRecord.getId())
            record.commit()

        return record
