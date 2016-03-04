Ext.define 'Moboque.view.emergency-call.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-emergency-call-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom
