Ext.define 'Vcare.view.taxon.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-taxon-form'

    formulas:
        translations:
            get: -> @get('record').get('translations')

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
