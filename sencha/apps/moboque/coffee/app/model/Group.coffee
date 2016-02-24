Ext.define 'Moboque.model.Group',
    extend: 'Moboque.model.Base'
    api: '/api/groups/'

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'color'
        type: 'string'
    ]

    validators:
        name: 'presence'
        color: 'presence'
