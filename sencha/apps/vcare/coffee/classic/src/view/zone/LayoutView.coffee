Ext.define 'Vcare.view.zone.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-zone-layout'

    viewModel:
        type: 'vm-zone'

    controller: 'ctrl-zone'
    cls: 'ui-shadow-panel'

    layout: 'fit'

    items: [
        xtype: 'wg-zone-list'
    ]
