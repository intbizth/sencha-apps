Ext.define 'Moboque.model.Travel',
    extend: 'Moboque.model.Translatable'

    api: '/api/travel/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'current_locale'
        type: 'string'
        persist: no
    ,
        name: 'title'
        persist: no
        convert: (v, r) -> r.getTitle()
    ,
        name: 'description'
        persist: no
        convert: (v, r) -> r.getDescription()

    ]

    getTitle: -> @trans 'title'
    getDescription: -> @trans 'description'

    validators:
        title: 'presence'
        description: 'presence'

    writerTransform: fn: (data) ->

        if data.TranslateTitle
            data.TranslateTitle = data.TranslateTitle.id

        return data