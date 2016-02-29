Ext.define 'Moboque.view.event.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-event-layout'

    viewModel:
        type: 'vm-event'

    controller: 'ctrl-event'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-event-list'
        flex: 1
    ]
