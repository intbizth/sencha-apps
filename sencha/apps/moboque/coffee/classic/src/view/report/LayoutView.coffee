Ext.define 'Moboque.view.report.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-report-layout'

    viewModel:
        type: 'vm-report'

    controller: 'ctrl-report'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-report-list'
        flex: 1
    ]
