Ext.define 'Moboque.view.gift.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-gift-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('gifts').reload()

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
