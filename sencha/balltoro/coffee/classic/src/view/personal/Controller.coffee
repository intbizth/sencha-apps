Ext.define 'Toro.view.personal.Controller',
    extend: 'Toro.view.base.Controller'
    alias: 'controller.ctrl-personal'

    init: -> #..

    createDialog: (record) ->
        model = @referTo('PersonalList').getStore().getModel()
        @dialog = @getView().add
            xtype: 'wg-personal-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('fullname') else 'เพิ่มบุคคลใหม่'
                    personal: record || new model()

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                beforeclose: (panel, eOpts) =>
                    if record and record.dirty
                        @showConfirmMessage
                            title: 'ข้อมูลมีการเปลี่ยนแปลง'
                            message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                            fn: (pressed) =>
                                if pressed == 'ok'
                                    record.store.rejectChanges()
                                    @dialog.close()

                        return no

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()
        @checkStoreLoadedOnForm record

    checkStoreLoadedOnForm: (record) ->
        fieldnames = ['country', 'position']
        @checkStoreLoaded(record, fieldnames)

    onAddNew: -> @createDialog()

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-personal-search'
            viewModel:
                data:
                    title: 'ค้นหาขั้นสูง'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('PersonalList').getStore()
        searchFieldValues = searchForm.getForm().getFieldValues(yes)

        if !Ext.Object.isEmpty searchFieldValues
            filters = {}

            # search
            if searchFieldValues.hasOwnProperty('search')
                filters['search'] = searchFieldValues['search']
                delete searchFieldValues['search']

            # criteria
            filters['criteria'] = searchFieldValues

            store.load
                params: filters

            @dialog.close()
            return

        @showConfirmMessage
            title: 'ค้นหา'
            message: 'คุณยังไม่ได้ระบุตัวเลือกการค้นหา ออกจากหน้า Advanced Search หรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    @dialog.close()

    onEdit: ->
        list = @referTo 'PersonalList'
        record = list.getSelection()[0]
        @createDialog record

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'PersonalList'
                    records = list.getSelection()
                    store = list.getStore()

                    list.mask('Deleting...')

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบบุคคลเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบบุคคล กรุณาลองใหม่อีกครั้งค่ะ')

    onCancel: -> @dialog.close()

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

        clubButton = @referTo('ClubButton')
        clubButton.setDisabled(selected.length != 1)

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'personal'

        filesInput = []

        # image field
        imageInput = @manageFiles(form, 'image')

        if imageInput.files and imageInput.files.length
            filesInput.push(imageInput)

        if filesInput.length
            @fileReader(filesInput, record)
        else
            @save(record)

    fileReader: (inputfiles, record) ->
        me = @

        Ext.each inputfiles, (input, index) ->
            reader = new FileReader()
            reader.readAsDataURL input.files[0]

            reader.onload = (e) ->
                record.set(input.name, 'media': e.target.result)

                if index == (inputfiles.length - 1)
                    me.save(record)

    save: (record) ->
        form = @dialog.down 'form'
        store = @referTo('PersonalList').getStore()
        isNewRecord = record.phantom
        fieldsChanged = record.getChanges()

        imageUpdated = fieldsChanged.hasOwnProperty('image')

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการบุคคล กรุณาลองใหม่อีกครั้งค่ะ'

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
                        @alertSuccess('เพิ่มบุคคลเรียบร้อยแล้ว')

                    else
                        if imageUpdated
                            record.load()

                        @alertSuccess('แก้ไขบุคคลเรียบร้อยแล้ว')

                    @dialog.close()
        else
            @dialog.close()

    setImagePreview: (imageComponent) ->
        ref = imageComponent.getReference().toLowerCase()
        name = ref.replace('ref', '')

        if image = @getDataInModel(name)
            imageComponent.setSrc(image.media.url)

    getDataInModel: (fieldName) ->
        record = @dialog.getViewModel().get 'personal'
        return record.get(fieldName)

    imageUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refImage')

    manageImagePath: (field, value, ref) ->
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))

        thumbnail = field.up().lookupReference(ref)
        thumbnail.setSrc('')

    selectPersonalType: (combo, record) ->
        form = @dialog.down 'form'
        positionCombo = form.getForm().findField('position')
        positionStore = positionCombo.getStore()

        personalType = combo.getValue()

        if Ext.isString personalType
            positionStore.load
                params:
                    criteria:
                        type: personalType

    onClubClick: ->
        record = @getPersonalSelection()
        @dialog = @getView().add
            xtype: 'wg-personal-club-list'
            viewModel:
                data:
                    title: 'รายละเอียด :   ' + record.get('fullname')

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @showGridsClub(record)
        @dialog.show()

    showGridsClub: (personalRecord) ->
        clubPersonalList = @referTo('ClubPersonalList')
        clubPersonalListsStore = clubPersonalList.getStore()

        clubPersonalListsStore.load
            params:
                criteria:
                    personal: personalRecord.get 'id'
            callback: (records, operation, success) ->
                if Ext.isArray records
                    Ext.each records, (record) ->
                        record.commit()

    getPersonalSelection: ->
        list = @referTo 'PersonalList'
        return list.getSelection()[0]
