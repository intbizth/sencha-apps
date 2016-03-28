Ext.define 'Vcare.view.group.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-group-form'

    width: 400
    height: 500
    fullsize: no
    closable: yes

    title: 'Groups'

    viewModel:
        type: 'vm-group'

    controller: 'ctrl-group'

    items:
        xtype: 'grid'
        headerBorders: no
        reference: 'refGroupList'

        bind:
            store: '{groups}'

        viewConfig:
            preserveScrollOnRefresh: yes
            preserveScrollOnReload: yes
            emptyText: 'Empty Data'

        plugins:
            ptype: 'rowediting'
            pluginId: 'rowediting'
            clicksToEdit: 1
            listeners:
                cancelEdit: 'onCancelEdit'
                edit: 'onSubmit'

        columns: [
            text: 'Name'
            flex: 1
            dataIndex: 'name'
            field:
                xtype: 'textfield'
        ]

        tbar:
            items: [
                text: 'Add New'
                iconCls: 'plus'
                handler: 'onAddNew'
            ,
                text: 'Remove'
                iconCls: 'trash-o'
                bind: widgetRecord: '{refGroupList.selection}'
                handler: 'onDelete'
                aclCheck: -> !@widgetRecord.phantom
        ]
