Ext.define 'Moboque.view.meet.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-meet-layout'

    viewModel:
        type: 'vm-meet'

    controller: 'ctrl-meet'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-meet-list'
        flex: 1
    ]
