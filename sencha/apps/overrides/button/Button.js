Ext.define('Ext.overrides.button.Button', {
    override: 'Ext.button.Button',

    config: {
        aclCheck: false,
        widgetRecord: null
    },

    getSingleWidgetRecord: function()
    {
        var rs = this.getWidgetRecord();

        if (rs) {
            if (Ext.isArray(rs)) {
                return rs[0];
            }

            return rs;
        }

        return null;
    },

    updateWidgetRecord: function(rs) {
        if (this.getAclCheck()) {
            this.checkAcl(rs);
        }
    },

    checkAcl: function(rs)
    {
        disabled = false

        // TODO: user permission
        if (Ext.isArray(rs)) {
            disabled = !rs.length
        } else {
            disabled = !rs
        }

        if (false === disabled && Ext.isFunction(this.getAclCheck())) {
            disabled = !this.getAclCheck().call(this, disabled);
        }

        this.setDisabled(disabled)
    },

    initComponent: function()
    {
        this.callParent(arguments);

        if (this.getAclCheck()) {
            this.checkAcl();
        }
    }
});
