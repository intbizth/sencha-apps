Ext.define('Ext.overrides.panel.Panel', {
    override: 'Ext.panel.Panel',

    /**
     * {@link https://www.sencha.com/forum/showthread.php?304158-Ext.panel.Panel.fireDefaultButton()-No-component-found-for-defaultButton-reference&p=1113820#post1113820}
     */
    lookupReferenceHolder: function(skipThis) {
        return this.getInheritedConfig('referenceHolder', skipThis === true) || null;
    }
});
