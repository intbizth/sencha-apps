Ext.define 'Moboque.view.sub-district.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-sub-district-form'

    stores:
        districts:
            type: 'store-districts'
            autoLoad: yes
            pageSize: 25

    formulas:
        district:
            get: ->
                @get('record').getDistrict()

            set: (val) ->
                @get('record').setDistrict val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        districtId = @get('record').getPrevious('district_id')

        if districtId
            @get('record').setDistrict @get('districts').getById(districtId)
            record.commit()
