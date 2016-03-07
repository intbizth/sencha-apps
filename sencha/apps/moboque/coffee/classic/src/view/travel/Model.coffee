Ext.define 'Moboque.view.travel.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-travel'

    stores:
        travels:
            type: 'store-travel'
            autoLoad: yes


    createRecord: (record) ->
        return record if record
        return new (@data.travels.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
