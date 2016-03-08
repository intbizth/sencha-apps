Ext.define('Ext.form.Translation', {
    extend: 'Ext.form.FieldContainer',
    alias: 'widget.fieldtranslation',

    combineErrors: true,
    msgTarget: 'side',
    layout: 'hbox',

    defaults: {
        hideLabel: true,
        margin: '0 5 0 0'
    },

    config: {
        locales: null,
        locale: null,
        itemType: 'textfield',
        itemKey: null,
        itemConfig: {}
    },

    publishes: {
        locale: true,
        locales: true
    },

    updateLocales: function(n, o)
    {
        var me = this,
            items = []
        ;

        me.add(me.createComboBox(n));

        n.each(function(locale) {
            code = locale.getCode();
            console.log('{translations.' + code + '.' + me.itemKey + '}');

            items.push(Ext.merge({
                xtype: me.getItemType(),
                flex : 1,
                allowBlank: false,
                hidden: true,
                itemId: me.getItemName(code),
                translatableItem: 'yes',
                bind: {
                    value: '{translations.' + code + '.' + me.itemKey + '}'
                }
            }, me.getItemConfig()));
        });

        me.add(items);

        me.updateLayout();
    },

    updateLocale: function(n, o)
    {
        // need to bind locales before this.
        this.down('combo').setValue(n);
        this.getItemByLocale(n).setHidden(false);
    },

    createComboBox: function(store)
    {
        var me = this;

        return Ext.create({
            width: 100,
            xtype: 'combo',
            queryMode: 'local',
            triggerAction: 'all',
            forceSelection: true,
            editable: false,
            displayField: 'code',
            valueField: 'code',
            store: store,
            listeners: {
                change: function(cm, nValue, oValue) {
                    var i, item, founds = me.query('[translatableItem=yes]'),
                        nameMatched = me.getItemName(nValue)
                    ;

                    for(i = 0; i < founds.length; i++) {
                        item = founds[i];
                        item.setHidden(item.getItemId() !== nameMatched)
                    }
                }
            }
        });
    },

    getItemName: function(locale)
    {
        return 'item-' + locale + '-' + this.getItemKey();
    },

    getItemByLocale: function(locale)
    {
        return this.down('#' + this.getItemName(locale));
    },
});
