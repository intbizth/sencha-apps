Ext.define 'Vcare.model.Country',
    extend: 'Vcare.model.Base'
    api: '/api/countries/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ]

    validators:
        code: 'presence'
