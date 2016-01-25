Ext.define 'Toro.view.season.Controller',
    extend: 'Toro.view.base.Controller'
    alias: 'controller.ctrl-season'

    init: -> # ..

    createDialog: (record) ->
        model = @referTo('SeasonList').getStore().getModel()
        @dialog = @getView().add
            xtype: 'wg-season-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('name') else 'เพิ่มฤดูกาลใหม่'
                    season: record || new model()

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
        fieldnames = ['competition']

        if record? and record.get('club_members').length
            fieldnames.push 'club_members'

        @checkStoreLoaded(record, fieldnames)

    onAddNew: -> @createDialog()

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

    onEdit: ->
        list = @referTo 'SeasonList'

        @createDialog list.getSelection()[0]

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'SeasonList'
                    records = list.getSelection()
                    store = list.getStore()

                    list.mask('Deleting...')

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบฤดูกาลเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบฤดูกาล กรุณาลองใหม่อีกครั้งค่ะ')

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'season'
        store = @referTo('SeasonList').getStore()
        isNewRecord = record.phantom

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการฤดูกาล กรุณาลองใหม่อีกครั้งค่ะ'

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
                        @alertSuccess('เพิ่มฤดูกาลเรียบร้อยแล้ว')

                    else
                        @alertSuccess('แก้ไขฤดูกาลเรียบร้อยแล้ว')

                    @dialog.close()
        else
            @dialog.close()

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-season-search'
            viewModel:
                data:
                    title: 'ค้นหาขั้นสูง'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('SeasonList').getStore()
        searchFieldValues = searchForm.getForm().getFieldValues(yes)

        if !Ext.Object.isEmpty searchFieldValues
            filters = {}

            # search
            if searchFieldValues.hasOwnProperty('search')
                filters['search'] = searchFieldValues['search']
                delete searchFieldValues['search']

            if searchFieldValues.hasOwnProperty('startDate')
                searchFieldValues.startDate = Ext.Date.format(searchFieldValues.startDate, 'Y-m-d')

            if searchFieldValues.hasOwnProperty('endDate')
                searchFieldValues.endDate = Ext.Date.format(searchFieldValues.endDate, 'Y-m-d')

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
