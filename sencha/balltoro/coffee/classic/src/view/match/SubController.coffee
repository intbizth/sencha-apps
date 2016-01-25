Ext.define 'Toro.view.match.SubController',
    extend: 'Toro.view.match.Controller'
    alias: 'controller.ctrl-sub-match'

    getPlayersStore: (side) ->
        personalsStoreId = side + '-players-store'
        return Ext.getStore(personalsStoreId)

    getHomeClub: ->
        if record = @getView().getViewModel().get 'match'
            return record.getHomeClub()
        return

    getAwayClub: ->
        if record = @getView().getViewModel().get 'match'
            return record.getAwayClub()
        return

    cancelEditRecord: (editor, context) ->
        record = context.record

        if record.phantom
            context.store.remove(record)

    onDeleteRecord: (button, message) ->
         @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = button.up 'grid'
                    list.mask('Deleting...')

                    store = list.getStore()
                    recordSelected = list.getSelection()[0]

                    if !recordSelected
                        @alertFailure('กรุณาเลือก' + message + 'ที่ต้องการลบก่อนค่ะ')
                        return

                    store.deletes [recordSelected],
                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบ' + message + 'เรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบ' + message + ' กรุณาลองใหม่อีกครั้งค่ะ')
