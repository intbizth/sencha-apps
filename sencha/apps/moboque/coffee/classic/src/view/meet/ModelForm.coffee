Ext.define 'Moboque.view.meet.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-meet-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom
