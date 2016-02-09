Ext.define 'Balltoro.model.Match',
    extend: 'Balltoro.model.Base'
    api: '/api/matches/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'match_day'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ,
        name: 'stadium'
        type: 'string'
    ,
        name: 'result'
        type: 'string'
        defaultValue: '0 : 0'
    ,
        name: 'end_match'
        type: 'boolean'
        defaultValue: no
    ,
        name: 'state'
        type: 'auto'
    ,
        name: 'start_time'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ,
        name: 'handicap'
        type: 'number'
    ,
        name: 'country'
        reference: 'Country'
    ,
        name: 'competition'
        reference: 'Competition'
    ,
        name: 'season'
        reference: 'Season'
    ,
        name: 'homeClub'
        mapping: 'home_club'
        reference: 'ClubMember'
    ,
        name: 'awayClub'
        mapping: 'away_club'
        reference: 'ClubMember'
    ,
        name: 'homeFormation'
        mapping: 'home_formation'
        reference: 'Formation'
    ,
        name: 'awayFormation'
        mapping: 'away_formation'
        reference: 'Formation'
    ,
        name: 'home_players'
        type: 'auto'
    ,
        name: 'away_players'
        type: 'auto'
    ]
