Ext.define 'Moboque.view.service_image.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-service-image-layout'

    viewModel:
        type: 'vm-service-image'

    controller: 'ctrl-service-image'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-service-image-list'
        flex: 1
    ]
