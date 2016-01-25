Ext.define 'Toro.model.ProfileGroup',
    extend: 'Toro.model.Base'
    api: '/api/profile-groups/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
