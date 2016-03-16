Ext.define 'Moboque.model.TravelTranslation',
    extend: 'Moboque.model.Base'
    api: '/api/travel/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]

    validators:
        title: 'presence'
        description: 'presence'
