Ext.define 'Vcare.model.ProfileGroup',
    extend: 'Vcare.model.Base'
    api: '/api/profile-groups/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
