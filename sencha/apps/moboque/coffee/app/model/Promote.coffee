Ext.define 'Moboque.model.Promote',
    extend: 'Moboque.model.Base'
    api: '/api/promotes/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]

    validators:
        description: 'presence'
