Ext.define 'Vcare.view.shipment.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-shipment'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('number')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-shipment-form'
            title:  title
            viewModel:
                type: 'vm-shipment-form'
                data:
                    record: record

        @callParent([record, options])

    onShipmentTransitionUpdateButtonClick: (btn) ->
        dialog = btn.up('window')
        record = btn.getSingleWidgetRecord()
        store = @getViewModel().get('transitions')

        # TODO: confirmation

        store.updateState
            params:
                name: 'shipment'
                id: record.getId()
                transition: btn.transitionKey
            callback: (success) =>
                # reload grid
                record.store.reload()
                dialog.close()

    onUpdateState: (btn) ->
        view = @getView()
        store = @getViewModel().get('transitions')
        record = btn.getSingleWidgetRecord()

        view.mask('Waiting ...')

        store.load
            params:
                name: 'shipment'
                id: record.getId()
            callback: (rs, operation) =>
                view.unmask()
                if typeof rs[0].data.transitions == 'undefined'
                    alert('This object cannot be applied any transitions !')
                    return

                dialog = view.add
                    xtype: 'wg-shipment-update-transition'
                    title: "Shipment ID: #{record.get('id')}"
                    handlerName: 'onShipmentTransitionUpdateButtonClick'
                    data: rs[0]
                    record: record

                dialog.show()
