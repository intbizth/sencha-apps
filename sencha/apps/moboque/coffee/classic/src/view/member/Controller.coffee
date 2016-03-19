Ext.define 'Moboque.view.member.Controller',
    extend: 'Moboque.view.base.Controller'
    alias: 'controller.ctrl-member'

    createDialog: (record) ->
        vm = @getViewModel()
        title = if !record then 'เพิ่มรายการใหม่' else "แก้ไข #{record.get('fullname')}"
        record = vm.prepareData(record)

        options =
            xtype: 'wg-member-form'
            title:  title
            viewModel:
                type: 'vm-member-form'
                data:
                    record: record

        @callParent([record, options])
