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

        return record
