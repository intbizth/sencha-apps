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
        name: 'on_hand'
        type: 'int'
        defaultValue: 0
    ,
        name: 'available_on_demand'
        type: 'boolean'
    ,
        name: 'available_on'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
        defaultValue: new Date()
    ,
        name: 'available_until'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ]

    validators:
        price: 'presence'
        on_hand: 'presence'
        available_on: 'presence'
