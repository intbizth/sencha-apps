Ext.define 'Moboque.view.promote.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-promote'

    stores:
        promotes:
            type: 'store-promotes'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.promotes.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        promoteCategoryRecord = record.getPromoteCategory()

        if promoteCategoryRecord and record.get('promoteCategory_id') != promoteCategoryRecord.getId()
            record.set('promoteCategory_id', promoteCategoryRecord.getId())
            record.commit()

        return record
