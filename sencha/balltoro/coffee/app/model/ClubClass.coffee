Ext.define 'Toro.model.ClubClass',
    extend: 'Toro.model.Base'
    api: '/api/club-classes/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
