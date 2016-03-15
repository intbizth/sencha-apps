Ext.define 'Vcare.view.taxon.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-taxon'

    # @override
    createDialog: (record, type) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.getName()}"
        record = vm.createRecord(record, type)
        store = if type == 'brand' then 'brands' else 'categories'

        options =
            xtype: 'wg-taxon-form'
            title: title
            viewModel:
                type: 'vm-taxon-form'
                data:
                    currentStore: store
                    record: record
                    parents: vm.getStore(store)

        @callParent([record, options])

    # @override
    onAddNew: (btn) ->
        @createDialog(
            null,
            btn.up('grid').getTaxonType()
        )

    # @override
    onEdit: (btn) ->
        @createDialog(
            btn.getSingleWidgetRecord(),
            btn.up('grid').getTaxonType()
        )
