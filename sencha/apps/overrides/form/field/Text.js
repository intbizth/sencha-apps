Ext.define('Ext.overrides.form.field.Text', {
    override: 'Ext.form.field.Text',

    // http://stackoverflow.com/questions/31814070/extjs-5-bind-to-other-class-properties-like-allowblank
    config: {
        required: false
    },

    updateRequired: function(val) {
        this.allowBlank = !(this.required = val);
    }
});
