Ext.define 'Vcare.model.ProductVariant',
    extend: 'Vcare.model.Base'
    api: '/api/products/{productId}/variants/'

    fields: [
        name: 'sku'
        type: 'string'
    ,
        name: 'price'
        type: 'int'
    ,
        name: 'on_hold'
        type: 'int'
    ,
        name: 'available_on_demand'
        type: 'boolean'
    ]
