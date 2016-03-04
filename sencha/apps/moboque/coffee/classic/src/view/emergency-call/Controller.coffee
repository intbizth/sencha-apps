Ext.define 'Moboque.view.emergency-call.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-emergency-call'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มเบอร์โทรฉุกเฉิน'
        else r.get 'title'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-emergency-call-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-emergency-call-form'
                data:
                    title: @createDialogTitle record
                    record: record

            listeners:
                beforeclose: (panel, eOpts) =>
                    if record and record.dirty
                        @showConfirmMessage
                            title: 'ข้อมูลมีการเปลี่ยนแปลง'
                            message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                            fn: (pressed) =>
                                if pressed == 'ok'
                                    if record.store
                                        record.store.rejectChanges()
                                    @dialog.close()

                        return no

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('EmergencyCallList').getSelection()[0]

    onDelete: -> @baseDelete('EmergencyCallList')
    onSubmit: -> @baseSubmit('form', 'record')