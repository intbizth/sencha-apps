Ext.define 'Vcare.view.taxon.TaxonListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-taxon-list'

    bind:
        store: '{taxons}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Taxons'
    reference: 'refTaxonList'
    headerBorders: no

    getTaxonType: -> 'taxon'

    getTreePadding: (meta, r, label) ->
        padding = ((r.get('level') - 1) * 20) + 10
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
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'pencil-square-o'
            bind: widgetRecord: '{refTaxonList.selection}'
            handler: 'onEdit'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ,
            text: 'ลบ'
            iconCls:'trash-o'
            bind: widgetRecord: '{refTaxonList.selection}'
            handler: 'onDelete'
            aclCheck: -> !!@getWidgetRecord().getParent()
        ]
