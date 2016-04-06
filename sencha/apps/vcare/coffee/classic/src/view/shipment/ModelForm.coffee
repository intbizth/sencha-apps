Ext.define 'Vcare.view.shipment.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-shipment-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('orders').reload()

    beforeSubmit: (record) ->
        if record.phantom
            record.getUser().set(
                'plain_password',
                Math.random().toString(36).slice(-10)
            )

    isDirty: ->
        @get('record').dirty

    commit: ->
        # need to call user first
        @get('record.user').commit()
        @get('record').commit()

    reject: ->
        # need to call user first
        @get('record').getUser().reject()
        @get('record').reject()
