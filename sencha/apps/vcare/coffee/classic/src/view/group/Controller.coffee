Ext.define 'Vcare.view.group.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-group'

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getGroupStore: -> @getViewModel().get('groups')

    onCancelEdit: (editor, context) ->
        @getViewModel().reject()

    onSubmit: (editor, context) ->
        editor.grid.mask("กำลังลบรายการ ...")

        context.record.save
            failure: (record, o) =>
                editor.grid.unmask()
                @failureAlert(@getFailureMessage())

            success: (record, o) =>
                editor.grid.unmask()
                @successAlert(@getSuccessMessage())

    onAddNew: ->
        record = @getViewModel().createRecord()

        @getGroupStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)
