Ext.define 'Moboque.view.report-image.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-report-image'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.getReportDescription()}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-report-image-form'
            title:  title
            viewModel:
                type: 'vm-report-image-form'
                data:
                    record: record
        @callParent([record, options])

    onSubmitWithImage: ->
        vm = @dialog.getViewModel()

        me = @
        form = @dialog.down 'form'
        record = vm.get 'record'

        if record.hasFileUpload
            console.log 'yes, have image'
            # count if imageInput have more than one fields.
            filesInput = []
            imageInput = @manageFiles(form, 'image')

            if imageInput.files and imageInput.files.length
                filesInput.push(imageInput)

            # if got image file, ENCODE them and submit.
            if filesInput.length
                Ext.each filesInput, (input) ->
                    i = 0
                    reader = new FileReader()
                    reader.readAsDataURL input.files[0]
                    reader.onload = (e) ->
                        i++
                        record.set(input.name, 'media': e.target.result)

                        if i == filesInput.length
                            me.onSubmit()
            else
                # maybe edit with no image.
                @onSubmit()

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
