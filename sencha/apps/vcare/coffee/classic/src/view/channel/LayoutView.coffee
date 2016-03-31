Ext.define 'Vcare.view.channel.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-channel-layout'

    viewModel:
        type: 'vm-channel'

    controller: 'ctrl-channel'
    cls: 'ui-shadow-panel'

    layout: 'fit'

    items: [
        xtype: 'wg-channel-list'
    ]
