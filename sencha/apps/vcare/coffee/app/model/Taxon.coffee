Ext.define 'Vcare.model.Taxon',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxons/'

    fields: [
        name: 'code'
        type: 'string'
    ]

    getName: -> @trans 'name'
