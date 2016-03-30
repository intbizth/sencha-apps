Ext.define 'Vcare.view.locale.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-locale'

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getLocaleStore: -> @getViewModel().get('locales')

    onCancelEdit: (editor, context) ->
        context.record.reject()

    onSubmit: (editor, context) ->
        editor.grid.mask("กำลังบันทึกรายการ ...")

        context.record.save
            failure: (record, o) =>
                editor.grid.unmask()
                @failureAlert(@getFailureMessage())

            success: (record, o) =>
                editor.grid.unmask()
                @successAlert(@getSuccessMessage())

    onAddNew: ->
        record = @getViewModel().createRecord()

        @getLocaleStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)
