Ext.define 'Balltoro.model.ProfileGroup',
    extend: 'Balltoro.model.Base'
    api: '/api/profile-groups/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
