Ext.define('Ext.overrides.app.ViewController', {
    override: 'Ext.app.ViewController',

    referTo: function(name) {
        return this.getReferences()['ref' + name];
    }
});
