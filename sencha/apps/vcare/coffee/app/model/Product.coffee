Ext.define 'Vcare.model.Product',
    extend: 'Vcare.model.Base'
    api: '/api/products/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'sku'
        type: 'string'
    ,
        name: 'master_variant'
        reference:
            type: 'ProductVariant'
            role: 'master_variant'
            associationKey: 'masterVariant'
            getterName: 'getMasterVariant'
            setterName: 'setMasterVariant'
    ]
