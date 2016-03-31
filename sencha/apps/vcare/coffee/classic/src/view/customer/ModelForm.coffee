Ext.define 'Vcare.view.customer.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-customer-form'

    formulas:
        currentGroups:
            get: -> @get('record.groups').getData().getRange()
            set: (rs) ->
                @get('record.groups').loadRecords(rs || [])
                # to mask model dirty
                @get('record').set('groups', rs)

    onSubmitSuccess: -> @get('customers').reload()

    beforeSubmit: (record) ->
        if record.phantom
            record.getUser().set(
                'plain_password',
                Math.random().toString(36).slice(-10)
            )

    isDirty: ->
        @get('record').dirty || @get('record.user').dirty

    commit: ->
        # need to call user first
        @get('record.user').commit()
        @get('record').commit()

    reject: ->
        # need to call user first
        @get('record').getUser().reject()
        @get('record').reject()
