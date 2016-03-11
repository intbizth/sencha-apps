Ext.define 'Vcare.model.TaxonCategory',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxons/category/'

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'parent'
        reference:
            type: 'TaxonCategory'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    getName: -> @trans 'name'

    writerTransform: fn: (data) ->
        console.log data
        if data.parent
            data.parent = data.parent.id

        return data
