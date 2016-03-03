Ext.define 'Vcare.view.taxonomy.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-taxonomy'

    stores:
        taxonomies:
            type: 'store-taxonomies'
            autoLoad: yes

        taxons:
            type: 'store-taxons'
            autoLoad: no

        locales:
            type: 'store-locales'
            autoLoad: yes

    createTaxonomyRecord: (record) ->
        return record if record
        return new (@data.taxonomies.getModel())()

    prepareTaxonomyData: (record) ->
        record = @createTaxonomyRecord record

        return record
