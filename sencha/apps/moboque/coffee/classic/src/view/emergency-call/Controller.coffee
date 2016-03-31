Ext.define 'Moboque.view.emergency-call.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-emergency-call'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-emergency-call-form'
            title:  title
            viewModel:
                type: 'vm-emergency-call-form'
                data:
                    record: record

        @callParent([record, options])

    onAddNew: ->
        emergencyCallList = @referTo 'EmergencyCallList'
        emergencyCallsStore = emergencyCallList.getStore()

        record = Ext.create 'Moboque.model.EmergencyCall',
            title: ''
            description: ''
            tel: null

        emergencyCallsStore.insert(emergencyCallsStore.getCount(), record)
        emergencyCallList.findPlugin('rowediting').startEdit(record)

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

        # record = @getViewModel().createRecord()

        # @getCountryStore().insert(0, record)
        # @getRowEditor().startEdit(record, 0)
