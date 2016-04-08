Ext.define 'Moboque.view.promote_image.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-promote-image-layout'

    viewModel:
        type: 'vm-promote-image'

    controller: 'ctrl-promote-image'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-promote-image-list'
        flex: 1
    ]
