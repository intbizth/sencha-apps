Ext.define 'Moboque.view.meet.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-meet'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-meet-form', vmType: 'vm-meet-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-meet-form', vmType: 'vm-meet-form', refer: 'MeetList', title : 'description'})
    onDelete: -> @baseDelete('MeetList')
    onSubmit: -> @baseSubmit('MeetList', {success: 'โพสคำทักทายแล้ว!', edited: 'แก้ไขคำทักทายเรียบร้อย', error: 'ไม่สามารถเพิ่มข้อมูลได้'})
