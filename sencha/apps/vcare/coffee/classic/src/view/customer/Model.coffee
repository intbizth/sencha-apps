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
            pageSize: no

    createUser: (record) ->
        return record.getUser() if record and record.getUser()
        return @createNewUser()

    createRecord: (record) ->
        return record if record
        return new (@data.customers.getModel())()

    prepareData: (record) ->
        user = @createUser record
        record = @createRecord record
        record.setUser user

        return record
