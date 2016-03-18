Ext.define 'Vcare.view.order.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-order'

    stores:
        orders:
            type: 'store-orders'
            autoLoad: yes

    createUser: (record) ->
        return record.getUser() if record
        return Ext.create 'Vcare.model.User'

    createRecord: (record) ->
        return record if record
        return new (@data.orders.getModel())()

    prepareData: (record) ->
        user = @createUser record
        record = @createRecord record
        record.setUser user

        return record
