Ext.define 'Moboque.view.sub-district.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-sub-district'

    stores:
        subDistricts:
            type: 'store-sub-districts'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.subDistricts.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        districtRecord = record.getDistrict()

        if districtRecord and record.get('district_id') != districtRecord.getId()
            record.set('district_id', districtRecord.getId())
            record.commit()

        return record
