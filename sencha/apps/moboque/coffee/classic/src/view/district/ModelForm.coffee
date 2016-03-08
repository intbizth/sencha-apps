Ext.define 'Moboque.view.district.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-district-form'

    stores:
        provinces:
            type: 'store-provinces'
            autoLoad: yes
            pageSize: 25

    formulas:
        province:
            get: ->
                @get('record').getProvince()

            set: (val) ->
                @get('record').setProvince val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        provinceId = @get('record').getPrevious('province_id')

        if provinceId
            @get('record').setProvince @get('provinces').getById(provinceId)
            record.commit()
