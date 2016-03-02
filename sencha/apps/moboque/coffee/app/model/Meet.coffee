Ext.define 'Moboque.model.Meet',
    extend: 'Moboque.model.Base'
    api: '/api/meet/'

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'latitude'
        type: 'string'
    ,
        name: 'longitude'
        type: 'string'
    ]

    validators:
        description: 'presence'
        latitude: 'presence'
        longitude: 'presence'
