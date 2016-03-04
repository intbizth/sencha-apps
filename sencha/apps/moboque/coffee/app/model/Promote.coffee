Ext.define 'Moboque.model.Promote',
    extend: 'Moboque.model.Base'
    api: '/api/promotes/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'promoteCategory'
        reference:
            type: 'PromoteCategory'
            role: 'promoteCategory'
            associationKey: 'promote_category'
            getterName: 'getPromoteCategory'
            setterName: 'setPromoteCategory'
    ]

    getPromoteCategoryName: ->
        promote = @getPromoteCategory()
        return promote.get("title") if promote
        return ''

    validators:
        title: 'presence'
        description: 'presence'

    writerTransform: fn: (data) ->
        if data.promoteCategory
            data.promoteCategory = data.promoteCategory.id
        return data
