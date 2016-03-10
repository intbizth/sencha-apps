Ext.define 'Moboque.view.promote-image.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote-image'

    init: -> #..

    # @private
    createDialogTitle: (r) ->
        if r.phantom
            return 'เพิ่มรายการ'
        else r.get 'title'

    # @private
    createDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareData(record)

        @dialog = @getView().add
            xtype: 'wg-promote-image-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-promote-image-form'
                data:
                    title: @createDialogTitle record
                    record: record

            listeners:
                beforeclose: (panel, eOpts) =>
                    if record and record.dirty
                        @showConfirmMessage
                            title: 'ข้อมูลมีการเปลี่ยนแปลง'
                            message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                            fn: (pressed) =>
                                if pressed == 'ok'
                                    if record.store
                                        record.store.rejectChanges()
                                    @dialog.close()

                        return no

        @dialog.show()

    onCancel: -> @dialog.close()
    onAddNew: -> @createDialog()
    onEdit: -> @createDialog @referTo('PromoteImageList').getSelection()[0]

    onDelete: -> @baseDelete('PromoteImageList')

#------ Image ------#
    onSubmit: ->
        @baseSubmit('PromoteImageList', yes)
#        form = @dialog.down 'form'
#        record = @dialog.getViewModel().get 'record'
#
#        filesInput = []
#
#        # image field
#        imageInput = @manageFiles(form, 'image')
#
#        if imageInput.files and imageInput.files.length
#            filesInput.push(imageInput)
#
#        # ตอน submit ถ้ามีการ add image? ให้แปลง image
#        if filesInput.length
#            @fileReader(filesInput, record)
#        else
#            @save(record)

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
