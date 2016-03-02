Ext.define 'Moboque.view.meet.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-meet-form'

     formulas:
         isPhantom:
             get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    # commit: ->
    #     @get('record').commit(); @get('record.user').commit()

    # reject: ->
    #     @get('record').reject()
