Ext.define 'Vcare.view.taxon.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-taxon'

    stores:
        taxonomies:
            type: 'store-taxonomies'
            autoLoad: yes
            pageSize: no

        taxons:
            type: 'store-taxons'
            autoLoad: no
            pageSize: no

    isRootType: (type) -> type == 'root'
    getStoreByType: (type) -> if @isRootType(type) then 'taxonomies' else 'taxons'

    createRecord: (record, type) ->
        return record if record

        return new (@data[@getStoreByType(type)].getModel({
            current_locale: @get('defaultLocale')
        }))()
