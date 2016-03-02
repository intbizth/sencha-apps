Ext.define 'Moboque.view.activity.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-activity'

    stores:
        activities:
            type: 'store-activities'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.activities.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
