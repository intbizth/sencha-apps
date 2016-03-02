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
        name: 'promote-category'
        reference:
            type: 'PromoteCategory'
            role: 'promote-category'
            associationKey: 'promote_category'
            getterName: 'getPromoteCategory'
            setterName: 'setPromoteCategory'
    ]

    getPromoteCategoryTitle: ->
        promote = @getPromoteCategory()
        return promote.get("title") if promote
        return ''

    validators:
        description: 'presence'
