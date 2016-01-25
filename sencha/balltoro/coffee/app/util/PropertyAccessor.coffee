Ext.define 'Toro.util.PropertyAccessor',
    statics:
        ###*
         * Object accessor with dot anotation style
         *
         * @param {Object} Object you want to access to its member.
         * @param {String} Property path eg. 'api.baseUrl'
         *
         * @return {Mixed} return `undefined` when no exist property path.
         ###
        get: (obj, path) ->
            path.split('.').reduce (o, x) ->
                return o[x]
            , obj
