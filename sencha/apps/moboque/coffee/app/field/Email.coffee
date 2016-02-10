Ext.define 'Moboque.field.Email',
    extend: 'Ext.data.field.String'

    alias: 'data.field.email'

    validators: [
        type: 'format'
        matcher: /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
        message: 'Must be in the email format.'
    ]
