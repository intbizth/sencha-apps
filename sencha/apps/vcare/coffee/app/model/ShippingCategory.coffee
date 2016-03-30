Ext.define 'Vcare.model.ShippingCategory',
    extend: 'Vcare.model.Base'
    api: '/api/shipping-categories/'

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
        name: 'description'
        type: 'string'
    ]

    validators:
        code: 'presence'
        name: 'presence'
