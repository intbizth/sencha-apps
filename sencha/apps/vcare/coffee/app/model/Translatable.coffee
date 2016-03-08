Ext.define 'Vcare.model.Translatable',
    extend: 'Vcare.model.Base'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'current_locale'
        type: 'string'
        persist: no
    ,
        name: 'translations'
        type: 'auto'
        defaultValue: {}
    ]

    trans: (key) ->
        @data.translations[@data.current_locale][key]
