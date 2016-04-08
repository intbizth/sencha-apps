Ext.define 'Moboque.view.gallery_category.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-gallery-category-layout'

    viewModel:
        type: 'vm-gallery-category'

    controller: 'ctrl-gallery-category'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-gallery-category-list'
        flex: 1
    ]
