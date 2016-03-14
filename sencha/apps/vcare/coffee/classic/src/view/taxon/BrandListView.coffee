Ext.define 'Vcare.view.taxon.BrandListView',
    extend: 'Vcare.view.taxon.CategoryListView'
    alias: 'widget.wg-taxon-brand-list'

    bind:
        store: '{brands}'

    title: 'Brands'
    reference: 'refTaxonBrandList'
    getTaxonType: -> 'brand'

    tbar:
        items: [
            text: 'เพิ่มรายการ'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'fa fa-pencil-square-o'
            bind: widgetRecord: '{refTaxonBrandList.selection}'
            handler: 'onEdit'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            text: 'ลบ'
            iconCls:'fa fa-trash-o'
            bind: widgetRecord: '{refTaxonBrandList.selection}'
            handler: 'onDelete'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ]
