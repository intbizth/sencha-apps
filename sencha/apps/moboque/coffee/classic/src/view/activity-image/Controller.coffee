Ext.define 'Moboque.view.activity-image.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-activity-image'

    init: -> #..

    onCancel: -> @dialog.close()
    onAddNew: -> @baseCreateDialog({xType: 'wg-activity-image-form', vmType: 'vm-activity-image-form'})
    onEdit: -> @baseCreateDialog({xType: 'wg-activity-image-form', vmType: 'vm-activity-image-form', refer: 'ActivityImageList', title : 'title'})
    onDelete: -> @baseDelete('ActivityImageList')
    onSubmit: -> @baseSubmit('ActivityImageList', hasImage: yes)

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
