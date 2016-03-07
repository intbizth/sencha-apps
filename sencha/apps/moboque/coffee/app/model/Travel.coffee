Ext.define 'Moboque.model.Travel',
    extend: 'Moboque.model.Base'
    api: '/api/travel/'

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
