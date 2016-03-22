Ext.define 'Moboque.view.report-image.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-report-image-layout'

    viewModel:
        type: 'vm-report-image'

    controller: 'ctrl-report-image'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-report-image-list'
        flex: 1
    ]
