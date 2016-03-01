Ext.define 'Moboque.model.Meet',
    extend: 'Moboque.model.Base'
    api: '/api/meet/'

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'created_at'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ]

    validators:
        description: 'presence'
        created_at: 'presence'
