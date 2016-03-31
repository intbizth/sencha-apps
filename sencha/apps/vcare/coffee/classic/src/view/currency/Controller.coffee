Ext.define 'Vcare.view.currency.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-currency'

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getCurrencyStore: -> @getViewModel().get('currencies')

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

        @getCurrencyStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)
