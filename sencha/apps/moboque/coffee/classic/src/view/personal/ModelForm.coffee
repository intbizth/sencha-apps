Ext.define 'Moboque.view.personal.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-personal-form'

    formulas:
        personalDepartment:
            get: -> @get('record').getPersonalDepartment()
            set: (val) ->
                @get('record').setPersonalDepartment val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        personalDepartmentId = @get('record').getPrevious('personalDepartment_id')

        if personalDepartmentId
            @get('record').setPersonalDepartment @get('personalDepartment').getById(personalDepartment_id)
            record.commit()
