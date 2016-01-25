Ext.define 'Toro.model.NewsCategory',
    extend: 'Toro.model.Base'
    api: '/api/news-categories/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ]
