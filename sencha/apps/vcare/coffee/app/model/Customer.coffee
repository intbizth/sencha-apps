Ext.define 'Vcare.model.Customer',
    extend: 'Vcare.model.Base'
    api: '/api/customers/'

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
        name: 'birthday'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'gender'
        type: 'string'
    ,
        name: 'user'
        reference:
            type: 'User'
            role: 'user'
            unique: yes
            associationKey: 'user'
            getterName: 'getUser'
            setterName: 'setUser'
    ,
        name: 'fullname'
        persist: no
        calculate: (d) -> "#{d.first_name}  #{d.last_name}"
    ]

    hasMany: [
        name: 'groups'
        model: 'Group'
        role: 'groups'
        associationKey: 'groups'
        getterName: 'getGroups'
        setterName: 'setGroups'
    ]

    writerTransform: fn: (data) ->
        delete data.user if Ext.Object.isEmpty(data.user)
        delete data.user.id if data.user

        if data.user.country
            data.user.country = data.user.country.id

        if data.user.locale
            data.user.locale = data.user.locale.id

        groups = data.groups

        if !Ext.isEmpty groups
            data.groups = []
            for group in groups
                data.groups.push group.id

        return data

    validators:
        first_name: 'presence'
        last_name: 'presence'
        email: 'presence'
        gender: 'presence'
