Ext.define 'Vcare.view.product.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-product-form'

    isDirty: ->
        @get('record').dirty || @get('record.master_variant').dirty

    commit: ->
        # need to call master variant first
        @get('record.master_variant').commit()
        @get('record').commit()

    reject: ->
        # need to call master variant first
        @get('record').getMasterVariant().reject()
        @get('record').reject()

    beforeSubmit: (record) -> record.updateTranslations()
    beforeCancel: (record) -> record.updateTranslations()
    onSubmitSuccess: -> @get('products').reload()
