Ext.define 'Moboque.view.activity.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-activity-layout'

    viewModel:
        type: 'vm-activity'

    controller: 'ctrl-activity'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-activity-list'
        flex: 1
    ]
