Ext.define 'Moboque.view.link.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-link-layout'

    viewModel:
        type: 'vm-link'

    controller: 'ctrl-link'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-link-list'
        flex: 1
    ]
