Ext.define 'Vcare.model.ProductAttribute',
    extend: 'Vcare.model.Translatable'
    api: '/api/product-attributes/'

    translationFields: ['name']

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ,
        name: 'storage_type'
        type: 'string'
    ]

    getName: -> @trans 'name'
