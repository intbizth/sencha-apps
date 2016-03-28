Ext.define 'Moboque.view.feeder.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-feeder'

    stores:
        feeders:
            type: 'store-feeders'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.feeders.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
