Ext.define 'Vcare.view.taxonomy.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-taxonomy-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-taxonomy'

    controller: 'ctrl-taxonomy'

    layout: 'border'

    items: [
        xtype: 'wg-taxonomy-list'
        region:'west'
        width: 300
        floatable: no
        split: yes
    ,
        xtype: 'wg-taxon-list'
        region: 'center',
        flex: 1
    ]
