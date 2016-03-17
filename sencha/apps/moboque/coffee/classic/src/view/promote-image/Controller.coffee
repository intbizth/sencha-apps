Ext.define 'Moboque.view.promote-image.Controller',
    extend: 'Moboque.view.base.BaseController'
    alias: 'controller.ctrl-promote-image'

    init: ->
        @setWidgetForm 'wg-promote-image-form'
        @setViewModelForm 'vm-promote-image-form'
        @setEditField 'title'

#    # override
#    createDialog: (record) ->
#        vm = @getViewModel()
#        title = if !record then 'เพิ่มรูปใหม่' else "แก้ไข #{record.get('title')}"
#        record = vm.prepareData(record)
#        console.log 'RECORD', record.hasFileUpload
#        return
#        options =
#            xtype: 'wg-promote-image-form'
#            title:  title
#            viewModel:
#                type: 'vm-promote-image-form'
#                data:
#                    record: record
#
#        @callParent([record, options])


    setImagePreview: (imageComponent) ->
        console.log 'img', imageComponent
        record = @dialog.getViewModel().get 'record'

        if image = record.get 'image'
            imageComponent.setSrc(image.media.url)
        else
            imageComponent.setSrc('http://dummyimage.com/300x200/757575/242424.png&text=Image+Here')

    imageUploadChanged: (field, value) ->
        applyBtn = @dialog.down('form').lookupReference('refApply')
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))
        applyBtn.setHidden(no)

    applyImage: ->
        form = @dialog.down 'form'
        imageInput = @manageFiles(form, 'image')

        if imageInput.files and imageInput.files.length
            Ext.each imageInput, (input) ->
                reader = new FileReader()
                reader.readAsDataURL input.files[0]
                reader.onload = (e) ->
                    thumbnail = form.lookupReference('refImage')
                    thumbnail.setSrc(e.target.result)
                    return
