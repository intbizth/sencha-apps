Ext.define 'Moboque.view.event.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-event'

    stores:
        events:
            type: 'store-events'
            autoLoad: yes

    formulas:
        isLoading:
            get: ->

    createRecord: (record) ->
        return record if record
        return new (@data.events.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
