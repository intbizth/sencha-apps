Ext.define 'Moboque.model.Link',
    extend: 'Moboque.model.Base'
    api: '/api/link/'

    fields: [
        name: 'label'
        type: 'string'
    ,
        name: 'url'
        type: 'string'
    ]

    validators:
        label: 'presence'
        url: 'presence'
