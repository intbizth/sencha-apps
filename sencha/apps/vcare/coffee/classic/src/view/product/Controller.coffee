Ext.define 'Vcare.view.product.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-product'

    # todo create active 'card' layout in base
    activeForm: (record) ->
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"

        vm = @getViewModel()
        record = vm.prepareData(record)

        console.log record

        if !form = @referTo 'ProductForm'
            form = @getView().add
                xtype: 'wg-product-form'
                id: 'form'
                title: title
                viewModel:
                    type: 'vm-product-form'
                    data:
                        record: record

        main = @getMainLayout(form)
        main.setActiveItem('form')

    getMainLayout: (panel) ->
        return panel.up('container')

    onAddNew: (btn) -> @activeForm()

    onEdit: (btn) -> @activeForm(btn.getSingleWidgetRecord())

    onCancel: (btn) ->
        form = btn.up('form')
        main = @getMainLayout(form)

        #todo check dirty
        main.setActiveItem('list')

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
