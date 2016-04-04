Ext.define 'Moboque.view.link.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-link'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('label')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-link-form'
            title:  title
            viewModel:
                type: 'vm-link-form'
                data:
                    record: record

        @callParent([record, options])

    getRowEditor: ->
        @getView()
            .down('grid')
            .getPlugin('rowediting')

    getLinkStore: -> @getViewModel().get('links')

    onAddNew: ->
        record = @getViewModel().createRecord()

        @getLinkStore().insert(0, record)
        @getRowEditor().startEdit(record, 0)

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
