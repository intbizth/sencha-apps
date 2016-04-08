Ext.define 'Moboque.model.Gift',
    extend: 'Moboque.model.Base'
    api: '/api/gifts/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]
