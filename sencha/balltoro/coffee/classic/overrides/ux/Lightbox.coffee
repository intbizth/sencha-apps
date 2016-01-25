Ext.ns('Ext.ux')

Ext.ux.Lightbox = do ->
    els = {}
    images = []
    activeImage = undefined
    initialized = false
    selectors = []
    myWidth = undefined
    myHeight = undefined
    leftPadding = undefined

    {
        overlayOpacity: 0.85
        animate: true
        resizeSpeed: 8
        borderSize: 10
        labelImage: 'Image'
        labelOf: 'of'

        init: ->
            @resizeDuration = if @animate then (11 - (@resizeSpeed)) * 0.15 else 0
            @overlayDuration = if @animate then 0.2 else 0
            if !initialized
                Ext.apply this, Ext.util.Observable.prototype
                Ext.util.Observable.constructor.call this
                # @addEvents 'open', 'close'
                @initMarkup()
                @initEvents()
                initialized = true
            return

        initMarkup: ->
            els.shim = Ext.core.DomHelper.append(document.body, {
                tag: 'iframe'
                id: 'ux-lightbox-shim'
            }, true)
            els.overlay = Ext.core.DomHelper.append(document.body, {
                id: 'ux-lightbox-overlay'
                style: 'z-index:1;opacity:0.85;filter:alpha(opacity=85)'
            }, true)
            lightboxTpl = new (Ext.Template)(@getTemplate())
            els.lightbox = lightboxTpl.append(document.body, {}, true)
            ids = [
                'outerImageContainer'
                'fotometaform'
                'imageContainer'
                'image'
                'hoverNav'
                'loading'
                'loadingLink'
                'sliderdiv'
                'overlay'
                'dataform'
                'dataform2'
                'navpane'
                'outerDataContainer'
                'navClose'
                'navDataview'
            ]
            Ext.each ids, (id) ->
                els[id] = Ext.get('ux-lightbox-' + id)
                return
            Ext.each [
                els.overlay
                els.lightbox
                els.shim
            ], (el) ->
                # el.setVisibilityMode Ext.core.Element.DISPLAY
                el.setVisibilityMode Ext.dom.Element.DISPLAY
                el.hide()
                return
            size = (if @animate then 250 else 1) + 'px'
            els.outerImageContainer.setStyle
                width: size
                height: size
            return

        getTemplate: ->
            [
                '<div id="ux-lightbox" >'
                '<div id="ux-lightbox-outerImageContainer" style="width:' + Ext.getBody().getViewSize().width * .5 + '">'
                '<div id="ux-lightbox-imageContainer">'
                '<div id="CenterImage">'
                '<img class="bigDrop" id="ux-lightbox-image" />'
                '</div>'
                '<div id="ux-lightbox-hoverNav" style="height: 400px; : z-index-1;">'
                '</div>'
                '<div id="ux-lightbox-loading">'
                '<a id="ux-lightbox-loadingLink"></a>'
                '</div>'
                '</div>'
                '<div id="ux-lightbox-navpane>">'
                '<div id="ux-lightbox-navClose" style="float: right"><a href="#" id="ux-lightbox-navClose"></a></div>'
                '<div id="ux-lightbox-navDataview"></div>'
                '</div>'
                '</div>'
                '</div>'
            ]
            #closes lightbox

        initEvents: ->
            close = (ev) ->
                hideStuff leftPadding
                ev.preventDefault()
                @close()
                return

            els.overlay.on 'click', close, this
            els.loadingLink.on 'click', close, this
            els.navClose.on 'click', close, this
            els.lightbox.on 'click', ((ev) ->
                if ev.getTarget().id == 'ux-lightbox'
                    @close()
                    #I think this is if you click on the black it closes
                return
            ), this
            return

        register: (sel, group) ->
            #if(selectors.indexOf(sel) === -1){
            selectors.push sel
            Ext.fly(document).on 'click', ((ev) ->
                target = ev.getTarget(sel)
                if target
                    ev.preventDefault()
                    @open target, sel, group
                return
            ), this
            #}
            return

        open: (image, sel, group) ->
            group = group or false
            @setViewSize()
            els.overlay.show()
            images = []
            index = 0
            if !group
                #we're using group so go to else
                images.push [
                    image.href
                    image.title
                    image.alt
                ]
            else
                setItems = Ext.query(sel)
                Ext.each setItems, (item) ->
                    if item.href
                        images.push [
                            item.href
                            item.title
                            item.alt
                        ]
                    return
                while images[index][0] != image.href
                    index++
            # calculate top and left offset for the lightbox
            pageScroll = Ext.fly(document).getScroll()
            lightboxTop = pageScroll.top + Ext.getBody().getViewSize().height / 100
            lightboxLeft = pageScroll.left
            els.lightbox.setStyle(
                top: lightboxTop + 'px'
                left: lightboxLeft + 'px').show()
            @setImage index
            @fireEvent 'open', images[index]
            return

            setViewSize: ->
                viewSize = @getViewSize()
                els.overlay.setStyle
                    width: viewSize[0] + 'px'
                    height: viewSize[1] + 'px'
                els.shim.setStyle(
                    width: viewSize[0] + 'px'
                    height: viewSize[1] + 'px').show()
                return

        setImage: (index) ->
            activeImage = index
            if @animate
                els.loading.show()
            els.image.hide()
            els.hoverNav.hide()
            #els.dataContainer.setOpacity(0.0001);
            preload = new Image
            preload.onload = Ext.bind(->
                els.image.dom.src = images[activeImage][0].substring(0, images[activeImage][0].length - 3) + 'JPG'
                if preload.width >= preload.height
                    myHeight = Ext.getBody().getViewSize().height * .7376
                    myWidth = Ext.getBody().getViewSize().width * .734375
                    #Odd number because I am odd. And it keeps a contrast ratio on all screen sizes
                    leftPadding = 53
                else
                    myHeight = Ext.getBody().getViewSize().height * .7376
                    myWidth = Ext.getBody().getViewSize().width * .35625
                    leftPadding = 253
                document.getElementById('CenterImage').style.paddingLeft = leftPadding + 'px'
                return
            )
            els.myContent = Ext.core.DomHelper.append(document.getElementById('ux-lightbox-sliderdiv'), { id: 'ux-lightbox-myContent' }, true)
            slideshow = undefined
            mybody = document.getElementById('myBody')
            myDiv = document.getElementById('ux-lightbox-myContent')
            wrapper = document.createElement('div')
            myDiv.appendChild wrapper
            wrapper.setAttribute 'id', 'ux-lightbox-wrapper'
            thumbnails = document.createElement('div')
            wrapper.appendChild thumbnails
            thumbnails.setAttribute 'id', 'ux-lightbox-thumbnails'
            @resizeImage preload.width, preload.height
            preload.src = images[activeImage][0].substring(0, images[activeImage][0].length - 3) + 'JPG'
            return


        resizeImage: (w, h) ->
            wCur = els.outerImageContainer.getWidth()
            hCur = els.outerImageContainer.getHeight()
            wNew = w + @borderSize * 2
            hNew = h + @borderSize * 2
            wDiff = wCur - wNew
            hDiff = hCur - hNew
            queueLength = 0
            if hDiff != 0 or wDiff != 0
                els.outerImageContainer.shift(
                    height: Ext.getBody().getViewSize().height * .8783
                    duration: @resizeDuration).shift
                    width: Ext.getBody().getViewSize().width * .8203
                    duration: @resizeDuration
                queueLength++
            timeout = 0
            if hDiff == 0 and wDiff == 0
                timeout = if Ext.isIE then 250 else 100
            Ext.defer Ext.bind((->
                @showImage()
                return
            ), this), @resizeDuration * 1000 + timeout
            return

        showImage: ->
            els.image.setWidth myWidth
            els.image.setHeight myHeight
            els.loading.hide()
            els.image.fadeIn
                duration: @resizeDuration
                scope: this
                callback: ->
                    @updateDetails()
                    return
            @preloadImages()
            return

        updateDetails: ->

        preloadImages: ->
            next = undefined
            prev = undefined
            if images.length > activeImage + 1
                next = new Image
                next.src = images[activeImage + 1][0]
            if activeImage > 0
                prev = new Image
                prev.src = images[activeImage - 1][0]
            return

        close: ->
            els.lightbox.hide()
            els.overlay.hide()
            els.shim.hide()
            @fireEvent 'close', activeImage
            return

        getViewSize: ->
            #this is the black shaded area
            [
                Ext.getBody().getViewSize().width
                Ext.getBody().getViewSize().height
            ]
    }

Ext.Loader.onReady Ext.ux.Lightbox.init, Ext.ux.Lightbox
