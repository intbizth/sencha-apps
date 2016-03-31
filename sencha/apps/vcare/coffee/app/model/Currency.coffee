Ext.define 'Vcare.model.Currency',
    extend: 'Vcare.model.Base'
    api: '/api/currencies/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.get('code')
    ,
        name: 'exchange_rate'
        type: 'float'
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        persist: no
        name: 'base'
        type: 'boolean'
    ]

    validators:
        code: 'presence'
        exchange_rate: 'presence'
