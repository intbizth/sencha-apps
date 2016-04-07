Ext.define 'Moboque.model.NewsCategory',
    extend: 'Moboque.model.Base'
    api: '/api/news/categories/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    ]
