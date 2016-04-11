Ext.define 'Moboque.view.emergency_call.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-emergency-call-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('tels').reload()

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
