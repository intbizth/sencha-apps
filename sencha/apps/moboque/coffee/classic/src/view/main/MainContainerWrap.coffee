Ext.define 'Moboque.view.main.MainContainerWrap',
    extend: 'Ext.container.Container'
    xtype: 'ux-main-container-wrap'

    requires : [
        'Ext.layout.container.HBox'
    ]

    scrollable: 'y'

    layout:
        type: 'hbox'
        align: 'stretch'

        # Tell the layout to animate the x/width of the child items.
        animate: yes
        animatePolicy:
            x: yes
            width: yes

    beforeLayout: ->
        # We setup some minHeights dynamically to ensure we stretch to fill the height
        # of the viewport minus the top toolbar

        # offset by topmost toolbar height
        height = Ext.Element.getViewportHeight() - 64
        @minHeight = height;

        # We use itemId/getComponent instead of "reference" because the initial
        # layout occurs too early for the reference to be resolved
        navTree = @getComponent 'com-menu'

        navTree.setStyle
            'min-height': height + 'px'

        @callParent arguments
        return
