Ext.define 'Vcare.view.shipment.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-shipment'

    stores:
        shipments:
            type: 'store-shipments'
            autoLoad: yes

        transitions:
            type: 'store-transitions'

    createCustomer: (record) ->
        if !record.getCustomer()
            record.setCustomer @createNewCustomer()

        return record.getCustomer()

    createRecord: (record) ->
        return record if record

        record = new (@data.orders.getModel())()
        @createCustomer record

        return record

    prepareData: (record) ->
        record = @createRecord record

        return record
