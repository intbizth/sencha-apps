Ext.define 'Moboque.view.locale.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-locale'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-locale-form', vmType: 'vm-locale-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-locale-form', vmType: 'vm-locale-form', refer: 'LocaleList', title : 'title'})
    onDelete: -> @baseDelete('LocaleList')
    onSubmit: -> @baseSubmit('LocaleList')
