Ext.define 'Vcare.model.Locale',
    extend: 'Vcare.model.Base'
    api: '/api/locales/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
        unique: true
    ,
        name: 'enabled'
        type: 'boolean'
        persist: false
    ]

    validators:
        code: 'presence'
