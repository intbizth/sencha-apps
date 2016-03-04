Ext.define 'Moboque.model.Meet',
    extend: 'Moboque.model.Base'
    api: '/api/meet/'

    fields: [
        name: 'description'
        type: 'string'
    ]

    validators:
        description: 'presence'
