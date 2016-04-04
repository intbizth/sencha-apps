Ext.define 'Vcare.view.product.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-product'

    # todo create active 'card' layout in base
    activeForm: (record) ->
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"

        vm = @getViewModel()
        record = vm.prepareData(record)

        form = @getView().add
            xtype: 'wg-product-form'
            id: 'form'
            ownerView: @getView()
            widgetRecord: record
            title: title
            viewModel:
                type: 'vm-product-form'
                data:
                    record: record

        @getView().setActiveItem('form')

    removeForm: ->
        @getView().setActiveItem('list')
        @getView().remove('form')

    onAddNew: (btn) -> @activeForm()

    onEdit: (btn) -> @activeForm(btn.getSingleWidgetRecord())

    onCancel: (btn) ->
        #todo check dirty
        @removeForm()

    onFormMenuClick: (btn) ->
        formTabs = @referTo 'FormTabs'
        formTabs.setActiveItem(btn.getItemId())

    # todo use base or create function for form 'card' layout
    onSubmit: ->
        formPanel = @referTo 'ProductForm'
        vm = formPanel.getViewModel()
        form = formPanel.down 'form'
        record = vm.get 'record'

        vm.beforeSubmit(record, form)

        record.save
            failure: (record, o) =>
                console.log 'failure'
            success: (record, o) =>
                console.log 'success'
                @removeForm()