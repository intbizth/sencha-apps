Ext.define 'Vcare.view.locale.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-locale-layout'

    viewModel:
        type: 'vm-locale'

    controller: 'ctrl-locale'
    cls: 'ui-shadow-panel'

    layout: 'fit'

    items: [
        xtype: 'wg-locale-list'
    ]
