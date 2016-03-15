Ext.define 'Moboque.view.locale.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-locale-layout'

    viewModel:
        type: 'vm-locale'

    controller: 'ctrl-locale'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-locale-list'
        flex: 1
    ]
