Ext.define 'Balltoro.model.ClubPersonal',
    extend: 'Balltoro.model.Base'
    api: '/api/club-personals/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'start_date'
        dateWriteFormat: 'Y-m-d'
        type: 'date'
    ,
        name: 'end_date'
        dateWriteFormat: 'Y-m-d'
        type: 'date'
    ,
        name: 'signed_date'
        dateWriteFormat: 'Y-m-d'
        type: 'date'
    ,
        name: 'is_active'
        type: 'boolean'
    ,
        name: 'club'
        reference: 'Club'
    ,
        name: 'position'
        reference: 'PersonalPosition'
    ,
        name: 'personal'
        reference: 'Personal'
    ,
        name: 'season'
        reference: 'Season'
    ]
