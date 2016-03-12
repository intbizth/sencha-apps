Ext.define 'Vcare.view.taxon.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-taxon-form'

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()

    updateTranslations: ->
        record = @get('record')

        ## current bind (Translation.js)
        ## will bind into main model property (model.translations)
        if record.translations
            translations = Ext.Object.merge(_copy(record.data.translations), record.translations)
            record.set('translations', translations)
            delete record.translations
