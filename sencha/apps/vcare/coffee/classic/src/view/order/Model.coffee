Ext.define 'Vcare.view.order.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-order'

    stores:
        orders:
            type: 'store-orders'
            autoLoad: yes

        currencies:
            type: 'store-currencies'

        countries:
            type: 'store-countries'
            autoLoad: yes
            pageSize: 250

        transitions:
            type: 'store-transitions'

    createRecord: (record) ->
        return record if record

        record = new (@data.orders.getModel())()

        return record

    prepareData: (record) ->
        record = @createRecord record

        return record
