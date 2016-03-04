Ext.define 'Moboque.view.link.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-link-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom
