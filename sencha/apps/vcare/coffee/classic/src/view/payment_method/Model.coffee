Ext.define 'Vcare.view.payment_method.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-payment-method'

    stores:
        "payment-gateways":
            type: 'store-payment-gateways'
            autoLoad: yes

        "payment-methods":
            type: 'store-payment-methods'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data["payment-methods"].getModel())()
