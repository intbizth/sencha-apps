Ext.define 'Vcare.view.product.form.CategorizationView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-categorization'

    layout:
        type: 'vbox'

    defaults:
        width: '100%'
        labelAlign: 'top'

    items: [
        xtype: 'combobox'
        fieldLabel: 'Main taxon'
        displayField: 'code'
        valueField: 'id'
        queryMode: 'local'
        triggerAction: 'all'
        margin: '10 10 0 10'
        bind:
            store: '{taxonomies}'
            selection: '{record.main_taxon}'
        # todo all taxons
    ]
