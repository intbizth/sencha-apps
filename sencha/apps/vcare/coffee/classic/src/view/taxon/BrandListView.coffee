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
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            iconCls:'fa fa-pencil-square-o'
            bind: aclCheck: '{refTaxonBrandList.selection}'
            handler: 'onEdit'
        ,
            text: 'ลบ'
            xtype: 'button'
            iconCls:'fa fa-trash-o'
            bind: aclCheck: '{refTaxonBrandList.selection}'
            handler: 'onDelete'
        ]
