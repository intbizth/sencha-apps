Ext.define 'Moboque.view.member.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-member'

    stores:
        members:
            type: 'store-members'
            autoLoad: yes

        groups:
            type: 'store-groups'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.members.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
