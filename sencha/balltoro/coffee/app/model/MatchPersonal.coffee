Ext.define 'Toro.model.MatchPersonal',
    extend: 'Toro.model.Base'
    api: '/api/match-personals/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'match'
        reference: 'Match'
    ,
        name: 'personal'
        reference: 'Personal'
    ,
        name: 'position'
        reference: 'PersonalPosition'
    ,
        name: 'first_eleven'
        type: 'boolean'
    ,
        name: 'mom'
        type: 'boolean'
    ,
        name: 'shirt_number'
        type: 'int'
        allowNull: yes
        defaultValue: null
    ]
