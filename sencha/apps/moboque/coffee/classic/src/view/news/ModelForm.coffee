Ext.define 'Moboque.view.news.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-news-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()
    beforeSubmit: (record) -> record.updateTranslations()
    beforeCancel: (record) -> record.updateTranslations()
    onSubmitSuccess: (record) -> @get('news').reload()
