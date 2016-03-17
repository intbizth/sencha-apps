Ext.define 'Moboque.view.gift.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-gift'

    init: -> #..
        @setReference 'GiftList'
        @setWidgetForm 'wg-gift-form'
        @setViewModelForm 'vm-gift-form'
