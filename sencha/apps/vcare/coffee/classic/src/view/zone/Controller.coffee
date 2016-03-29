Ext.define 'Vcare.view.zone.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-zone'

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getZoneStore: -> @getViewModel().get('zones')

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

        @getZoneStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)
