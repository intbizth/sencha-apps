Ext.define 'Vcare.view.channel.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-channel-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'hbox'
        bodyPadding: 10

        defaults:
            xtype: 'container'
            layout: 'anchor'

        fieldDefaults:
            labelAlign: 'top'
            anchor : '100%'

        items: [{
            flex: 1
            margin: '0 20 0 0'
            items: [
                xtype: 'textfield'
                fieldLabel: 'Code'
                required: no
                bind:
                    value: '{record.code}'
                    disabled: '{!record.phantom}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Hostname'
                required: yes
                bind: '{record.hostname}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Name'
                required: yes
                bind: '{record.name}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Description'
                required: no
                bind: '{record.description}'
            ,
                xtype: 'textfield'
                fieldLabel: 'Color'
                required: no
                bind: '{record.color}'
            ,
                xtype: 'checkboxfield'
                boxLabel: 'เปิดการใช้งาน '
                bind: '{record.enabled}'
            ]
        }, {
            flex: 2
            items: [
                xtype: 'tagfield'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Categories'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{taxonomies}'
                    selection: '{selectedTaxonomies}'
            ,
                xtype: 'tagfield'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Shipping Methods'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{shipping-methods}'
                    selection: '{selectedShippingMethods}'
            ,
                xtype: 'tagfield'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Payment Methods'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{payment-methods}'
                    selection: '{selectedPaymentMethods}'
            ,
                xtype: 'tagfield'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Currencies'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{currencies}'
                    selection: '{selectedCurrencies}'
            ,
                xtype: 'combobox'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Default Currency'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{currencies}'
                    selection: '{record.default_currency}'
            ,
                xtype: 'tagfield'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Locales'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{locales}'
                    selection: '{selectedLocales}'
            ,
                xtype: 'combobox'
                queryMode: 'local'
                triggerAction: 'all'
                fieldLabel: 'Default Locale'
                required: yes
                editable: yes
                displayField: 'name'
                valueField: 'id'
                bind:
                    store: '{locales}'
                    selection: '{record.default_locale}'
            ]
        }]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
