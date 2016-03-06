Ext.define 'Moboque.view.promote-image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-promote-image'

    stores:
        promotesImage:
            type: 'store-promote-image'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.promotesImage.getModel())()

    prepareData: (record) ->
        record = @createRecord record
#        promoteRecord = record.getPromoteImage()
#
#        if promoteRecord and record.get('promote_id') != promoteRecord.getId()
#            record.set('promote_id', promoteRecord.getId())
#            record.commit()
#
        return record
