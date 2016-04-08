Ext.define 'Moboque.model.Service',
    extend: 'Moboque.model.Base'
    api: '/api/services/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    ,
        name: 'detail'
        type: 'string'
    ,
        name: 'price'
        type: 'number'
    ,
        name: 'price_currency'
        type: 'string'
    ,
        name: 'link'
        type: 'string'
    ,
        name: 'service_category'
        reference:
            type: 'ServiceCategory'
            role: 'service_category'
            associationKey: 'service_category'
            getterName: 'getServiceCategory'
            setterName: 'setServiceCategory'
    ]

    getServiceCategoryName: ->
        serviceCategory = @getServiceCategory()

        return serviceCategory.get("title") if serviceCategory
        return ''

    writerTransform: fn: (data) ->

        if data.service_category
            data.service_category = data.service_category.id

        return data
