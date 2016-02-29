Ext.define 'Moboque.view.member.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-member-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty
