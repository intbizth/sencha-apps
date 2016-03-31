Ext.define 'Vcare.model.ProductVariant',
    extend: 'Vcare.model.Base'
    api: '/api/products/{productId}/variants/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'sku'
        type: 'string'
    ,
        name: 'price'
        type: 'int'
    ,
        name: 'original_price'
        type: 'int'
    ,
        name: 'on_hold'
        type: 'int'
        defaultValue: 0
    ,
        name: 'available_on_demand'
        type: 'boolean'
    ]

    validators:
        price: 'presence'
