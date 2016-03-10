Ext.define 'Moboque.view.personal.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-personal'

    stores:
        personals:
            type: 'store-personals'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.personals.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        personalDepartmentRecord = record.getPersonalDepartment()

        if personalDepartmentRecord and record.get('personalDepartment_id') != personalDepartmentRecord.getId()
            record.set('personalDepartment_id', personalDepartmentRecord.getId())
            record.commit()

        return record
