Ext.define 'Vcare.view.rbac.role.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-rbac-role-form'

    stores:
        roles:
            type: 'store-roles'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

        security_roles:
            get: ->
                security_role: @get('record.security_roles')

            set: (val) ->
                @get('record').set(
                    'security_roles',
                    val.security_role || []
                )

    onSubmitSuccess: (record) -> @get('rbac-roles').reload()

    isDirty: -> @get('record').dirty

    commit: ->
        # can't use `record.permissions` when phantom.
        @get('record').getPermissions().commitChanges()
        @get('record').commit()

    reject: ->
        @get('record.permissions').rejectChanges()
        @get('record').reject()
