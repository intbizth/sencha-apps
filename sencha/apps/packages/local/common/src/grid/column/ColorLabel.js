Ext.define('Ext.common.grid.column.ColorLabel', {
    extend: 'Ext.grid.column.Column',
    alias: ['widget.colorlabelcolumn'],

    defaultFilterType: 'string',

    config: {
        colorBoxCls: 'x-grid-column-color-label',
        colorBoxWidth: 16,
        colorBoxHeight: 16
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
            '<div class="{0}">' +
                '<span class="{0}-color" style="background-color: {2}; width: {3}px; height: {4}px;"></span>' +
                '<span class="{0}-text">{1}</span>' +
            '</div>'
            ,this.colorBoxCls, value, value, this.colorBoxWidth, this.colorBoxHeight
        );
    },

    updater: function(cell, value) {
        Ext.fly(cell).down(this.getView().innerSelector, true).innerHTML = Ext.common.grid.column.ColorLabel.prototype.defaultRenderer.call(this, value);
    }
});
