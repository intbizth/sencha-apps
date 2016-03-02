Ext.define 'Moboque.model.Activity',
    extend: 'Moboque.model.Base'
    api: '/api/activities/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    ,
        name: 'detail'
        type: 'string'
    ,
        name: 'link'
        type: 'string'
    ]

    validators:
        title: 'presence'
        detail: 'presence'
        link: 'presence'
