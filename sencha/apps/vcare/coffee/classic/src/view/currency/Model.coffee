Ext.define 'Vcare.view.currency.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-currency'

    stores:
        currencies:
            type: 'store-currencies'
            autoLoad: yes

    createRecord: ->
        return new (@data.currencies.getModel())()
