Ext.define 'Moboque.view.group.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-group'

    stores:
        groups:
            type: 'store-groups'
            autoLoad: yes

        events:
            type: 'store-events'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.groups.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        eventRecord = record.getEvent()

        if eventRecord and record.get('event_id') != eventRecord.getId()
            record.set('event_id', eventRecord.getId())
            record.commit()

        return record
