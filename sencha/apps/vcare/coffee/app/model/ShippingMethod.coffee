Ext.define 'Vcare.model.ShippingMethod',
    extend: 'Vcare.model.Translatable'
    api: '/api/shipping-methods/'

    associationWriterIdBased: yes
    translationFields: ['name']

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'category'
        reference:
            type: 'Category'
            role: 'category'
            associationKey: 'category'
            getterName: 'getCategory'
            setterName: 'setCategory'
    ]

    getName: -> @trans 'name'

    validators:
        code: 'presence'
