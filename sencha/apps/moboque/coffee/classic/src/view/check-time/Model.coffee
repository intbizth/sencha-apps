Ext.define 'Moboque.view.check-time.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-check-time'

    stores:
        checkTimes:
            type: 'store-check-times'
            autoLoad: yes

        members:
            type: 'store-members'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.checkTimes.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        memberRecord = record.getMember()

        if memberRecord and record.get('member_id') != memberRecord.getId()
            record.set('member_id', memberRecord.getId())
            record.commit()

        return record
