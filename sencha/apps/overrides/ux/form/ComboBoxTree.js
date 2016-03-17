Ext.define('Ext.ux.form.ComboBoxTree', {
    extend: 'Ext.form.field.ComboBox',
    alias: 'widget.combo-tree',

    config: {
        selfSelectAlertTitle: "Error!",
        selfSelectAlertMessage: "You cannot select itself as parent.",
        itemDisplay: null
    },

    initComponent: function()
    {
        if (!this.listConfig) {
            this.listConfig = {};
        }

        var itemDisplay = this.itemDisplay
            ? this.itemDisplay
            : Ext.String.format('{{0}}', this.displayField)
        ;

        this.listConfig.itemTpl = '<span style="padding-left: {level*20}px">' + itemDisplay + '</span>';

        this.callParent(arguments);

        this.getPicker().on('beforeitemclick', function(list, r) {
            var cb = this;

            if (cb.record && (cb.record.getId() === r.getId())) {
                Ext.Msg.alert(cb.selfSelectAlertTitle, cb.selfSelectAlertMessage);
                return false;
            }
        }, this);
    }
});
