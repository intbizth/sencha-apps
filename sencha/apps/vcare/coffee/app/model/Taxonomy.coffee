Ext.define 'Vcare.model.Taxonomy',
    extend: 'Vcare.model.Translatable'
    api: '/api/taxonomies/'

    getName: -> @trans 'name'

    getFormTitle: ->
        if @phantom
           return 'เพิ่มรายการ'
        else 'แก้ไข ' + @getName()
