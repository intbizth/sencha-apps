Ext.define('Ext.overrides.button.Button', {
    override: 'Ext.button.Button',

    config: {
        aclCheck: true
    },

    updateAclCheck: function(rs)
    {
        // TODO: user permission
        if (Ext.isArray(rs)) {
            this.setDisabled(!rs.length);
        } else {
            this.setDisabled(!rs);
        }
    }
});
