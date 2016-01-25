Ext.define 'Toro.view.news.Controller',
    extend: 'Toro.view.base.Controller'
    alias: 'controller.ctrl-news'

    init: -> # ..

    createDialog: (record) ->
        model = @referTo('NewsList').getStore().getModel()
        scope = @
        @dialog = @getView().add
            xtype: 'wg-news-form'
            viewModel:
                getNewsPublishedDate: -> @get('news').get('published_date')
                setNewsPublishedDate: (date, time) ->
                    originDate = @getNewsPublishedDate()
                    date = scope.setDateTimeInRecord(originDate, date, time)

                    @get('news').set 'published_date', date
                    return

                data:
                    title:  if record then 'แก้ไข: ' + record.get('headline') else 'เพิ่มข่าวใหม่'
                    news: record || new model()

                formulas:
                    publishedDate:
                        get: -> @getNewsPublishedDate()
                        set: (date) -> @setNewsPublishedDate(date, null)

                    publishedTime:
                        get: -> @getNewsPublishedDate()
                        set: (time) -> @setNewsPublishedDate(null, time)

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

    getDataInModel: (fieldName) ->
        record = @dialog.getViewModel().get 'news'
        return record.get(fieldName)

    ## on toolbar clicked or selection model is working. ##
    onAddNew: -> @createDialog()

    onEdit: ->
        list = @referTo 'NewsList'
        record = list.getSelection()[0]
        @createDialog record

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'NewsList'
                    records = list.getSelection()
                    store = list.getStore()

                    list.mask('Deleting...')

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบข่าวเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบข่าว กรุณาลองใหม่อีกครั้งค่ะ')

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

        hottestButton = @referTo('HottestButton')
        hottestButton.setDisabled(!selected.length)
        hottestButton.toggle(selected.length == 1 and selected[0].get 'hottest')

        featuredButton = @referTo('FeaturedButton')
        featuredButton.setDisabled(!selected.length)
        featuredButton.toggle(selected.length == 1 and selected[0].get 'featured')

        # 1. ถ้าเลือก record เดียว สามารถเพิ่ม หรือลบ จาก hottest และ featured ได้
        # 2. ถ้าเลือกมากกว่า 1 record สามารถเปลี่ยนเป็น isHottest หรือ isFeatured ได้
        # 3. ถ้าไม่เลือก disable //

    selectFeatured: ->
        @enabledState('NewsList', 'featured', 'ข่าวแนะนำ', 'FeaturedButton')

    selectHottest: ->
        @enabledState('NewsList', 'hottest', 'ข่าวร้อน', 'HottestButton')

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-news-search'
            viewModel:
                data:
                    title: 'ค้นหาขั้นสูง'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('NewsList').getStore()
        searchFieldValues = searchForm.getForm().getFieldValues(yes)

        if !Ext.Object.isEmpty searchFieldValues
            filters = {}

            # search
            if searchFieldValues.hasOwnProperty('search')
                filters['search'] = searchFieldValues['search']
                delete searchFieldValues['search']

            if searchFieldValues.hasOwnProperty('enddate')
                searchFieldValues.enddate = Ext.Date.format(searchFieldValues.enddate, 'Y-m-d')

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

    ## about submit data ##
    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'news'

        filesInput = []

        # image field
        imageInput = @manageFiles(form, 'image')

        if imageInput.files and imageInput.files.length
            filesInput.push(imageInput)

        # cover field
        coverInput = @manageFiles(form, 'cover')

        if coverInput.files and coverInput.files.length
            filesInput.push(coverInput)

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
        store = @referTo('NewsList').getStore()
        isNewRecord = record.phantom
        fieldsChanged = record.getChanges()

        imageUpdated = fieldsChanged.hasOwnProperty('image')
        coverUpdated = fieldsChanged.hasOwnProperty('cover')

        # content // TODO use bind
        contentField = form.getForm().findField('content')
        extraContentField = form.getForm().findField('extraContent')

        if content = contentField.getValue()
            record.set 'content', content

        if extraContent = extraContentField.getValue()
            record.set 'extra_content', extraContent

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
                        if imageUpdated or coverUpdated
                            record.load()

                        @alertSuccess('แก้ไขข่าวเรียบร้อยแล้วค่ะ')

                    @dialog.close()
        else
            @dialog.close()

    ## on object clicked. ##
    selectTransitions: (button) ->
        record = button.getWidgetRecord()
        transitions = record.get('transitions')
        list = @referTo('NewsList')

        # support object, array and string
        menus = @createTransitionMenu transitions, (btn) =>
            if transition = btn.value
                list.mask('Updating...')

                # route_api_news_update_transition
                path = record.get('id') + '/' + transition + '/update-state'

                record.manageUpdateRecord record, path,
                    callback: (opts, success, response) =>

                    success: (response, opts) =>
                        record.load
                            failure: =>
                                console.error 'refresh failed try again'

                            success: (record, operation) =>
                                list.unmask()
                                @alertSuccess('จัดการข่าวเรียบร้อยแล้วค่ะ')

                    failure: (response, opts) =>
                        list.unmask()
                        @alertFailure('ขออภัย! เกิดปัญหาขณะจัดการข่าว กรุณาลองใหม่อีกครั้งค่ะ')

        button.setMenu(menus, true)

    selectCompetition: (object, record) ->
        form = @dialog.down 'form'
        seasonsCombo = form.getForm().findField('season')
        seasonsStore = seasonsCombo.getStore()

        if record
            seasonsStore.clearFilter yes
            seasonsStore.filter 'competition', record
        else
            seasonsStore.clearFilter()

    onClickImage: (e, t, eOpts) ->
        if image = @getDataInModel('image')
            console.log t.src
            # TODO open lightbox

    ## set data with renderer. ##
    onContentBeforeRender: (field) ->
        if content = @getDataInModel('content')
            field.setValue(content)

    onExtraContentBeforeRender: (field) ->
        if extraContent = @getDataInModel('extra_content')
            field.setValue(extraContent)

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

    checkStoreLoadedOnForm: (record) ->
        fieldnames = ['competition', 'season', 'tags']

        # related_clubs was queryMode: 'remote'
        # ถ้า record ไม่มี related_clubs จะไม่ถูกโหลด
        if record? and record.get('related_clubs').length
            fieldnames.push 'related_clubs'

        @checkStoreLoaded(record, fieldnames)

    onManageCategories: ->
        @dialog = @getView().add
            xtype: 'wg-news-categorylist'

        @dialog.show()

    onAddCategory: ->
        categoryList = @lookupReference('refCategoryList')
        categoriesStore = categoryList.getStore()

        newRecord = Ext.create 'Toro.model.NewsCategory',
            code: ''
            name: ''
            type: 'news'
            enabled: no

        categoriesStore.insert(categoriesStore.getCount(), newRecord)
        categoryList.findPlugin('rowediting').startEdit(newRecord)

    updateCategoryRecord: (editor, context) ->
        record = context.record
        grid = context.grid

        if record.dirty
            grid.mask('submitting...')
            record.save
                success: (record) =>
                    grid.unmask()
                    @alertSuccess('แก้ไขหมวดหมู่ข่าวเรียบร้อยแล้วค่ะ')
                failure: =>
                    grid.unmask()
                    @alertFailure('ขออภัย! เกิดปัญหาขณะแก้ไขหมวดหมู่ข่าว กรุณาลองใหม่อีกครั้งค่ะ')

    onDeleteCategoryRecord: (button) ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    categoryList = button.up 'grid'
                    categoryList.mask('Deleting...')

                    categoriesStore = categoryList.getStore()
                    recordSelected = categoryList.getSelection()[0]

                    if !recordSelected
                        @alertFailure('กรุณาเลือกหมวดหมู่ข่าวที่ต้องการลบก่อนค่ะ')
                        return

                    categoriesStore.deletes [recordSelected],
                        success: (records, store) =>
                            categoryList.unmask()
                            @alertSuccess('ลบหมวดหมู่ข่าวเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            categoryList.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบหมวดหมู่ข่าว กรุณาลองใหม่อีกครั้งค่ะ')

    cancelEditCategoryRecord:(editor, context) ->
        record = context.record

        if record.phantom
            context.store.remove(record)
