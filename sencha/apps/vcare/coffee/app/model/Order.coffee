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
    ,
        name: 'billing_address'
        reference:
            type: 'Address'
            role: 'billing_address'
            associationKey: 'billing_address'
            getterName: 'getBillingAddress'
            setterName: 'setBillingAddress'
    ,
        name: 'shipping_address'
        reference:
            type: 'Address'
            role: 'shipping_address'
            associationKey: 'shipping_address'
            getterName: 'getShippingAddress'
            setterName: 'setShippingAddress'
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

    writerTransform: fn: (data) ->
        delete data.customer
        delete data.items

        store = Ext.data.StoreManager.lookup('store-countries')

        if data.billing_address
            delete data.billing_address.id
        if data.shipping_address
            delete data.shipping_address.id

        if data.billing_address.country_code
            data.billing_address.country_code = store.findRecord('id', data.billing_address.country_code.id).get 'code'
        if data.shipping_address.country_code
            data.shipping_address.country_code = store.findRecord('id', data.shipping_address.country_code.id).get 'code'

        return data
