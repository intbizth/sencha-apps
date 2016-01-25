Ext.define 'Toro.model.PersonalPosition',
    extend: 'Toro.model.Base'
    api: '/api/personal-positions/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ,
        name: 'short_name'
        type: 'string'
    ,
        name: 'position_color'
        type: 'string'
    ]
