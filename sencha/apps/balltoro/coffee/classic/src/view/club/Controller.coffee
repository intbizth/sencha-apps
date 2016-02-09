Ext.define 'Balltoro.view.club.Controller',
    extend: 'Balltoro.view.base.Controller'
    alias: 'controller.ctrl-club'

    init: -> # ..

    createDialog: (record) ->
        model = @referTo('ClubList').getStore().getModel()
        @dialog = @getView().add
            xtype: 'wg-club-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('name') else 'เพิ่มสโมสรใหม่'
                    club: record || new model()

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
        fieldnames = ['country', 'clubClass']
        @checkStoreLoaded(record, fieldnames)

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-club-search'
            viewModel:
                data:
                    title: 'ค้นหาขั้นสูง'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('ClubList').getStore()
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

    onAddNew: -> @createDialog()

    onSelectionChange: (eOpts, selected) ->
        @enabledButtonWithSelection('EditButton', selected.length != 1)
        @enabledButtonWithSelection('PersonalCurrentButton', selected.length != 1)
        @enabledButtonWithSelection('PersonalPreviousButton', selected.length != 1)
        @enabledButtonWithSelection('DeleteButton', !selected.length)

    onEdit: ->
        @createDialog @getClubSelection()

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'ClubList'
                    records = list.getSelection()
                    store = list.getStore()

                    list.mask('Deleting...')

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบสโมสรเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบสโมสร กรุณาลองใหม่อีกครั้งค่ะ')

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'club'

        filesInput = []

        stadiumImageInput = @manageFiles(form, 'stadium_image')

        if stadiumImageInput.files and stadiumImageInput.files.length
            filesInput.push(stadiumImageInput)

        logoInput = @manageFiles(form, 'logo')

        if logoInput.files and logoInput.files.length
            filesInput.push(logoInput)

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
        store = @referTo('ClubList').getStore()
        isNewRecord = record.phantom
        fieldsChanged = record.getChanges()

        stadiumImageUpdated = fieldsChanged.hasOwnProperty('stadium_image')
        logoUpdated = fieldsChanged.hasOwnProperty('logo')

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการสโมสร กรุณาลองใหม่อีกครั้งค่ะ'

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
                        @alertSuccess('เพิ่มสโมสรเรียบร้อยแล้ว')

                    else
                        if stadiumImageUpdated or logoUpdated
                            record.load()

                        @alertSuccess('แก้ไขสโมสรเรียบร้อยแล้ว')

                    @dialog.close()
        else
            @dialog.close()

    setImagePreview: (imageComponent) ->
        ref = imageComponent.getReference().toLowerCase()
        name = ref.replace('ref', '')

        if name == 'stadiumimage'
            name = 'stadium_image'

        if image = @getDataInModel(name)
            imageComponent.setSrc(image.media.url)

    getDataInModel: (fieldName) ->
        record = @dialog.getViewModel().get 'club'
        return record.get(fieldName)

    stadiumImageUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refStadiumImage')

    logoUploadChanged: (field, value) ->
        @manageImagePath(field, value, 'refLogo')

    manageImagePath: (field, value, ref) ->
        field.setRawValue(value.replace(/C:\\fakepath\\/g, ''))

        thumbnail = field.up().lookupReference(ref)
        thumbnail.setSrc('')

    onPersonalCurrentClick: ->
        record = @getClubSelection()

        @dialog = @getView().add
            xtype: 'wg-club-personal-currentlist'
            viewModel:
                data:
                    title: 'จัดการนักเตะปัจจุบัน :   ' + record.get('name')
                    club: record
            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                show: =>
                    @dialog.getController().showGridsCurrentPersonal(record)

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    onPersonalPreviousClick: ->
        record = @getClubSelection()

        @dialog = @getView().add
            xtype: 'wg-club-personal-previous-list'
            viewModel:
                data:
                    title: 'รายละเอียดนักเตะก่อนหน้า :   ' + record.get('name')
                    club: record
            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                show: =>
                    @dialog.getController().showGridsPreviousPersonal(record)

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    getClubSelection: ->
        list = @referTo 'ClubList'
        return list.getSelection()[0]
