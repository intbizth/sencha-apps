Ext.define 'Moboque.view.news.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-news'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('title')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-news-form'
            title: title
            viewModel:
                type: 'vm-news-form'
                data:
                    record: record

        @callParent([record, options])

    onUpdateState: (btn) ->
        view = @getView()
        store = @getViewModel().get('transitions')
        record = btn.getSingleWidgetRecord()

        view.mask('Waiting ...')

        store.load
            params:
                name: 'news'
                id: record.getId()
            callback: (rs, operation) =>
                view.unmask()

                if !rs.length
                    alert('can not transitions')
                    return

                dialog = view.add
                    xtype: 'wg-news-update-transition'
                    title: "News: #{record.get('title')}"
                    handlerName: 'onNewsTransitionUpdateButtonClick'
                    data: rs[0]
                    record: record

                dialog.show()

    onNewsTransitionUpdateButtonClick: (btn) ->
        dialog = btn.up('window')
        record = btn.getSingleWidgetRecord()
        store = @getViewModel().get('transitions')

        # TODO: confirmation

        store.updateState
            params:
                name: 'news'
                id: record.getId()
                transition: btn.transitionKey
            callback: (success) =>
                # reload grid
                record.store.reload()
                dialog.close()
