Ext.define 'Moboque.view.activity_image.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-activity-image-layout'

    viewModel:
        type: 'vm-activity-image'

    controller: 'ctrl-activity-image'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-activity-image-list'
        flex: 1
    ]
