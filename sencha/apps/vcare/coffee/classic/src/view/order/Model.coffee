Ext.define 'Vcare.view.order.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-order'

    stores:
        orders:
            type: 'store-orders'
            autoLoad: yes
            pageSize: 3

        currencies:
            type: 'store-currencies'

        countries:
            type: 'store-countries'
            pageSize: 250

        payments:
            type: 'store-payments'

        transitions:
            type: 'store-transitions'

    createShippingAddress: (record) ->
        return record.getShippingAddress() if record and record.getShippingAddress()

    createBillingAddress: (record) ->
        return record.getBillingAddress() if record and record.getBillingAddress()

    createRecord: (record) ->
        return record if record

        record = new (@data.orders.getModel())()

        return record

    prepareData: (record) ->
        billing = @createBillingAddress record
        shipping = @createShippingAddress record
        record = @createRecord record
        record.setBillingAddress billing
        record.setShippingAddress shipping

        return record
