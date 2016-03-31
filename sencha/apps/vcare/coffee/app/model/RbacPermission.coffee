Ext.define 'Vcare.model.RbacPermission',
    extend: 'Vcare.model.Base'
    api: '/api/permissions/'

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
        name: 'parent'
        reference:
            type: 'RbacPermission'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]
