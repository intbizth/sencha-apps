Ext.define 'Toro.model.Profile',
    extend: 'Toro.model.Base'
    api: '/api/profiles/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'first_name'
        type: 'string'
    ,
        name: 'last_name'
        type: 'string'
    ,
        name: 'email'
        type: 'string'
    ,
        name: 'mobile'
        type: 'string'
    ,
        name: 'birthday'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'gender'
        type: 'string'
    ,
        name: 'user'
        reference: 'User'
    ,
        name: 'groups'
        type: 'auto'
        critical: yes
        convert: (groups, rec) ->
            # reader
            rec.arrayConverter(@, groups, rec, 'id')
        serialize: (groups, rec) ->
            # writer
            if !groups.length
                return null

            rec.arrayConverter(@, groups, rec, 'id')
    ]

    validators:
        first_name: 'presence'
        last_name: 'presence'
        email: 'presence'
        gender: 'presence'
