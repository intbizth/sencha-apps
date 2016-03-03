Ext.define 'Vcare.view.taxonomy.TaxonListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-taxon-list'

    bind:
        store: '{taxons}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'Taxons'
    reference: 'refTaxonList'
    headerBorders: no

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
        bind: disabled: '{!refTaxonomyList.selection}'
        items: [
            text: 'เพิ่มรายการ'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls:'fa fa-pencil-square-o'
            bind: disabled: '{!refTaxonList.selection}'
            handler: 'onEdit'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-trash-o'
            bind: disabled: '{!refTaxonList.selection}'
            handler: 'onDelete'
        ]
