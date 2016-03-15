Ext.define 'Vcare.model.Locale',
    extend: 'Vcare.model.Base'
    api: '/api/locales/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
        mapping: (data) -> data.code
    ,
        name: 'enabled'
        type: 'boolean'
    ]

    getCode: -> @get 'code'
    getName: -> @get 'name'

    validators:
        code: 'presence'
