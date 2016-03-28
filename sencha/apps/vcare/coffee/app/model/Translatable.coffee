Ext.define 'Vcare.model.Translatable',
    extend: 'Vcare.model.Base'

    config:
        changedTranslations: {}

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'current_locale'
        type: 'string'
        persist: no
    ,
        name: 'fallback_locale'
        type: 'string'
        persist: no
    ,
        name: 'translations'
        type: 'auto'
        defaultValue: {}
        isEqual: (a, b, isLoop) ->
            aProps = Object.getOwnPropertyNames(a)
            bProps = Object.getOwnPropertyNames(b)

            if (aProps.length != bProps.length)
                return false

            for propName in aProps
                if !propName
                    # do nothing
                else if a[propName] != null and typeof a[propName] == 'object'
                    if !@isEqual a[propName], b[propName], yes
                        return no
                else if (a[propName] != b[propName])
                    return no

            return yes
    ]

    updateTranslations: ->
        ## current bind (Translation.js)
        ## will bind into main model property (model.translations)
        if @translations
            @set('translations', Ext.Object.merge(
                _copy(@data.translations), _copy(@translations)
            ))

            delete @translations

    trans: (key) ->
        locale = @data.translations[@data.current_locale]
        locale = @data.translations[@data.fallback_locale] if !locale
        locale = (@data.translations[@data.current_locale] = {}) if !locale

        return locale[key]
