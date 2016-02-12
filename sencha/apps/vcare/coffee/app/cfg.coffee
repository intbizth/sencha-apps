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
        api:
            version: 'v1'
            baseUrl: 'http://127.0.0.1:8888'
            info: 'http://127.0.0.1:8888/api/me'
            login: 'http://127.0.0.1:8888/login'
            logout: 'http://127.0.0.1:8888/logout'
