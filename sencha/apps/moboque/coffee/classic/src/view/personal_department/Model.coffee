Ext.define 'Moboque.view.personal_department.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-personal-department'

    stores:
        personalDepartments:
            type: 'store-personal-departments'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.personalDepartments.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
