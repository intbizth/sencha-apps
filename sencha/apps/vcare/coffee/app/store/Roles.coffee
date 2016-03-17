Ext.define 'Vcare.store.Roles',
    extend: 'Vcare.store.Base'
    model: 'Vcare.model.Role'
    alias: 'store.store-roles'

    data: [
        code: 'ROLE_USER'
        description: 'User'
        is_default: yes
    ,
        code: 'ROLE_ADMINISTRATION_ACCESS'
        description: 'Administration'
    ,
        code: 'ROLE_ALLOWED_TO_SWITCH'
        description: 'Impersonate Users'
    ,
        code: 'ROLE_API_ACCESS'
        description: 'API'
    ]
