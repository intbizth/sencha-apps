Ext.define 'Moboque.view.member.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-member-form'

    stores:
        groups:
            type: 'store-groups'
            autoLoad: yes
            pageSize: 25

    formulas:
    	group:
            get: ->
                @get('record').getGroup()

            set: (val) ->
                @get('record').setGroup val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        groupId = @get('record').getPrevious('group_id')

        if groupId
            @get('record').setGroup @get('groups').getById(groupId)
            record.commit()
