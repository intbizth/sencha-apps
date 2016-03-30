Ext.define 'Vcare.model.Channel',
    extend: 'Vcare.model.Base'
    api: '/api/channels/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'color'
        type: 'string'
    ,
        name: 'hostname'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'default_locale'
        reference:
            type: 'Locale'
            role: 'default_locale'
            associationKey: 'default_locale'
            getterName: 'getDefaultLocale'
            setterName: 'setDefaultLocale'
    ,
        name: 'default_currency'
        reference:
            type: 'Currency'
            role: 'default_currency'
            associationKey: 'default_currency'
            getterName: 'getDefaultCurrency'
            setterName: 'setDefaultCurrency'
    ]

    hasMany: [
        name: 'taxons'
        model: 'Taxon'
        role: 'taxons'
        associationKey: 'taxons'
        getterName: 'getTaxons'
        setterName: 'setTaxons'
    ]

    validators:
        code: 'presence'
        name: 'presence'
