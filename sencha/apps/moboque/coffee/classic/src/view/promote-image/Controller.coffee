Ext.define 'Moboque.view.promote-image.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-promote-image'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-promote-image-form'
            title:  title
            viewModel:
                type: 'vm-promote-image-form'
                data:
                    record: record
        @callParent([record, options])

    onSubmit: ->
        vm = @dialog.getViewModel()

        me = @
        form = @dialog.down 'form'
        record = vm.get 'record'

        if record.hasFileUpload
            console.log 'yes, have image'
            # check if add image.
            filesInput = []
            imageInput = @manageFiles(form, 'image')

            if imageInput.files and imageInput.files.length
                filesInput.push(imageInput)

            # if got image file, ENCODE them and submit.
            if filesInput.length
                Ext.each filesInput, (input) ->
                    reader = new FileReader()
                    reader.readAsDataURL input.files[0]
                    reader.onload = (e) ->
                        record.set(input.name, 'media': e.target.result)
                        me.onSave(form, vm)

    onSave: (form, vm) ->
        if !(form.isValid() && vm.isDirty())
            @dialog.close()
            return
        form.mask('กำลังบันทึกข้อมูล ..')

        record = vm.get 'record'
        record.save
            failure: (record, o) =>
                form.unmask()
                vm.onSubmitFailure(record, form)

                if response = o.error.response
                    # internal server error
                    if response.status == 500
                        titleMessage = response.statusText

                    # sf validation error.
                    # TODO: handle form error with custom fn.
                    if response.status == 400
                        obj = Ext.decode response.responseText
                        titleMessage = obj.message

                        Ext.Object.each obj.errors.children, (key, value, item) ->
                            if value.hasOwnProperty('errors')
                                errorMessage = value.errors[0]

                @failureAlert
                    title: titleMessage || "Error!"
                    message: errorMessage || @getFailureMessage()

            success: (record, o) =>
                form.unmask()

                vm.onSubmitSuccess(record, form)
                vm.commit()

                @successAlert(@getSuccessMessage())
                @closeDialog()

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
