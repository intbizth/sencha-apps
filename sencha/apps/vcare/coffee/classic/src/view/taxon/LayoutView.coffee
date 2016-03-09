Ext.define 'Vcare.view.taxon.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-taxon-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-taxon'

    controller: 'ctrl-taxon'
    layout: 'fit'

    items: [
        xtype: 'wg-taxon-category-list'
    ]
