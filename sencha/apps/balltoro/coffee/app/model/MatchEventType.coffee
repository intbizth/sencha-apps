Ext.define 'Balltoro.model.MatchEventType',
    extend: 'Balltoro.model.Base'
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
