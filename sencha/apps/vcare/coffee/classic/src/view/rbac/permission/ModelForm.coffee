Ext.define 'Vcare.view.rbac.permission.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-rbac-permission-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()
    onSubmitSuccess: (record) -> @get('rbac-permissions').reload()
