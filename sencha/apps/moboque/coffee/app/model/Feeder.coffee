Ext.define 'Moboque.model.Feeder',
    extend: 'Moboque.model.Base'
    api: '/api/feeder/'
    hasFileUpload: true

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
        name: 'image'
        type: 'auto'
    ]

    validators:
        title: 'presence'
        description: 'presence'
        state: 'presence'
