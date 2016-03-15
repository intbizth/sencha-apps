Ext.define 'Moboque.model.Translatable',
    extend: 'Moboque.model.Base'

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
        name: 'translations'
        type: 'auto'
        defaultValue: {}
        isEqual: (a, b, isLoop) ->
            aProps = Object.getOwnPropertyNames(a)
            bProps = Object.getOwnPropertyNames(b)

            if (aProps.length != bProps.length)
                return false

            for propName in aProps
                # If values of same property are not equal,
                if a[propName] != null and typeof a[propName] == 'object'
                    if !@isEqual a[propName], b[propName], yes
                        return no
                else if (a[propName] != b[propName])
                    return no

            return yes
    ]

    updateTranslations: (values) ->
        return if !values
        @set 'translations', Ext.apply @data.translations, values

    trans: (key) ->
        locale = @data.translations[@data.current_locale]
        locale = (@data.translations[@data.current_locale] = {}) if !locale

        return locale[key]
