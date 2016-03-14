Ext.define 'Moboque.view.emergency-call.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-emergency-call'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-emergency-call-form', vmType: 'vm-emergency-call-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-emergency-call-form', vmType: 'vm-emergency-call-form', refer: 'EmergencyCallList', title : 'title'})
    onDelete: -> @baseDelete('EmergencyCallList')
    onSubmit: -> @baseSubmit('EmergencyCallList', {success: 'เพิ่มเบอร์โทรฉุกเฉินแล้ว!'})
