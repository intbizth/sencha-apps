Ext.define 'Vcare.view.taxonomy.Controller',
    extend: 'Vcare.view.base.Controller'
    alias: 'controller.ctrl-taxonomy'

    init: -> #..

    onTaxonomySelectionChange: (sm, rs) ->
        vm = @getViewModel()
        taxons = vm.get('taxons')

        if !rs.length
            # need to commit?
            taxons.removeAll(yes)
        else
            taxons.load
                params: taxonomy: rs[0].getId()

    # @private
    createTaxonomyDialog: (record) ->
        vm = @getViewModel()
        record = vm.prepareTaxonomyData(record)

        console.log(record)
        console.log(record)

        @dialog = @getView().add
            xtype: 'wg-taxonomy-form'
            ownerView: @getView()
            viewModel:
                type: 'vm-taxonomy-form'
                data:
                    title:  record.getFormTitle()
                    record: record
                    currentLocale: 'en_US'

        @dialog.show()

    onAddNewTaxonomy: ->
        @createTaxonomyDialog()

