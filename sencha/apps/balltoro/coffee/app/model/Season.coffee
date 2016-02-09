Ext.define 'Balltoro.model.Season',
    extend: 'Balltoro.model.Base'
    api: '/api/seasons/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'start_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'end_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'competition'
        reference: 'Competition'
    ,
        name: 'club_members'
        type: 'auto'
        critical: yes
        convert: (clubs, rec) ->
            # reader
            rec.arrayConverter(@, clubs, rec, 'id')
        serialize: (clubs, rec) ->
            # writer
            if !clubs.length
                return null

            rec.arrayConverter(@, clubs, rec, 'id')
    ]

    validators:
        name: 'presence'
        code: 'presence'
        start_date: 'presence'
        end_date: 'presence'

    # other method
    getClubMembers: -> @getRawData('club_members')

    getClubMembersLabel: (id) ->
        labels = []
        Ext.each @getClubMembers(), (item, i) ->
            labels[i] = item.name

        labels.join ', '