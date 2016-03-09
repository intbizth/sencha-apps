Ext.define 'Vcare.model.TaxonCategory',
    extend: 'Vcare.model.Taxon'
    api: '/api/taxons/category/'

    writerTransform: fn: (data) ->
        console.log data
        if data.parent
            data.parent = data.parent.id

        return data
