Ext.define 'Toro.view.news.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-news-layout'

    controller: 'ctrl-news'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-news-list'
        flex: 1
    ]
