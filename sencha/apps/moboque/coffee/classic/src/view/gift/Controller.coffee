Ext.define 'Moboque.view.gift.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-gift'

    init: -> #..
        @setReference 'GiftList'
        @setWidgetForm 'wg-gift-form'
        @setViewModelForm 'vm-gift-form'

#    onEdit: -> @baseCreateDialog({xType: 'wg-gift-form', vmType: 'vm-gift-form', refer: 'GiftList', title : 'title'})
#    onDelete: -> @baseDelete('GiftList')
#    onSubmit: -> @baseSubmit('GiftList')
