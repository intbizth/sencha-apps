Ext.define 'Moboque.view.news.UpdateTranstionView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-news-update-transition'

    modal: yes
    closable: yes
    width: 400
    bodyPadding: 10

    layout:
        type: 'table'
        columns: 2
        tableAttrs:
            style:
                width: '100%'
    defaults:
        padding: '5'

    initComponent: ->
        @items = []
        translations = @config.data.get('translations')

        for transition, translation of translations
            @items.push({
                xtype: 'container'
                width: 100
                items:
                    xtype: 'button'
                    width: '100%'
                    #text: translation.name
                    text: transition
                    widgetRecord: @config.record
                    transitionKey: transition
                    handler: @config.handlerName
            })

            @items.push({
                xtype: 'container'
                html: translation.description
            })

        @callParent(arguments)
        @center()
