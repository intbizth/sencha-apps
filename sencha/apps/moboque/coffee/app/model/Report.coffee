Ext.define 'Moboque.model.Report',
    extend: 'Moboque.model.Base'
    api: '/api/reports/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'state'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]

    validators:
        title: 'presence'
        state: 'presence'
        description: 'presence'
