Ext.define 'Moboque.view.travel.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-travel'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-travel-form', vmType: 'vm-travel-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-travel-form', vmType: 'vm-travel-form', refer: 'TravelList', title : 'title'})
    onDelete: -> @baseDelete('TravelList')
    onSubmit: -> @baseSubmit('TravelList')
