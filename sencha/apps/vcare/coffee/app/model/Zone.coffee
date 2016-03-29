Ext.define 'Vcare.model.Zone',
    extend: 'Vcare.model.Base'
    api: '/api/zones/'

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
        name: 'type'
        type: 'string'
    ]

    validators:
        code: 'presence'
