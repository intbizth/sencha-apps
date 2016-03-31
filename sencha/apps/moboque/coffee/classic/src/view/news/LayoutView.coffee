Ext.define 'Moboque.view.news.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-news-layout'

    viewModel:
        type: 'vm-news'

    controller: 'ctrl-news'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-news-list'
        flex: 1
    ]
