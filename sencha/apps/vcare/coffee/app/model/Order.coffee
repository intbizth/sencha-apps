Ext.define 'Vcare.model.Order',
    extend: 'Vcare.model.Base'
    api: '/api/orders/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'number'
        type: 'string'
    ,
        name: 'items_total'
        type: 'int'
    ,
        name: 'adjustments_total'
        type: 'int'
    ,
        name: 'total'
        type: 'int'
    ,
        name: 'currency'
        type: 'string'
    ,
        name: 'state'
        type: 'string'
    ,
        name: 'checkout_state'
        type: 'string'
    ,
        name: 'payment_state'
        type: 'string'
    ,
        name: 'shipping_state'
        type: 'string'
    ,
        name: 'completed_at'
        type: 'date'
    ,
        name: 'created_at'
        type: 'date'
    ,
        name: 'updated_at'
        type: 'date'
    ,
        name: 'expires_at'
        type: 'date'
    ,
        name: 'customer'
        reference:
            type: 'Customer'
            role: 'customer'
            associationKey: 'customer'
            getterName: 'getCustomer'
            setterName: 'setCustomer'

    ]

    hasMany: [
        name: 'items'
        model: 'OrderItem'
        role: 'items'
        associationKey: 'items'
        getterName: 'getItems'
        setterName: 'setItems'
    ]

    getPrice: (number) -> number / 100
