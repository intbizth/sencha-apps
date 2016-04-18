Ext.define 'Vcare.model.Address',
    extend: 'Vcare.model.Base'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'first_name'
        type: 'string'
    ,
        name: 'last_name'
        type: 'string'
    ,
        name: 'phone_number'
        type: 'string'
    ,
        name: 'street'
        type: 'string'
    ,
        name: 'company'
        type: 'string'
    ,
        name: 'city'
        type: 'string'
    ,
        name: 'postcode'
        type: 'string'
    ,
        name: 'country_code'
        reference:
            type: 'Country'
            role: 'country_code'
            associationKey: 'country_code'
            getterName: 'getCountryCode'
            setterName: 'setCountryCode'
    ,
        name: 'province_code'
        type: 'string'
    ]
