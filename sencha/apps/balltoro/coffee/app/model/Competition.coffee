Ext.define 'Balltoro.model.Competition',
    extend: 'Balltoro.model.Base'
    api: '/api/competitions/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'country'
        reference: 'Country'
    ]

    validators:
        name: 'presence'
        type: 'presence'
        code: 'presence'
