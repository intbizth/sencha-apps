Ext.define 'Vcare.view.taxon.TaxonomyListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-taxonomy-list'

    bind:
        store: '{taxonomies}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'Taxonomy'
    reference: 'refTaxonomyList'
    headerBorders: no

    getTaxonType: -> 'root'

    listeners:
        selectionchange: 'onTaxonomySelectionChange'

    columns: [
        text: 'Name'
        dataIndex: 'code'
        flex: 1
        renderer: (v, m, r) ->
            return "#{v} <br> #{r.get('name')}"
    ]

    tbar:
        items: [
            text: 'เพิ่มรายการ'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            iconCls:'pencil-square-o'
            bind: widgetRecord: '{refTaxonomyList.selection}'
            handler: 'onEdit'
            aclCheck: -> yes
        ,
            text: 'ลบ'
            iconCls:'trash-o'
            bind: widgetRecord: '{refTaxonomyList.selection}'
            handler: 'onDelete'
            aclCheck: -> yes
        ]
