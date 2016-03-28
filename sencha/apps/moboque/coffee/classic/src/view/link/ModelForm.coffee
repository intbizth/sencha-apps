Ext.define 'Moboque.view.link.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-link-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('links').reload()

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
