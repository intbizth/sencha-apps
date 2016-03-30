Ext.define 'Vcare.view.product.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-product-form'

    # formulas:
    #     isPhantom:
    #         get: -> @get('record').phantom

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()
    beforeSubmit: (record) -> record.updateTranslations()
    beforeCancel: (record) -> record.updateTranslations()
