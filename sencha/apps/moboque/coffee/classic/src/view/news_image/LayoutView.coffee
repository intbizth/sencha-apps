Ext.define 'Moboque.view.news_image.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-news-image-layout'

    viewModel:
        type: 'vm-news-image'

    controller: 'ctrl-news-image'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-news-image-list'
        flex: 1
    ]
