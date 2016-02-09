Ext.define 'Balltoro.view.country.Controller',
    extend: 'Balltoro.view.base.Controller'
    alias: 'controller.ctrl-country'

    init: -> #..

    createDialog: (record) ->
        model = @referTo('CountryList').getStore().getModel()
        @dialog = @getView().add
            xtype: 'wg-country-form'
            viewModel:
                data:
                    title:  if record then 'แก้ไข: ' + record.get('name') else 'เพิ่มประเทศใหม่'
                    country: record || new model()

            listeners:
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

        @dialog.show()

    onAddNew: -> @createDialog()

    onEdit: ->
        list = @referTo 'CountryList'
        @createDialog list.getSelection()[0]

    onSelectionChange: (eOpts, selected) ->
        editButton = @referTo('EditButton')
        editButton.setDisabled(selected.length != 1)

        removeButton = @referTo('DeleteButton')
        removeButton.setDisabled(!selected.length)

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'CountryList'
                    records = list.getSelection()
                    store = list.getStore()

                    list.mask('Deleting...')

                    store.deletes records,
                        callback: (records, store, isSuccess) =>

                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบข้อมูลประเทศเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบประเทศ กรุณาลองใหม่อีกครั้งค่ะ')

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'country'
        store = @referTo('CountryList').getStore()
        isNewRecord = record.phantom

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการประเทศ กรุณาลองใหม่อีกครั้งค่ะ'

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
                        @alertSuccess('เพิ่มข้อมูลประเทศเรียบร้อยแล้วค่ะ')

                    else
                        @alertSuccess('แก้ไขข้อมูลประเทศเรียบร้อยแล้วค่ะ')

                    @dialog.close()
        else
            @dialog.close()
