Ext.define 'Vcare.view.rbac.role.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-rbac-role-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()
    onSubmitSuccess: (record) -> @get('rbac-roles').reload()
