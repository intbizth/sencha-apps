Ext.define 'Moboque.view.emergency-call.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-emergency-call'

    stores:
        tels:
            type: 'store-emergency-calls'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.tels.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
