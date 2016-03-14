Ext.define 'Vcare.view.taxon.CategoryListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-taxon-category-list'

    bind:
        store: '{categories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'Category'
    reference: 'refTaxonCategoryList'
    headerBorders: no

    getTaxonType: -> 'category'

    getTreePadding: (meta, r, label) ->
        padding = (r.get('level') * 20) + 10
        meta.style = "padding-left: #{padding}px"

        return label

    columns: [
        text: 'Code'
        dataIndex: 'code'
        width: 300
        renderer: (v, m, r) -> @getTreePadding(m, r, v)
    ,
        flex: 1
        text: 'Name'
        renderer: (v, m, r) -> @getTreePadding(m, r, r.getName())
    ]

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
            bind: widgetRecord: '{refTaxonCategoryList.selection}'
            handler: 'onEdit'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            text: 'ลบ'
            xtype: 'button'
            iconCls:'fa fa-trash-o'
            bind: widgetRecord: '{refTaxonCategoryList.selection}'
            handler: 'onDelete'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ]
