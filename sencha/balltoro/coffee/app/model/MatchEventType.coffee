Ext.define 'Toro.model.MatchEventType',
    extend: 'Toro.model.Base'
    api: '/api/match-event-types/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]
