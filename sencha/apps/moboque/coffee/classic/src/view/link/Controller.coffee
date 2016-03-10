Ext.define 'Moboque.view.link.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-link'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มลิงค์'
        else r.get 'label'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-link-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-link-form'
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
    onEdit: -> @createDialog @referTo('LinkList').getSelection()[0]

    onDelete: -> @baseDelete('LinkList')
    onSubmit: -> @baseSubmit('LinkList')
