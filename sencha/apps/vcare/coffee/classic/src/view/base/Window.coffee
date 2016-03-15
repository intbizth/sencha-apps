Ext.define 'Vcare.view.base.Window',
    extend: 'Ext.window.Window'
    xtype: 'ux-base-window'

    autoShow: yes
    modal: yes
    closable: no
    layout: 'fit'
    frame: no
    border: no
    bodyPadding: 0
    padding: 0

    config:
        fullsize: yes
        widgetRecord: null

    afterRender: ->
        @callParent arguments
        @syncSize() if @getFullsize()

        @setBox @ownerView.getBox() if @ownerView && @getFullsize()

        @on 'beforeclose', @dirtyClose, @

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

    # @private
    dirtyClose: (win, eOpts) ->

        if @viewModel.isDirty()
            @showConfirmMessage
                title: 'ข้อมูลมีการเปลี่ยนแปลง'
                message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                fn: (pressed) =>
                    if pressed == 'ok'
                        @setWidgetRecord(null)
                        @viewModel.reject()
                        @close()

            return no

    showConfirmMessage: (options, func) ->
        if Ext.isString options
            options = message: options

        if !options.title
            options.title = 'Confirm ?'

        if !options.icon
            options.icon = Ext.Msg.QUESTION

        if !options.buttons
            options.buttons = Ext.Msg.OKCANCEL

        if Ext.isObject func
            func.scope = @
            options.fn = (pressed) =>
                options.fn.call func.scope, pressed

        msg = Ext.create xtype: 'messagebox'
        msg.show options
