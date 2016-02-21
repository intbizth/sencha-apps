Ext.define 'Vcare.view.customer.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-customer'

    stores:
        customers:
            type: 'store-customers'
            autoLoad: yes

        groups:
            type: 'store-groups'
            autoLoad: yes
            pageSize: 200

    formulas:
        isLoading:
            get: ->


    createUser: (record) ->
        return record.getUser() if record
        return Ext.create 'Vcare.model.User'

    createRecord: (record) ->
        return record if record
        return new (@data.customers.getModel())()

    prepareData: (record) ->
        user = @createUser record
        record = @createRecord record
        record.setUser user

        return record
