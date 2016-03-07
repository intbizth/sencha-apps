Ext.define 'Moboque.model.PromoteImage',
    extend: 'Moboque.model.Base'
    api: '/api/promote-images/'

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
        mapping: '_link'
        type: 'auto'
#    ,
#        name: 'promoteUrl'
#        reference:
#            type: 'Promote'
#            role: 'promote-url'
#            associationsKey: 'image'
#            getterName: 'getPromoteImage'
#            setterName: 'setPromoteImage'
    ]

    getPromoteTitle: ->
        promote = @getPromote()
        console.log @get('image')
        return promote.get("title") if promote
        return ''

    getPromoteUrl: ->
        promoteUrl = @getPromoteImage()
        console.log @get('image')
        return promoteUrl.get('url') if promoteUrl
        return ''

    validators:
        description: 'presence'

    writerTransform: fn: (data) ->
        if data.promote
            data.promote = data.promote.id
        return data
