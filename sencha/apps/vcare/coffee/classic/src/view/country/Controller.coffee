Ext.define 'Vcare.view.country.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-country'

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getCountryStore: -> @getViewModel().get('countries')

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

        @getCountryStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)
