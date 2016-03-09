Ext.define('Ext.overrides.form.field.ComboBox', {
    override: 'Ext.form.field.ComboBox',

    config: {
        // for now using for tree-form want to know own record
        // our use-case is: when edit record, the record should no select itself as parent.
        record: null
    }
});
