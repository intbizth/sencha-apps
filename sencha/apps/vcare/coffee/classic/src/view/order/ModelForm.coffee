Ext.define 'Vcare.view.order.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-order-form'

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    onSubmitSuccess: -> @get('orders').reload()

    isDirty: ->
        @get('record').dirty || @get('record.billing_address').dirty || @get('record.shipping_address').dirty

    commit: ->
        @get('record.billing_address').commit()
        @get('record.shipping_address').commit()
        @get('record').commit()

    reject: ->
        @get('record.billing_address').reject()
        @get('record.shipping_address').reject()
        @get('record').reject()
