Ext.define 'Moboque.view.promote-category.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote-category'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-promote-category-form', vmType: 'vm-promote-category-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-promote-category-form', vmType: 'vm-promote-category-form', refer: 'PromoteCategoryList', title : 'title'})
    onDelete: -> @baseDelete('PromoteCategoryList')
    onSubmit: -> @baseSubmit('PromoteCategoryList')
