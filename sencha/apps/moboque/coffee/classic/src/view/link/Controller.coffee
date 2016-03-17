Ext.define 'Moboque.view.link.Controller',
    extend: 'Moboque.view.base.BaseController'
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

    init: -> #..
        @setWidgetForm 'wg-link-form'
        @setViewModelForm 'vm-link-form'
#
#    onCancel: -> @dialog.close()

#    onAddNew: ->
#       @baseCreateDialog({xType: 'wg-link-form', vmType: 'vm-link-form'})


#    onEdit: -> @baseCreateDialog({xType: 'wg-link-form', vmType: 'vm-link-form', refer: 'LinkList', title : 'label'})
#    onDelete: -> @baseDelete('LinkList')
#    onSubmit: -> @baseSubmit('LinkList')
