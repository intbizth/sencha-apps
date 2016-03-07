Ext.define 'Moboque.model.Gift',
    extend: 'Moboque.model.Base'
    api: '/api/gift/'

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
