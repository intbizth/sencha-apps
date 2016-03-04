Ext.define 'Moboque.view.event.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-event-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom
