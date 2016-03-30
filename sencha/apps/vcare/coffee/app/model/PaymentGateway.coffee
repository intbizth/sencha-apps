Ext.define 'Vcare.model.PaymentGateway',
    extend: 'Vcare.model.Base'
    api: '/api/payment-gateways/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
    ]
