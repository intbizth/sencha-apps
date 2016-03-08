Ext.define 'Vcare.view.taxon.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-taxon'

    stores:
        taxons:
            type: 'store-taxons'
            autoLoad: yes

        locales:
            type: 'store-locales'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.taxons.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
