Ext.define 'Moboque.model.PromoteImage',
    extend: 'Moboque.model.Base'
    api: '/api/promote-images/'
    hasFileUpload: true

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'promote'
        reference:
            type: 'Promote'
            role: 'promote'
            associationKey: 'promote'
            getterName: 'getPromote'
            setterName: 'setPromote'
    ,
        name: 'image'
        type: 'auto'
    ]

    getPromoteTitle: ->
        promote = @getPromote()
        return promote.get("title") if promote
        return ''

    writerTransform: fn: (data) ->
        if data.promote
            data.promote = data.promote.id
        return data
