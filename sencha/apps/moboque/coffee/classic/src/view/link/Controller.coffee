Ext.define 'Moboque.view.link.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-link'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('label')}"
        record = vm.prepareData(record)
        console.log 'RECORD', record

        options =
            xtype: 'wg-link-form'
            title:  title
            viewModel:
                type: 'vm-link-form'
                data:
                    record: record

        @callParent([record, options])

#    init: -> #..
#        @setWidgetForm 'wg-link-form'
#        @setViewModelForm 'vm-link-form'
#        @setEditField 'label'
