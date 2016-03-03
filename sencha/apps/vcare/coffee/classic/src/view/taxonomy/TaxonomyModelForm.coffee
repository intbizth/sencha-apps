Ext.define 'Vcare.view.taxonomy.TaxonomyModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-taxonomy-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

        translations:
            get: -> @get('record').get('translations');

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
