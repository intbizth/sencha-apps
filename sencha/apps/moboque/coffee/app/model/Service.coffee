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
        name: 'serviceCategory'
        reference:
            type: 'ServiceCategory'
            role: 'serviceCategory'
            associationKey: 'service_category'
            getterName: 'getServiceCategory'
            setterName: 'setServiceCategory'
    ]

    getServiceCategoryName: ->
        serviceCategory = @getServiceCategory()

        return serviceCategory.get("title") if serviceCategory
        return ''

    writerTransform: fn: (data) ->

        if data.serviceCategory
            data.serviceCategory = data.serviceCategory.id

        return data

    validators:
        title: 'presence'
        sub_title: 'presence'
        detail: 'presence'
        price: 'presence'
        price_currency: 'presence'
        link: 'presence'
