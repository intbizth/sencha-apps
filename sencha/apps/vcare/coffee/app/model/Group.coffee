Ext.define 'Vcare.model.Group',
    extend: 'Vcare.model.Base'
    api: '/api/groups/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
