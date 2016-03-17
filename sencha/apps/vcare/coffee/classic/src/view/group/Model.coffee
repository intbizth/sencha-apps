Ext.define 'Vcare.view.group.Model',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-group'

    isDirty: -> @get('groups').getModifiedRecords().length

    reject: -> @get('groups').rejectChanges()

    createRecord: ->
        new (@data.groups.getModel())()

