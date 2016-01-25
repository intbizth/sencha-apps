Ext.define 'Toro.view.base.Window',
    extend: 'Ext.window.Window'
    xtype: 'ux-base-window'

    autoShow: yes
    modal: yes

    layout: 'fit'

    width: 200
    height: 200
    frame: no
    border: no
    bodyPadding: 0

    afterRender: ->
        @callParent arguments
        @syncSize()

        Ext.on @resizeListeners =
            resize: @onViewportResize
            scope: @
            buffer: 50

    onDestroy: ->
        Ext.un @resizeListeners
        @callParent()

    onViewportResize: ->
        @syncSize()

    syncSize: ->
        width = Ext.Element.getViewportWidth()
        height = Ext.Element.getViewportHeight()

        @setSize Math.floor(width * 0.7), Math.floor(height * 0.7)
