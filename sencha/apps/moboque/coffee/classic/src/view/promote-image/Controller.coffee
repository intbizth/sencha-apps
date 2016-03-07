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
    onSubmit: -> @baseSubmit('form', 'record')

    getDataInModel: (fieldName) ->
        record = @dialog.getViewModel().get 'promote'
        return record.get(fieldName)

    fileReader: (inputfiles, record) ->
        me = @

        Ext.each inputfiles, (input, index) ->
            reader = new FileReader()
            reader.readAsDataURL input.files[0]

            reader.onload = (e) ->
                record.set(input.name, 'media': e.target.result)

                if index == (inputfiles.length - 1)
                    me.save(record)

    onClickImage: (e, t, eOpts) ->
        if image = @getDataInModel('image')
            console.log t.src

    setImagePreview: (imageComponent) ->
        ref = imageComponent.getReference().toLowerCase()
        name = ref.replace('ref', '')

        if image = @getDataInModel(name)
            imageComponent.setSrc(image.media.url)

    manageImagePath: (field, value, ref) ->
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))

        thumbnail = field.up().lookupReference(ref)
        thumbnail.setSrc('')

    imageUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refImage')

    coverUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refCover')