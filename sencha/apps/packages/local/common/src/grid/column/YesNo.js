Ext.define('Ext.common.grid.column.YesNo', {
    extend: 'Ext.grid.column.Column',
    alias: ['widget.yesnocolumn'],

    defaultFilterType: 'boolean',

    config: {
        yesText: 'Yes',
        noText: 'No'
    },

    /**
     * @cfg {Object} renderer
     * @hide
     */

    /**
     * @cfg {Object} scope
     * @hide
     */

    /**
     * @cfg {Boolean} producesHTML
     * @inheritdoc
     */
    producesHTML: false,

    defaultRenderer: function(value) {
        return Ext.String.format(
            '<div class="x-grid-column-yesno">' +
                (value ? '<span class="x-grid-column-yesno-yes">{0}</span>' : '') +
                (!value ? '<span class="x-grid-column-yesno-no">{0}</span>' : '') +
            '</div>'
            , value ? this.yesText : this.noText
        );
    },

    updater: function(cell, value) {
        Ext.fly(cell).down(this.getView().innerSelector, true).innerHTML = Ext.common.grid.column.YesNo.prototype.defaultRenderer.call(this, value);
    }
});
