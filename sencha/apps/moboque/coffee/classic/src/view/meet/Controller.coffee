Ext.define 'Moboque.view.meet.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-meet'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มสถานะ'
        else r.get 'description'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-meet-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-meet-form'
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
    onEdit: -> @createDialog @referTo('MeetList').getSelection()[0]

    onDelete: -> @baseDelete('MeetList')
    onSubmit: -> @baseSubmit('form', 'record')