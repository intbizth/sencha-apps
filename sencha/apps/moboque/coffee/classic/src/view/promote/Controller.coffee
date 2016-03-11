Ext.define 'Moboque.view.promote.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-promote-form', vmType: 'vm-promote-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-promote-form', vmType: 'vm-promote-form', refer: 'PromoteList', title : 'title'})
    onDelete: -> @baseDelete('PromoteList')
    onSubmit: -> @baseSubmit('PromoteList')
