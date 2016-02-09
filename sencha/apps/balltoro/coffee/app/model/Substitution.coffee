Ext.define 'Balltoro.model.Substitution',
    extend: 'Balltoro.model.Base'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'playerOff'
        reference: 'Personal'
    ,
        name: 'playerOn'
        reference: 'Personal'
    ,
        name: 'side'
        type: 'string'
    ,
        name: 'minute'
        type: 'integer'
    ,
        name: 'second'
        type: 'integer'
    ,
        name: 'eventOff'
        type: 'int'
    ,
        name: 'eventOn'
        type: 'int'
    ]
