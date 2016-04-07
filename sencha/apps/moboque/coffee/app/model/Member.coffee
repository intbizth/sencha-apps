Ext.define 'Moboque.model.Member',
    extend: 'Moboque.model.Base'
    api: '/api/members/'
    hasFileUpload: true

    fields: [
        name: 'firstname'
        type: 'string'
    ,
        name: 'lastname'
        type: 'string'
    ,
        name: 'card_id'
        type: 'string'
    ,
        name: 'employee_id'
        type: 'string'
    ,
        name: 'company'
        type: 'string'
    ,
        name: 'address'
        type: 'string'
    ,
        name: 'email'
        type: 'string'
    ,
        name: 'phone_number'
        type: 'string'
    ,
        name: 'mobile_number'
        type: 'string'
    ,
        name: 'fullname'
        persist: no
        calculate: (d) -> "#{d.firstname}  #{d.lastname}"
    ,
        name: 'image'
        type: 'auto'
    ,
        name: 'group'
        reference:
            type: 'Group'
            role: 'group'
            associationKey: 'group'
            getterName: 'getGroup'
            setterName: 'setGroup'
    ]

    getGroupName: ->
        group = @getGroup()

        return group.get("name") if group
        return ''

    writerTransform: fn: (data) ->

        if data.group
            data.group = data.group.id

        return data
