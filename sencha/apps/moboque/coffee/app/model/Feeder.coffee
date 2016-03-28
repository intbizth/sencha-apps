Ext.define 'Moboque.model.Feeder',
    extend: 'Moboque.model.Base'
    api: '/api/feeder/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'state'
        type: 'string'
    ]

    validators:
        title: 'presence'
        description: 'presence'
        state: 'presence'
