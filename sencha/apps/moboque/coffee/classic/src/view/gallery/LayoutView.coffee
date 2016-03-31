Ext.define 'Moboque.view.gallery.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-gallery-layout'

    viewModel:
        type: 'vm-gallery'

    controller: 'ctrl-gallery'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-gallery-list'
        flex: 1
    ]
