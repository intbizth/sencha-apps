Ext.define 'Vcare.view.shipment.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-shipment'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข Shipment ##{record.get('id')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-shipment-form'
            title:  title
            viewModel:
                type: 'vm-shipment-form'
                data:
                    record: record

        @callParent([record, options])

    onSplit: (btn) ->
        shipment_id = @currentShipment
        Ext.MessageBox.confirm 'Confirm', 'Are you sure you want to split these items?', (btnText) ->
            if btnText == 'yes'
                dialog = btn.up('window')
                store = @getViewModel().get('shipments')
                selModel = btn.up('grid').getSelectionModel()
                items = []

                for item in selModel.getSelection()

                    items.push(item.id)

                dialog.mask('Splitting the shipment ...')

                store.splitShipment
                    items: items
                    params:
                        id: shipment_id
                    callback: (success) =>
                        @successAlert('Split shipment completely !')
                        dialog.close()

        ,this


    onShow: (btn) ->
        record = btn.getSingleWidgetRecord()
        dialog = @getView().add
            xtype: 'wg-shipment-show'
            data: record

        dialog.show()

    onShowSplit: (btn) ->
        record = btn.getSingleWidgetRecord()
        if record.data.units.length > 1
            @currentShipment = record.data.id
            dialog = @getView().add
                xtype: 'wg-shipment-split'
                data: record

            dialog.show()
        else
            alert('Not enough items to split !')

    onShipmentTransitionUpdateButtonClick: (btn) ->
        dialog = btn.up('window')
        record = btn.getSingleWidgetRecord()
        store = @getViewModel().get('transitions')

        Ext.MessageBox.confirm 'Confirm', 'Are you sure you want to apply this transition?', (btnText) ->
            if btnText == 'yes'
                dialog.mask('Applying transition ...')
                store.updateState
                    params:
                        name: 'shipment'
                        id: record.getId()
                        transition: btn.transitionKey
                    callback: (success) =>
                        @successAlert('Apply transition completely !')
                        record.store.reload()
                        dialog.unmask()
                        dialog.close()

        ,this


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
