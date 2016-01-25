Ext.define 'Toro.model.Tag',
    extend: 'Toro.model.Base'
    api: '/api/taggings/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
