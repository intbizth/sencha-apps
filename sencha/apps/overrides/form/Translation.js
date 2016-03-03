Ext.define('Ext.form.Translation', {
    extend: 'Ext.form.FieldContainer',
    alias: 'widget.fieldtranslation',

    combineErrors: true,
    msgTarget: 'side',
    layout: 'hbox',

    config: {
        locales: null,
        locale: null,
        itemType: 'textfield',
        itemKey: null,
        itemConfig: {}
    },

    defaults: {
        hideLabel: true,
        margin: '0 5 0 0'
    },

    getItemName: function(locale) {
        return 'item-' + locale + '-' + this.getItemKey();
    },

    getItemByLocale: function(locale) {
        return this.down('#' + this.getItemName(locale));
    },

    initComponent: function() {

        var locales = [],
            items = [],
            data = {},
            me = this,
            binds = me.getBind(),
            code = null
        ;

        if (binds.locales) {
            me.setLocales(binds.locales.getValue());
        }

        if (binds.locale) {
            me.setLocale(binds.locale.getValue());
        }

        me.locales.each(function(locale) {
            code = locale.getCode();
            locales.push({name: locale.getName(), value: code});

            items.push(Ext.merge({
                xtype: me.getItemType(),
                flex : 1,
                allowBlank: false,
                hidden: me.locale !== code,
                itemId: me.getItemName(code),
                translatableItem: 'yes',
                bind: {
                    value: '{translations.' + code + '.' + me.itemKey + '}'
                }
            }, me.getItemConfig()));
        });

        var combo = {
            width: 100,
            xtype: 'combo',
            queryMode: 'local',
            value: me.locale,
            triggerAction: 'all',
            forceSelection: true,
            editable: false,
            displayField: 'name',
            valueField: 'value',
            store: {
                fields: ['name', 'value'],
                data: locales
            },
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
        };

        this.items = Ext.Array.merge([combo], items);

        this.callParent(arguments);
    }
});
