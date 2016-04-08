Ext.define 'Moboque.view.news_category.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-news-category-layout'

    viewModel:
        type: 'vm-news-category'

    controller: 'ctrl-news-category'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-news-category-list'
        flex: 1
    ]
