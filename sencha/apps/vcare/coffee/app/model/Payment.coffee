Ext.define 'Vcare.model.Payment',
    extend: 'Vcare.model.Translatable'
    api: '/api/payments/'

    requires: [
        'Vcare.store.PaymentMethods'
    ]

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'state'
        type: 'string'
        persist: no
    ,
        name: 'currency'
        type: 'string'
        persist: no
    ,
        name: 'amount'
        persist: no
    ,
        name: 'created_at'
        type: 'date'
    ,
        name: 'method'
        reference:
            type: 'PaymentMethod'
            role: 'method'
            associationKey: 'method'
            getterName: 'getMethod'
            setterName: 'setMethod'
    ]

    getPrice: (number) -> number / 100