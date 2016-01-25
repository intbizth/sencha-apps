Ext.define 'Toro.cfg',
    requires: [
        'Toro.util.PropertyAccessor'
    ]

    statics:
        get: (path) ->
            $cfg = new this()
            return Toro.util.PropertyAccessor.get $cfg.config, path

        getWith: (path, append) ->
            @get(path) + append

    config:
        api:
            baseUrl: 'http://127.0.0.1:8000'
            client: '1oacj6ctnl8kg8kw4g0048wgkcws0c888cgck0g8844cs8oggo'
            secret: '5qswyupaj78ccwwks40cc0o8soo88ko4scwc0wo0owwcwo0ook'
