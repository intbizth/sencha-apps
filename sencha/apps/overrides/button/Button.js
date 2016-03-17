Ext.define('Ext.overrides.button.Button', {
    override: 'Ext.button.Button',

    config: {
        aclCheck: false,
        widgetRecord: null
    },

    constructor: function(config)
    {
        if (config && config.iconCls && (/^fa /.test(config.iconCls))) {
            console.warn('Please config button.iconCls without `fa fa-` for ' + config.iconCls);
        }

        if (config && config.iconCls && !(/^x-/.test(config.iconCls))) {
            config.iconCls = 'fa fa-' + config.iconCls;
        }

        this.callParent([config]);
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
        var disabled = false;

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
