Ext.define 'Vcare.view.taxon.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-taxon-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-taxon'

    controller: 'ctrl-taxon'

    layout: 'border'

    items: [
        region: 'center'
        xtype: 'wg-taxon-category-list'
        flex: 1
    ,
        region: 'east'
        xtype: 'wg-taxon-brand-list'
        split: yes
        flex: 1
    ]
