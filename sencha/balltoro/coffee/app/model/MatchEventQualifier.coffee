Ext.define 'Toro.model.MatchEventQualifier',
    extend: 'Toro.model.Base'
    api: '/api/match-event-qualifiers/'

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
