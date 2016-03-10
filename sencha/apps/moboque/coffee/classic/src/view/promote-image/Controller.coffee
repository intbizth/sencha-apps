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
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'record'

        filesInput = []

        # image field
        imageInput = @manageFiles(form, 'image')

        if imageInput.files and imageInput.files.length
            filesInput.push(imageInput)

        # ตอน submit ถ้ามีการ add image? ให้แปลง image
        if filesInput.length
            @fileReader(filesInput, record)
        else
            @baseSubmit('form', 'record')
#            @save(record)

    fileReader: (inputfiles, record) ->
        me = @

        Ext.each inputfiles, (input, index) ->
            reader = new FileReader()
            reader.readAsDataURL input.files[0]
            console.log 'Reader', reader
            reader.onload = (e) ->
                record.set(input.name, 'media': e.target.result)

                if index == (inputfiles.length - 1)
                    me.baseSubmit('form', 'record')
#                    me.save(record)

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

    save: (record) ->
        form = @dialog.down 'form'
        store = @referTo('PromoteImageList').getStore()
        isNewRecord = record.phantom
        fieldsChanged = record.getChanges()

        imageUpdated = fieldsChanged.hasOwnProperty('image')

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการข่าว กรุณาลองใหม่อีกครั้งค่ะ'

                    if response = o.error.response
# internal server error
                        if response.status == 500
                            titleMessage = response.statusText
                            errorMessage = 'Sorry, something went wrong.'

                        # sf validation error.
                        if response.status == 400
                            obj = Ext.decode response.responseText
                            titleMessage = obj.message

                            Ext.Object.each obj.errors.children, (key, value, item) ->
                                if value.hasOwnProperty('errors')
                                    errorMessage = value.errors[0]

                    @alertFailure
                        title: titleMessage
                        message: errorMessage

                success: (rec, o) =>
                    form.unmask()

                    if isNewRecord
                        store.add rec
                        store.commitChanges()
                        @alertSuccess('เพิ่มข่าวเรียบร้อยแล้วค่ะ')

                    else
                        if imageUpdated
                            record.load()

                        @alertSuccess('แก้ไขข่าวเรียบร้อยแล้วค่ะ')

                    @dialog.close()
        else
            @dialog.close()
