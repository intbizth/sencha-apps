Ext.define 'Vcare.view.order.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-order'

    stores:
        currencies:
            type: 'store-currencies'
            autoLoad: yes

        orders:
            type: 'store-orders'
            autoLoad: yes

        transitions:
            type: 'store-transitions'

    createRecord: (record) ->
        return record if record

        record = new (@data.orders.getModel())()

        return record

    prepareData: (record) ->
        record = @createRecord record

        return record
