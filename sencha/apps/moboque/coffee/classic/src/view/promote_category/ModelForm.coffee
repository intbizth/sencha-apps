Ext.define 'Moboque.view.promote_category.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-category-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom
