Ext.define 'Vcare.model.Taxonomy',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxonomies/'

    translationFields: ['name', 'permalink', 'description']

    fields: [
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        persist: no
        convert: (v, r) -> r.getName()
    ]

    getName: -> @trans 'name'
