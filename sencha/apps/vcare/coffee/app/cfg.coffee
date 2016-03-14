Ext.define 'Vcare.cfg',
    requires: [
        'Vcare.util.PropertyAccessor'
    ]

    statics:
        get: (path) ->
            $cfg = new this()
            return Vcare.util.PropertyAccessor.get $cfg.config, path

        getWith: (path, append) ->
            @get(path) + append

    config:
        locale: 'en_US'
        api:
            version: 'v1'
            baseUrl: 'http://127.0.0.1:8080'
            info: 'http://127.0.0.1:8080/api/me'
            login: 'http://127.0.0.1:8080/login'
            logout: 'http://127.0.0.1:8080/logout'
