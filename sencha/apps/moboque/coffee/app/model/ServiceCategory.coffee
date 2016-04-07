Ext.define 'Moboque.model.ServiceCategory',
    extend: 'Moboque.model.Base'
    api: '/api/service-categories/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    ]
