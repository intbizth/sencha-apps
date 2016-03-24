Ext.define 'Moboque.view.personal-department.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-personal-department'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-personal-department-form'
            title:  title
            viewModel:
                type: 'vm-personal-department-form'
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
            imageInput = @manageFiles(form, 'thumbnail')

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

    setImagePreview: (imageComponent) ->
        record = @dialog.getViewModel().get 'record'

        if thumbnail = record.get 'thumbnail'
            imageComponent.setSrc(thumbnail.media.url)
        else
            imageComponent.setSrc('http://dummyimage.com/300x200/757575/242424.png&text=Image+Here')

    imageUploadChanged: (field, value) ->
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))
