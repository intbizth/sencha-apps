Ext.define 'Moboque.view.link.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-link'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-link-form', vmType: 'vm-link-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-link-form', vmType: 'vm-link-form', refer: 'LinkList', title : 'label'})
    onDelete: -> @baseDelete('LinkList')
    onSubmit: -> @baseSubmit('LinkList')
