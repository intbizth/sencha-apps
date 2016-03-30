Ext.define 'Vcare.model.RbacRole',
    extend: 'Vcare.model.Base'
    api: '/api/roles/'

    # using PUT method when update
    # we have `permissions-choice` form on server-side.
    # @see https://github.com/symfony/symfony/issues/8301
    updateMethod: 'PUT'

    associationWriterIdBased: yes

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'level'
        type: 'int'
        persist: no
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
        name: 'security_roles'
        type: 'auto'
    ,
        name: 'parent'
        reference:
            type: 'RbacRole'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    hasMany: [
        name: 'permissions'
        model: 'RbacPermission'
        role: 'permissions'
        associationKey: 'permissions'
        getterName: 'getPermissions'
        setterName: 'setPermissions'
    ]
