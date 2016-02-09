Ext.define 'Balltoro.model.MatchEventQualifier',
    extend: 'Balltoro.model.Base'
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
