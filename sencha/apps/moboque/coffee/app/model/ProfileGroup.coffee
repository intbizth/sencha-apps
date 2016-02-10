Ext.define 'Moboque.model.ProfileGroup',
    extend: 'Moboque.model.Base'
    api: '/api/profile-groups/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
