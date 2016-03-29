Ext.define 'Vcare.model.Tax',
    extend: 'Vcare.model.Base'
    api: '/api/tax-rates/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
        unique: true
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'amount'
        type: 'number'
    ,
        name: 'included_in_price'
        type: 'boolean'
    ,
        name: 'calculator'
        type: 'string'
    ,
        name: 'category'
        reference:
            type: 'TaxCategory'
            getterName: 'getCategory'
            setterName: 'setCategory'
    ,
        name: 'zone'
        reference:
            type: 'Zone'
            getterName: 'getZone'
            setterName: 'setZone'

    ]

    validators:
        code: 'presence'
        name: 'presence'

    writerTransform: fn: (data) ->
        if data.category
            data.category = data.category.id
        if data.zone
            data.zone = data.zone.id
        return data
