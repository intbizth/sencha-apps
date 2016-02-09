// # IE8 has an odd bug with handling font icons in pseudo elements;
// # it will render the icon once and not update it when something
// # like text color is changed via style addition or removal.
// # We have to force icon repaint by adding a style with forced empty
// # pseudo element content, (x-sync-repaint) and removing it back to work
// # around this issue.
// # See this: https://github.com/FortAwesome/Font-Awesome/issues/954
// # and this: https://github.com/twbs/bootstrap/issues/13863

Ext.define('Ext.overrides.menu.Item', {
    override: 'Ext.menu.Item',

    // only activate this override on IE8
    compatibility: 'IE@8',

    onFocus: function(e) {
        this.callParent([e]);
        this.repaintFontIcons();
    },

    onFocusLeave: function(e) {
        this.callParent([e]);
        this.repaintFontIcons();
    },

    privates: {
        repaintFontIcons: function() {
            var fly;

            // This application uses font icons on some elements that the framework
            // does not expect, so we have to extend its normal IE8 workarounds
            if (this.itemEl && this.el.hasCls('font-icon')) {
                this.itemEl.syncRepaint();
            }

            if (this.textEl) {
                fly = Ext.fly(this.textEl.dom.firstChild);
            }

            if (fly && fly.hasCls(Ext.baseCSSPrefix + 'fa')) {
                fly.syncRepaint();
            }
        }
    }
});
