Ext.define 'Moboque.model.Personal',
    extend: 'Moboque.model.Base'
    api: '/api/personals/'
    hasFileUpload: true

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'surname'
        type: 'string'
    ,
        name: 'position'
        type: 'string'
    ,
        name: 'address'
        type: 'string'
    ,
        name: 'birth_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'tel'
        type: 'string'
    ,
        name: 'email'
        type: 'string'
    ,
        name: 'image'
        type: 'auto'
    ,
        name: 'fullname'
        persist: no
        calculate: (d) -> "#{d.name} #{d.surname}"
    ,
        name: 'personalDepartment'
        reference:
            type: 'PersonalDepartment'
            role: 'personalDepartment'
            associationKey: 'personal_department'
            getterName: 'getPersonalDepartment'
            setterName: 'setPersonalDepartment'
    ]

    getPersonalDepartmentTitle: ->
        department = @getPersonalDepartment()

        return department.get("title") if department
        return ''

    writerTransform: fn: (data) ->
        if data.personalDepartment
            data.personalDepartment = data.personalDepartment.id

        return data

    validators:
        title: 'presence'
        description: 'presence'
