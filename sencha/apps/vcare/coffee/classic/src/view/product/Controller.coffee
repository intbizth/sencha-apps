Ext.define 'Vcare.view.product.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-product'

    getMainLayout: (panel) ->
        return panel.up('container')

    onAddNew: (btn) -> @activeForm()

    onEdit: (btn) -> @activeForm(btn.getSingleWidgetRecord())

    activeForm: (record) ->
        form = @referTo 'ProductForm'
        main = @getMainLayout(form)
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('name')}"

        form.setTitle title
        form.setViewModel
            type: 'vm-product-form'
            data:
                record: record

        main.setActiveItem('form')

    onCancel: (btn) ->
        form = btn.up('form')
        main = @getMainLayout(form)

        #todo check dirty
        main.setActiveItem('list')
