Ext.define 'Vcare.view.country.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-country'

    stores:
        countries:
            type: 'store-countries'
            autoLoad: yes

    createRecord: ->
        return new (@data.countries.getModel())()
