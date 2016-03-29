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
