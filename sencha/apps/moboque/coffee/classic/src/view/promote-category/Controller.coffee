Ext.define 'Moboque.view.promote-category.Controller',
    extend: 'Moboque.view.base.BaseController'
    alias: 'controller.ctrl-promote-category'

    init: -> #..
        @setWidgetForm 'wg-promote-category-form'
        @setViewModelForm 'vm-promote-category-form'
        @setEditField 'title'
