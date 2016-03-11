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

        #TODO: override model
        record = @get('record')
        parent = record.getPrevious('parent')
        record.beginEdit()
        record.setParent(parent)
        record.endEdit(yes)

