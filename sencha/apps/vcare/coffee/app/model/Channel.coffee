Ext.define 'Vcare.model.Channel',
    extend: 'Vcare.model.Base'
    api: '/api/channels/'

    associationWriterIdBased: yes

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
        name: 'taxonomies'
        model: 'Taxonomy'
        role: 'taxonomies'
        associationKey: 'taxons'
        getterName: 'getTaxonomys'
        setterName: 'setTaxonomys'
    ,
        name: 'currencies'
        model: 'Currency'
        role: 'currencies'
        associationKey: 'currencies'
        getterName: 'getCurrencies'
        setterName: 'setCurrencies'
    ,
        name: 'locales'
        model: 'Locale'
        role: 'locales'
        associationKey: 'locales'
        getterName: 'getLocales'
        setterName: 'setLocales'
    ,
        name: 'shipping_methods'
        model: 'ShippingMethod'
        role: 'shipping_methods'
        associationKey: 'shipping_methods'
        getterName: 'getShippingMethods'
        setterName: 'setShippingMethods'
    ,
        name: 'payment_methods'
        model: 'PaymentMethod'
        role: 'payment_methods'
        associationKey: 'payment_methods'
        getterName: 'getPaymentMethods'
        setterName: 'setPaymentMethods'
    ]

    validators:
        code: 'presence'
        name: 'presence'

    writerTransform: fn: (data) ->
        data.taxons = data.taxonomies if data.taxonomies
        delete data.taxonomies if data.taxonomies

        return data

