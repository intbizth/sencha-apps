Ext.define 'Vcare.model.Taxon',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxons/'

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
            type: 'Taxon'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    getName: -> @trans 'name'

    writerTransform: fn: (data) ->

        if data.parent
            data.parent = data.parent.id

        return data
