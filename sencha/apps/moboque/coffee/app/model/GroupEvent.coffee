Ext.define 'Moboque.model.GroupEvent',
    extend: 'Moboque.model.Base'
    api: '/api/events/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
