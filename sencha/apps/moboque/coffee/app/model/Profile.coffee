Ext.define 'Moboque.model.Profile',
    extend: 'Moboque.model.Base'
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
        model: 'ProfileGroup'
        role: 'groups'
        associationKey: 'groups'
        getterName: 'getGroups'
        setterName: 'setGroups'
        storeConfig:
            type: 'store-profile-groups'
    ]

    writerTransform: fn: (data) ->
        delete data.user if Ext.Object.isEmpty(data.user)
        delete data.user.id if data.user

        if data.user.country
            data.user.country = data.user.country.id

        groups = data.groups

        if !Ext.isEmpty groups
            data.groups = []
            for group in groups
                data.groups.push group.id

        return data
