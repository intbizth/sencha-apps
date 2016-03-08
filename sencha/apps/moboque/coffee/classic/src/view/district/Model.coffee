Ext.define 'Moboque.view.district.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-district'

    stores:
        districts:
            type: 'store-districts'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.districts.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        provinceRecord = record.getProvince()

        if provinceRecord and record.get('province_id') != provinceRecord.getId()
            record.set('eprovince_id', provinceRecord.getId())
            record.commit()

        return record
