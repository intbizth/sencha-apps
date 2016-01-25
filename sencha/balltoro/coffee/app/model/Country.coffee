Ext.define 'Toro.model.Country',
    extend: 'Toro.model.Base'
    api: '/api/countries/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'local'
        type: 'string'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ]

    validators:
        name: 'presence'
        type: 'presence'
