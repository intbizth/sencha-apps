Ext.define 'Vcare.view.product.form.CategorizationView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-categorization'

    layout:
        type: 'vbox'

    defaults:
        width : '100%'
        labelAlign: 'top'

    items: [
        xtype: 'combobox'
        fieldLabel: 'Main taxon'
        required: yes
        displayField: 'code'
        valueField: 'id'
        queryMode: 'local'
        store: [1, 2, 3]
        margin: '10 10 0 10'
		# bind:
    	# 	store: '{taxons}'
    ,
        xtype: 'tagfield'
        fieldLabel: 'Taxons'
        displayField: 'code'
        valueField: 'id'
        createNewOnEnter: no
        queryMode: 'local'
        store: [1, 2, 3]
        margin: '10 10 0 10'
    ]
