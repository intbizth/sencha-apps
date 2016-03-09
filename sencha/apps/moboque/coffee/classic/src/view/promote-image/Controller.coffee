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

#        # cover field
#        coverInput = @manageFiles(form, 'cover')
#
#        if coverInput.files and coverInput.files.length
#            filesInput.push(coverInput)

        if filesInput.length
            @fileReader(filesInput, record)
        else
            @save(record)

    fileReader: (inputfiles, record) ->
        me = @

        Ext.each inputfiles, (input, index) ->
            reader = new FileReader()
            reader.readAsDataURL input.files[0]
            console.log '>>>>' + input
            reader.onload = (e) ->
                record.set(input.name, 'media': e.target.result)

                if index == (inputfiles.length - 1)
#                    me.baseSubmit('form', 'record')
                    me.save(record)

    getDataInModel: (fieldName) ->
        record = @dialog.getViewModel().get 'promote'
        return record.get(fieldName)

    setImagePreview: (imageComponent) ->
        ref = imageComponent.getReference().toLowerCase()
        name = ref.replace('ref', '')

        if image = @getDataInModel(name)
            imageComponent.setSrc(image.media.url)

    manageImagePath: (field, value, ref) ->
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))
        console.log field
#        thumbnail = field.up().lookupReference(ref)
#        thumbnail.setSrc('')

    imageUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refImage')

    coverUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refCover')


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
