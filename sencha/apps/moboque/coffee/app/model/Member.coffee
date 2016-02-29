Ext.define 'Moboque.model.Member',
    extend: 'Moboque.model.Base'
    api: '/api/members/'

    fields: [
        name: 'firstname'
        type: 'string'
    ,
        name: 'lastname'
        type: 'string'
    ,
        name: 'card_id'
        type: 'string'
    ,
        name: 'employee_id'
        type: 'string'
    ,
        name: 'company'
        type: 'string'
    ,
        name: 'address'
        type: 'string'
    ,
        name: 'email'
        type: 'string'
    ,
        name: 'phone_number'
        type: 'string'
    ,
        name: 'mobile_number'
        type: 'string'
    ,
        name: 'fullname'
        persist: no
        calculate: (d) -> "#{d.firstname}  #{d.lastname}"
    ]

    validators:
        firstname: 'presence'
        lastname: 'presence'
        card_id: 'presence'
        employee_id: 'presence'
        company: 'presence'
        address: 'presence'
        email: 'presence'
        mobile_number: 'presence'
