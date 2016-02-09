Ext.define 'Balltoro.model.Tag',
    extend: 'Balltoro.model.Base'
    api: '/api/taggings/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
