Ext.define 'Vcare.view.order.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-order'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('number')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-order-form'
            title:  title
            viewModel:
                type: 'vm-order-form'
                data:
                    record: record

        @callParent([record, options])

    onOrderTransitionUpdateButtonClick: (btn) ->
        dialog = btn.up('window')
        record = btn.getSingleWidgetRecord()
        store = @getViewModel().get('transitions')

        # TODO: confirmation

        store.updateState
            params:
                name: 'order'
                id: record.getId()
                transition: btn.transitionKey
            callback: (success) =>
                # reload grid
                record.store.reload()
                dialog.close()

    onShow: (btn) ->
        record = btn.getSingleWidgetRecord()
        dialog = @getView().add
            xtype: 'wg-order-show'
            data: record

        dialog.show()

    onUpdateState: (btn) ->
        view = @getView()
        store = @getViewModel().get('transitions')
        record = btn.getSingleWidgetRecord()

        view.mask('Waiting ...')

        store.load
            params:
                name: 'order'
                id: record.getId()
            callback: (rs, operation) =>
                view.unmask()

                if !rs.length
                    alert('can not transitions')
                    return

                dialog = view.add
                    xtype: 'wg-order-update-transition'
                    title: "Order: #{record.get('number')}"
                    handlerName: 'onOrderTransitionUpdateButtonClick'
                    data: rs[0]
                    record: record

                dialog.show()
