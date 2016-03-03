Ext.define 'Vcare.view.taxonomy.TaxonomyListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-taxonomy-list'

    bind:
        store: '{taxonomies}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'Taxonomy'
    reference: 'refTaxonomyList'
    headerBorders: no

    listeners:
        selectionchange: 'onTaxonomySelectionChange'

    columns: [
        flex: 1
        text: 'Name'
        renderer: (v, m, r) -> r.getName()
    ]

    tbar:
        items: [
            text: 'เพิ่ม'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNewTaxonomy'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditTaxonomy'
            iconCls:'fa fa-pencil-square-o'
            bind: disabled: '{!refTaxonomyList.selection}'
            handler: 'onEdit'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteTaxonomy'
            iconCls:'fa fa-trash-o'
            bind: disabled: '{!refTaxonomyList.selection}'
            handler: 'onDelete'
        ]
