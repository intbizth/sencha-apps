Ext.define 'Moboque.view.promote.Controller',
    extend: 'Moboque.view.base.BaseController'
    alias: 'controller.ctrl-promote'

    init: -> #..
        @setWidgetForm 'wg-promote-form'
        @setViewModelForm 'vm-promote-form'
        @setEditField 'title'
