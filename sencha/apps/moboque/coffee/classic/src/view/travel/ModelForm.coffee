Ext.define 'Moboque.view.travel.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-travel-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('travels').reload()

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
