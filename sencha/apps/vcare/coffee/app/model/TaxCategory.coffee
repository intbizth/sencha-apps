Ext.define 'Vcare.model.TaxCategory',
    extend: 'Vcare.model.Base'
    api: '/api/tax-categories/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
        unique: true
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ]

    validators:
        code: 'presence'
        name: 'presence'
