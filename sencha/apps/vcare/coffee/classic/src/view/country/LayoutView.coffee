Ext.define 'Vcare.view.country.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-country-layout'

    viewModel:
        type: 'vm-country'

    controller: 'ctrl-country'
    cls: 'ui-shadow-panel'

    layout: 'fit'

    items: [
        xtype: 'wg-country-list'
    ]
