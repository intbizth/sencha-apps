Ext.define 'Moboque.view.gift.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-gift'

    stores:
        gifts:
            type: 'store-gift'
            autoLoad: yes


    createRecord: (record) ->
        return record if record
        return new (@data.gifts.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
