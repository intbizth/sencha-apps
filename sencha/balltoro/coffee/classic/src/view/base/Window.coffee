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

        @setBox @ownerView.getBox() if @ownerView

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
        return no if !@ownerDataKey

        record = @viewModel.get @ownerDataKey
        record.reject()
        record.store.rejectChanges()
        return

        #@viewModel.preSubmit(record) if @viewModel.preSubmit
        # TODO: Now not work!
        if record and record.dirty
            @showConfirmMessage
                title: 'ข้อมูลมีการเปลี่ยนแปลง'
                message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                fn: (pressed) =>
                    if pressed == 'ok'
                        record.store.rejectChanges()
                        @dialog.close()

            return no
