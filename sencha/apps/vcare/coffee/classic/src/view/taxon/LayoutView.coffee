Ext.define 'Vcare.view.taxon.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-taxon-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-taxon'

    controller: 'ctrl-taxon'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-taxonomy-list'
        flex: 1
    ,
        xtype: 'wg-taxon-list'
        hidden: yes
        flex: 3
        margin: '0 0 0 10'
    ]
