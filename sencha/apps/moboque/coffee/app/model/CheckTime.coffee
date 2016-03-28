Ext.define 'Moboque.model.CheckTime',
    extend: 'Moboque.model.Base'
    api: '/api/check-times/'

    fields: [
        name: 'type'
        type: 'string'
    ,
        name: 'checktime'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ,
        name: 'member'
        reference:
            type: 'Member'
            role: 'member'
            associationKey: 'member'
            getterName: 'getMember'
            setterName: 'setMember'
    ]

    getMemberName: ->
        member = @getMember()

        return member.get("fullname") if member
        return ''

    writerTransform: fn: (data) ->

        if data.member
            data.member = data.member.id

        return data

    validators:
        checktime: 'presence'
        type: 'presence'
