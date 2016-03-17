Ext.define 'Moboque.view.link.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-link'

    stores:
        links:
            type: 'store-link'
            autoLoad: yes

    prepareData: (record) ->
        record = @createRecord record

        return record

    createRecord: (record) ->
        return record if record
        return new (@data.links.getModel())()

    createUser: (record) ->
        return record.getUser() if record
        return Ext.create 'Moboque.model.Link'

#    createRecord: (record) ->
#        return record if record
#        return new (@data.customers.getModel())()
#
#    prepareData: (record) ->
#        user = @createUser record
#        record = @createRecord record
#        record.setUser user
#
#        return record
