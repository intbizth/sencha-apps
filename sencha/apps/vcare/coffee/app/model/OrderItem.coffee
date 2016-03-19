Ext.define 'Vcare.model.OrderItem',
    extend: 'Vcare.model.Base'
    api: '/api/orders/{order}/items'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'quantity'
        type: 'int'
    ,
        name: 'unit_price'
        type: 'int'
    ,
        name: 'total'
        type: 'int'
    ,
        name: 'units_total'
        type: 'int'
    ,
        name: 'adjustments_total'
        type: 'int'
    ,
        name: 'immutable'
        type: 'boolean'
    ,
        name: 'order'
        reference:
            type: 'Order'
            role: 'order'
            associationKey: 'order'
            getterName: 'getOrder'
            setterName: 'setOrder'
    ]

    getPrice: (number) -> number / 100
