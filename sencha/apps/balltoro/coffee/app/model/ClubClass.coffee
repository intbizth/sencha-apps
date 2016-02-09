Ext.define 'Balltoro.model.ClubClass',
    extend: 'Balltoro.model.Base'
    api: '/api/club-classes/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ]
