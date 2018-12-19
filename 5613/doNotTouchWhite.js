var link, jsGame;

(function() {
    var e = window.eval,
        t = function(e, t, n) {
            var r = n || {};
            if (t) {
                var i = function() {};
                i.prototype = t.prototype, e.prototype = new i, e.prototype.constructor = e, e.prototype.superClass = t.prototype, i = null
            }
            for (var s in r) e.prototype[s] = r[s];
            return r = null, e
        };
    window.requestAnimationFrame = function() {
        return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || window.setTimeout
    }(), window.cancelAnimationFrame = function() {
        return window.cancelAnimationFrame || window.webkitCancelAnimationFrame || window.mozCancelAnimationFrame || window.oCancelAnimationFrame || window.msCancelAnimationFrame || window.clearTimeout
    }(), String || (String = {}), String.format || (String.format = function() {
        if (arguments.length == 0) return null;
        var e = arguments[0] || "",
            t;
        for (var n = 1, r = arguments.length; n < r; n++) t = new RegExp("\\{" + (n - 1) + "\\}", "gm"), e = e.replace(t, arguments[n]);
        return t = null, e
    }), String.getByteLength || (String.getByteLength = function(e) {
        var t, n = 0,
            r = e || "",
            i = r.length;
        for (t = 0; t < i; t++) r.charCodeAt(t) >= 0 & r.charCodeAt(t) <= 255 ? n += 1 : n += 2;
        return t = r = i = null, n
    });
    if (!Array || !Array.prototype) Array.prototype = {};
    Array.prototype.indexOfAttr = function(e, t) {
        var n = (typeof e).toLowerCase(),
            r = -1;
        for (var i = 0, s = this.length; i < s; i++)
            if (n == "string" && this[i][e] == t || n == "number" && this[i] == e) {
                r = i;
                break
            }
        return n = null, r
    };
    var n = {
            canvas: {
                id: "linkScreen",
                defaultId: "linkScreen",
                defaultFont: "12px Arial",
                defaultWidth: 320,
                defaultHeight: 480,
                defaultColor: "rgb(0, 0, 0)",
                bgColor: "#000",
                cavansDoms: [],
                ctxs: [],
                device: "",
                fps: 1,
                touch: !1,
                zoom: 1
            },
            system: {
                loadRes: null,
                pageLoad: null,
                menu: null,
                run: null,
                runFn: function() {},
                rafRun: null,
                stop: null,
                over: null,
                zone: null,
                active: null,
                lastDate: Date.now(),
                timeout: 30,
                isPause: !1,
                gameFlow: -1,
                loadedImageToGameFlow: -1,
                zoneArgs: null,
                activeArgs: null,
                spendTime: 0,
                loadResTimer: null,
                playTimer: null
            },
            event: {
                key: 0,
                keys: {
                    up: !1,
                    down: !1,
                    left: !1,
                    right: !1,
                    a: !1,
                    b: !1,
                    c: !1,
                    menu: !1,
                    quit: !1
                },
                lastKey: {
                    up: !1,
                    down: !1,
                    left: !1,
                    right: !1,
                    a: !1,
                    b: !1,
                    c: !1,
                    menu: !1,
                    quit: !1
                },
                pressedKey: {
                    up: !1,
                    down: !1,
                    left: !1,
                    right: !1,
                    a: !1,
                    b: !1,
                    c: !1,
                    menu: !1,
                    quit: !1
                },
                keyPressCtrl: {
                    up: !0,
                    down: !0,
                    left: !0,
                    right: !0,
                    a: !0,
                    b: !0,
                    c: !0,
                    menu: !0,
                    quit: !0
                },
                keyDownGo: !1,
                keyUpGo: !1,
                keyPressedGo: !1,
                keyDownCallBack: null,
                keyUpCallBack: null,
                orientationChange: null,
                touchStart: null,
                touchEnd: null,
                touchMove: null,
                touchCancel: null,
                clickCallBack: null,
                mouseDownCallBack: null,
                mouseUpCallBack: null,
                mouseMoveCallBack: null,
                focused: !1,
                pageFocusCallBack: null,
                pageUnFocusCallBack: null,
                swipeCallBack: null,
                pageOffX: 0,
                pageOffY: 0,
                pageStarOffX: 0,
                pageStarOffY: 0,
                swipeDate: null,
                swipeTimeout: 200,
                swipeRange: 50
            },
            image: {
                imgs: {},
                imgObjs: [],
                initImgs: {},
                asyncImgObjs: {},
                imgCount: 0,
                countLoaded: 0,
                version: "",
                inited: !1
            },
            audio: {
                audios: {}
            },
            ajax: {
                xhrObj: null,
                pool: [],
                poolLength: 5,
                date: null,
                isTimeout: !1,
                param: {
                    type: "get",
                    data: null,
                    dataType: "json",
                    url: "",
                    xhr: null,
                    timeout: 5e3,
                    before: function(e) {},
                    success: function(e, t) {},
                    error: function(e, t) {},
                    complete: function(e) {}
                }
            },
            request: {
                gets: []
            },
            buttonLayout: {
                buttons: [],
                Button: t(function(e) {
                    this.id = e.id, this.value = e.value, this.x = e.x, this.y = e.y, this.width = e.width, this.height = e.height, this.bgColor = e.bgColor, this.bgStroke = e.bgStroke, this.stroke = e.stroke, this.font = e.font, this.imageId = e.imageId, this.sx = e.sx, this.sy = e.sy, this.color = e.color, this.hx = e.hx, this.hy = e.hy, this.hColor = e.hColor, this.dex = e.dex, this.dey = e.dey, this.deColor = e.deColor, this.hided = e.hided, this.disabled = e.disabled, this.path = e.path, this.hovered = !1, this.repeated = !1, this.pressed = !1, this.released = !1, this.goned = !1, this.cacheId = "buttonLayoutCache_" + this.id, this.setDelay(e.delay).refresh()
                }, null, {
                    refresh: function() {
                        m.canvas.pass(this.cacheId, this.width * 3, this.height), this.imageId == "" ? (this.bgColor != "" && m.canvas.fillStyle(this.bgColor).fillRect(0, 0, this.width, this.height).fillRect(this.width, 0, this.width, this.height).fillRect(this.width * 2, 0, this.width, this.height), this.bgStroke != "" && m.canvas.strokeStyle(this.bgStroke).strokeRect(1, 1, this.width - 2, this.height - 2).strokeRect(this.width + 1, 1, this.width - 2, this.height - 2).strokeRect(this.width * 2 + 1, 1, this.width - 2, this.height - 2)) : m.canvas.drawImage(this.imageId, this.sx, this.sy, this.width, this.height, 0, 0, this.width, this.height).drawImage(this.imageId, this.hx, this.hy, this.width, this.height, this.width, 0, this.width, this.height).drawImage(this.imageId, this.dex, this.dey, this.width * 2, this.height, this.width * 2, 0, this.width, this.height);
                        if (this.value != "") {
                            var e = m.canvas.font(this.font).measureText(this.value),
                                t = this.width - e.width >> 1,
                                n = (this.height - e.height >> 1) + parseInt(this.font) - 2;
                            this.stroke != "" && m.canvas.fillStyle(this.stroke).fillText(this.value, t - 1, n).fillText(this.value, t, n - 1).fillText(this.value, t + 1, n).fillText(this.value, t, n + 1).fillText(this.value, t + this.width - 1, n).fillText(this.value, t + this.width, n - 1).fillText(this.value, t + this.width + 1, n).fillText(this.value, t + this.width, n + 1).fillText(this.value, t + this.width * 2 - 1, n).fillText(this.value, t + this.width * 2, n - 1).fillText(this.value, t + this.width * 2 + 1, n).fillText(this.value, t + this.width * 2, n + 1), m.canvas.fillStyle(this.color).fillText(this.value, t, n).fillStyle(this.hColor).fillText(this.value, t + this.width, n).fillStyle(this.deColor).fillText(this.value, t + this.width * 2, n), e = t = n = null
                        }
                        return m.canvas.pass(), this
                    },
                    show: function() {
                        return this.hided = !1, this
                    },
                    hide: function() {
                        return this.hided = !0, this
                    },
                    disable: function(e) {
                        return this.disabled = e, this
                    },
                    setPath: function(e, t) {
                        return this.setDelay(t).path = e || [], this
                    },
                    endPath: function() {
                        return this.path.length == 0
                    },
                    gone: function(e, t) {
                        return this.setPath(e, t).goned = !0, this
                    },
                    setDelay: function(e) {
                        return this.delay = e || 0, this.delayDate = null, this.delay > 0 && (this.delayDate = Date.now()), this
                    },
                    action: function() {
                        if (this.hided) return this;
                        this.delayDate && Date.now() - this.delayDate >= this.delay && (this.delayDate = null);
                        if (!this.delayDate && this.path.length > 0) {
                            var e = this.path.shift();
                            this.x += e[0], this.y += e[1], e = null
                        }
                        return this
                    },
                    render: function() {
                        return this.hided ? this : (m.canvas.drawCache(this.cacheId, this.hovered ? this.width : this.disabled ? this.width * 2 : 0, 0, this.width, this.height, this.x, this.y, this.width, this.height), this)
                    },
                    disposed: function() {
                        return this
                    }
                })
            }
        },
        r = {
            canvas: {
                context: {
                    base: 0
                },
                graphics: {
                    HCENTER: 1,
                    VCENTER: 2,
                    LEFT: 4,
                    RIGHT: 8,
                    TOP: 16,
                    BOTTOM: 32,
                    ANCHOR_LT: 20,
                    ANCHOR_LV: 6,
                    ANCHOR_LB: 36,
                    ANCHOR_HT: 17,
                    ANCHOR_HV: 3,
                    ANCHOR_HB: 33,
                    ANCHOR_RT: 24,
                    ANCHOR_RV: 10,
                    ANCHOR_RB: 40
                },
                trans: {
                    TRANS_MIRROR: 2,
                    TRANS_NONE: 0,
                    TRANS_ROT90: 5,
                    TRANS_ROT180: 3,
                    TRANS_ROT270: 6,
                    TRANS_MIRROR_ROT90: 7,
                    TRANS_MIRROR_ROT180: 1,
                    TRANS_MIRROR_ROT270: 4
                }
            },
            event: {
                key: {
                    up: 38,
                    down: 40,
                    left: 37,
                    right: 39,
                    a: 90,
                    b: 88,
                    c: 67,
                    menu: 49,
                    quit: 50
                }
            },
            system: {
                gameFlowType: {
                    menu: 0,
                    run: 1,
                    stop: 2,
                    over: 3,
                    zone: 4,
                    active: 5,
                    loadImage: 6,
                    loadedImage: 7
                }
            }
        },
        i = {
            getCanvasDom: function() {
                var e;
                return function() {
                    return e || (e = m.getDom(n.canvas.defaultId)), e
                }
            }(),
            getOffsetX: function(e) {
                return e.offsetX || (e.changedTouches && e.changedTouches[0] ? e.changedTouches[0].clientX - i.getCanvasDom().offsetLeft : e.clientX - i.getCanvasDom().offsetLeft) || 0
            },
            getOffsetY: function(e) {
                return e.offsetY || (e.changedTouches && e.changedTouches[0] ? e.changedTouches[0].clientY - i.getCanvasDom().offsetTop : e.clientY - i.getCanvasDom().offsetTop) || 0
            },
            keydown: function(e) {
                var t = i.checkKey(e.keyCode);
                n.event.keyDownGo && n.event.keys[t] != undefined && (n.event.keys[t] = !0), n.event.keyUpGo && n.event.lastKey[t] != undefined && (n.event.lastKey[t] = !1), n.event.keyPressCtrl[t] && n.event.keyPressedGo && (n.event.pressedKey[t] != undefined && (n.event.pressedKey[t] = !0), n.event.keyPressCtrl[t] = !1), n.event.keyDownCallBack != null && n.event.keyDownCallBack(e), t = null
            },
            keyup: function(e) {
                var t = i.checkKey(e.keyCode);
                n.event.keyDownGo && n.event.keys[t] != undefined && (n.event.keys[t] = !1), n.event.keyUpGo && n.event.lastKey[t] != undefined && (n.event.lastKey[t] = !0), n.event.keyPressedGo && (n.event.pressedKey[t] != undefined && (n.event.pressedKey[t] = !1), n.event.keyPressCtrl[t] = !0), n.event.keyUpCallBack != null && n.event.keyUpCallBack(e), t = null
            },
            orientationchange: function(e) {
                n.event.orientationChange != null && n.event.orientationChange(e)
            },
            swipeStart: function(e, t) {
                n.event.swipeCallBack != null && (n.event.swipeDate = Date.now(), n.event.pageStarOffX = e, n.event.pageStarOffY = t)
            },
            swipeSuccess: function(e, t) {
                if (n.event.swipeDate) {
                    if (Date.now() - n.event.swipeDate < n.event.swipeTimeout)
                        if (Math.abs(e - n.event.pageStarOffX) >= n.event.swipeRange || Math.abs(t - n.event.pageStarOffY) >= n.event.swipeRange) return n.event.swipeCallBack(n.event.pageStarOffX, n.event.pageStarOffY, e, t), !0;
                    n.event.swipeDate = null
                }
                return !1
            },
            touchstart: function(e) {
                e.preventDefault(), n.event.pageOffX = i.getOffsetX(e), n.event.pageOffY = i.getOffsetY(e), n.event.touchStart != null && n.event.touchStart(e, n.event.pageOffX, n.event.pageOffY);
                if (i.buttonLayoutEventHandler(e.type, n.event.pageOffX, n.event.pageOffY)) return !1;
                i.swipeStart(n.event.pageOffX, n.event.pageOffY)
            },
            touchend: function(e) {
                e.preventDefault();
                if (i.swipeSuccess(n.event.pageOffX, n.event.pageOffY)) return !1;
                if (i.buttonLayoutEventHandler(e.type, n.event.pageOffX, n.event.pageOffY)) return !1;
                n.event.touchEnd != null && n.event.touchEnd(e, n.event.pageOffX, n.event.pageOffY)
            },
            touchmove: function(e) {
                e.preventDefault(), n.event.pageOffX = i.getOffsetX(e), n.event.pageOffY = i.getOffsetY(e), n.event.touchMove != null && n.event.touchMove(e, n.event.pageOffX, n.event.pageOffY)
            },
            touchcancel: function(e) {
                n.event.pageOffX = i.getOffsetX(e), n.event.pageOffY = i.getOffsetY(e), n.event.touchCancel != null && n.event.touchCancel(e, n.event.pageOffX, n.event.pageOffY)
            },
            click: function(e) {
                n.event.clickCallBack != null && n.event.clickCallBack(e, i.getOffsetX(e), i.getOffsetY(e))
            },
            mouseDown: function(e) {
                e.preventDefault();
                var t = i.getOffsetX(e),
                    r = i.getOffsetY(e);
                if (i.buttonLayoutEventHandler(e.type, t, r)) return !1;
                n.event.mouseDownCallBack != null && n.event.mouseDownCallBack(e, t, r), i.swipeStart(t, r), t = r = null
            },
            mouseUp: function(e) {
                e.preventDefault();
                var t = i.getOffsetX(e),
                    r = i.getOffsetY(e);
                if (i.buttonLayoutEventHandler(e.type, t, r)) return !1;
                if (i.swipeSuccess(t, r)) return !1;
                n.event.mouseUpCallBack != null && n.event.mouseUpCallBack(e, t, r), t = r = null
            },
            mouseMove: function(e) {
                e.preventDefault();
                n.event.mouseMoveCallBack != null && n.event.mouseMoveCallBack(e, i.getOffsetX(e), i.getOffsetY(e))
            },
            pageFocus: function(e) {
                if (n.event.focused) return n.event.focused = !1, !1;
                n.event.pageFocusCallBack != null && n.event.pageFocusCallBack(e)
            },
            pageUnFocus: function(e) {
                n.event.pageUnFocusCallBack != null && n.event.pageUnFocusCallBack(e)
            },
            checkKey: function(e) {
                var t = "0";
                for (var n in r.event.key)
                    if (r.event.key[n] == e) {
                        t = n;
                        break
                    }
                return t
            },
            getDeviceConfig: function() {
                var e = navigator.userAgent.toLowerCase();
                return e.indexOf("play68safari") != -1 ? {
                    device: "play68Safari",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("iphone") != -1 || e.indexOf("ipod") != -1 ? {
                    device: "iphone",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("ipad") != -1 ? {
                    device: "ipad",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("play68android") != -1 ? {
                    device: "play68Android",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("play68windowsphone") != -1 ? {
                    device: "play68WindowsPhone",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("opera mobi") != -1 ? {
                    device: "operamobile",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("flyflow") != -1 ? {
                    device: "flyflow",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("android") != -1 ? {
                    device: "android",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("iemobile") != -1 ? {
                    device: "iemobile",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("j2me") != -1 ? {
                    device: "j2me",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("symbian v5") != -1 ? {
                    device: "symbian5",
                    fps: 1,
                    touch: !0,
                    zoom: 1
                } : e.indexOf("symbian v3") != -1 ? {
                    device: "symbian3",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("chrome") != -1 ? {
                    device: "chrome",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("firefox") != -1 ? {
                    device: "firefox",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("msie") != -1 ? {
                    device: "ie",
                    fps: .5,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("windows") != -1 ? {
                    device: "ie",
                    fps: .5,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("safari") != -1 ? {
                    device: "safari",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : e.indexOf("opera") != -1 ? {
                    device: "opera",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                } : {
                    device: "",
                    fps: 1,
                    touch: !1,
                    zoom: 1
                }
            },
            setImage: function(e, t, r, i, s) {
                if (!e || !t) return !1;
                n.image.imgs[e] || (n.image.imgs[e] = new Image, n.image.imgs[e].onload = function() {
                    n.image.countLoaded++, this.loaded = !0, this.cache && m.canvas.pass(this.id, this.width, this.height).drawImage(this.id, 0, 0).pass().base().delImage(this.id, !0)
                }, n.image.imgs[e].src = t + (n.image.version != "" ? "?v=" + n.image.version : ""), n.image.imgs[e].id = e, n.image.imgs[e].url = t, n.image.imgs[e].benchId = r, n.image.imgs[e].bench = i, n.image.imgs[e].cache = s, n.image.imgs[e].refreshed = !1)
            },
            setAudio: function(e, t, r, i, s, o) {
                if (!e || !t) return !1;
                if (!n.audio.audios[e]) {
                    var u = new Audio(t + (n.image.version != "" ? "?v=" + n.image.version : ""));
                    u.id = e, u.autoplay = i, u.preload = s, u.autobuffer = o, u.loop = r, n.audio.audios[u.id] = u, u = null
                }
            },
            loadingCallBack: function(e, t, r) {
                var i = m.canvas.screen.getWidth(),
                    s = m.canvas.screen.getHeight(),
                    o = i,
                    u = 5,
                    a = parseInt(i - o >> 1),
                    f = s - u,
                    e = e > t ? t : e,
                    l = parseInt(e / t * 100) + "%";
                m.canvas.fillStyle(n.canvas.bgColor).fillRect(0, 0, i, s).fillStyle("#00FFFF").fillRect(a, f, parseInt(e / t * o), u).fillStyle("#FFF").fillText("loading " + r, 5, s - 10).fillText(l, i - m.canvas.measureText(l).width - 5, s - 10), i = s = o = u = a = f = l = null
            },
            loadingEndCallBack: null,
            getAnchor: function(e, t, n, i, s) {
                var o = e,
                    u = t;
                switch (s) {
                    case r.canvas.graphics.ANCHOR_HV:
                        o -= parseInt(n / 2), u -= parseInt(i / 2);
                        break;
                    case r.canvas.graphics.ANCHOR_LV:
                        u -= parseInt(i / 2);
                        break;
                    case r.canvas.graphics.ANCHOR_RV:
                        o -= n, u -= parseInt(i / 2);
                        break;
                    case r.canvas.graphics.ANCHOR_HT:
                        o -= parseInt(n / 2);
                        break;
                    case 0:
                    case r.canvas.graphics.ANCHOR_LT:
                    default:
                        break;
                    case r.canvas.graphics.ANCHOR_RT:
                        o -= n;
                        break;
                    case r.canvas.graphics.ANCHOR_HB:
                        o -= parseInt(n / 2), u -= i;
                        break;
                    case r.canvas.graphics.ANCHOR_LB:
                        u -= i;
                        break;
                    case r.canvas.graphics.ANCHOR_RB:
                        o -= n, u -= i
                }
                return {
                    x: o,
                    y: u
                }
            },
            initUrlParams: function(e) {
                if (e.indexOf("?") >= 0) {
                    var t = e.split("?"),
                        r = [];
                    t[1].indexOf("&") >= 0 ? r = t[1].split("&") : r.push(t[1]);
                    var i = [];
                    for (var s = 0; s < r.length; s++) r[s].indexOf("=") >= 0 && (i = r[s].split("="), n.request.gets[i[0]] = i[1]);
                    i = null, r = null, t = null
                }
            },
            audioEnded: function() {
                m.audio.replay(this.id)
            },
            pageLoaded: function() {
                n.image.inited = !0, n.system.pageLoad(m)
            },
            buttonLayoutAction: function() {
                var e = n.buttonLayout.buttons,
                    t;
                for (var r = e.length - 1; r >= 0; r--)
                    if (t = e[r]) t.action().render(), t.goned && t.endPath() && e.splice(r, 1);
                e = t = null
            },
            buttonLayoutEventHandler: function(e, t, r) {
                var i = n.buttonLayout.buttons,
                    s, o = !1;
                for (var u = i.length - 1; u >= 0; u--)
                    if (s = i[u])
                        if (m.comm.collision(s.x, s.y, s.width, s.height, t - 5, r - 5, 10, 10)) {
                            switch (e) {
                                case "mousedown":
                                case "touchstart":
                                    s.hovered = !0, s.repeated = !0, s.pressed = !0, s.released = !1;
                                    break;
                                case "mouseup":
                                case "touchend":
                                    s.hovered && (s.released = !0, s.hovered = !1), s.repeated = !1, s.pressed = !1;
                                    break;
                                default:
                            }
                            o = !0
                        } else if (e == "mouseup" || e == "touchend") s.hovered = !1, s.repeated = !1;
                return i = s = null, o
            }
        },
        s, o, u, a, f, l, c, h, p, d, v = {
            arr: [],
            len: 0,
            v: 0
        };
    link = {
        init: function(e, t) {
            return !e && !t ? (this.version = 1, this.request.init(), this.canvas.initDevice(), this.localStorage.init(), this.sessionStorage.init()) : (n.canvas.defaultWidth = e, n.canvas.defaultHeight = t), this
        },
        extend: t,
        setAjax: function(e) {
            return n.ajax.param = this.objExtend(n.ajax.param, e || {}), this
        },
        ajax: function(e) {
            e && n.ajax.pool.length < n.ajax.poolLength && n.ajax.pool.push(e), e && e.clear && (n.ajax.pool = []), n.ajax.xhr || (n.ajax.xhr = new XMLHttpRequest, n.ajax.xhr.onreadystatechange = function() {
                if (n.ajax.isTimeout) return !1;
                var e = n.ajax.xhr,
                    t = n.ajax.xhrObj;
                if (t && e.readyState == 4) {
                    n.ajax.date && (clearTimeout(n.ajax.date), n.ajax.date = null);
                    if (e.status == 200) {
                        var r;
                        switch (t.dataType) {
                            case "HTML":
                            case "SCRIPT":
                            case "XML":
                                r = e.responseText;
                                break;
                            case "TEXT":
                            default:
                                r = e.responseText.replace(/<[^>].*?>/g, "");
                                break;
                            case "JSON":
                                r = m.getJson(e.responseText)
                        }
                        t.success(r, t), t.complete(t)
                    } else t.error(t, "error");
                    n.ajax.xhrObj = null, m.ajax()
                }
                e = t = null
            });
            if (n.ajax.xhrObj == null && n.ajax.pool.length > 0) {
                n.ajax.xhrObj = this.objExtend(n.ajax.param, n.ajax.pool.shift() || {});
                var t = n.ajax.xhr,
                    r = n.ajax.xhrObj,
                    i = n.ajax.xhrObj.url,
                    s = null,
                    o = r.data;
                r.type = r.type.toUpperCase(), r.dataType = r.dataType.toUpperCase(), n.ajax.isTimeout = !1;
                if (typeof o == "string") s = o;
                else if (typeof o == "object") {
                    s = [];
                    for (var u in o) s.push(u + "=" + o[u]);
                    s = s.join("&")
                }
                r.type == "GET" && (i += "?" + s), t.open(r.type, i, !0), r.before(n.ajax.xhrObj), r.type == "POST" && t.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"), t.send(s), t = r = s = o = i = null, n.ajax.date = setTimeout(function() {
                    m.ajax({
                        clear: !0
                    }), n.ajax.isTimeout = !0, n.ajax.xhrObj && (n.ajax.xhrObj.error(n.ajax.xhrObj, "timeout"), n.ajax.xhrObj = null)
                }, n.ajax.xhrObj.timeout)
            }
            return this
        },
        getDom: function(e) {
            try {
                return document.getElementById(e)
            } catch (t) {
                return document.all[e]
            }
        },
        objExtend: function() {
            var e = this.clone(arguments[0]) || {},
                t = 1,
                n = arguments.length,
                r = !1,
                i;
            typeof e == "boolean" && (r = e, e = arguments[1] || {}, t = 2), typeof e != "object" && (e = {}), n == t && (e = this, --t);
            if (!arguments[1]) return e;
            for (; t < n; t++)
                if ((i = arguments[t]) != null)
                    for (var s in i) {
                        var o = e[s],
                            u = i[s];
                        if (e === u) continue;
                        r && u && typeof u == "object" && !u.nodeType ? e[s] = this.objExtend(r, o || (u.length != null ? [] : {}), u) : u !== undefined && (e[s] = u)
                    }
                return e
        },
        getJson: function(t) {
            var n = {};
            try {
                window.JSON ? n = JSON.parse(t) : n = e("(" + t + ")")
            } catch (r) {}
            return n
        },
        clone: function() {
            var e = arguments[0],
                t = e || [];
            if (typeof t == "object")
                if (t.length != undefined) {
                    e = [];
                    for (var n = 0, r = t.length; n < r; n++) {
                        if (t[n] === undefined) continue;
                        t[n] != null && typeof t[n] == "object" ? t[n].length != undefined ? e[n] = t[n].slice(0) : e[n] = t[n] : e[n] = t[n]
                    }
                } else {
                    e = {};
                    for (var n in t) {
                        if (t[n] === undefined) continue;
                        t[n] != null && typeof t[n] == "object" ? t[n].length != undefined ? e[n] = t[n].slice(0) : e[n] = t[n] : e[n] = t[n]
                    }
                }
            return t = null, e
        },
        classes: {},
        comm: {
            registerNotify: function(e, t) {
                e != null && e.register(t)
            },
            rangeRegisterNotify: function(e, t) {
                for (var n = 0; n < t.length; n++) m.commandFuns.registerNotify(e, t[n])
            },
            unRegisterNotify: function(e, t) {
                e != null && e.unregister(t)
            },
            rangeUnRegisterNotify: function(e, t) {
                for (var n = 0; n < t.length; n++) m.commandFuns.unRegisterNotify(e, t[n])
            },
            getRandom: function(e, t) {
                if (!t) {
                    var n = e;
                    if (!n || n < 0) n = 0;
                    return Math.round(Math.random() * n)
                }
                return Math.round(Math.random() * (t - e) + e)
            },
            getArray: function(e, t) {
                v.arr = [], v.len = e.toString().length, v.v = e;
                for (var n = 0; n < v.len; n++) v.arr.push(v.v % 10), v.v = parseInt(v.v / 10);
                return t || v.arr.reverse(), v.arr
            },
            inArray: function(e, t) {
                var n, r = t.length;
                for (n = 0; n < r; n++)
                    if (e == t[n]) return n;
                return -1
            },
            collision: function(e, t, n, r, i, s, o, u) {
                return o && Math.abs(e + (n >> 1) - (i + (o >> 1))) < n + o >> 1 && Math.abs(t + (r >> 1) - (s + (u >> 1))) < r + u >> 1 ? !0 : !1
            },
            circleCollision: function(e, t, n, r, i, s) {
                var o = Math.abs(e - r),
                    u = Math.abs(t - i);
                return Math.sqrt(o * o + u * u) < n + s ? !0 : !1
            },
            rect2CircleCollision: function(e, t, n, r, i, s, o) {
                var u = !1;
                return (u = this.circleCollision(e, t, 1, i, s, o)) || (u = this.circleCollision(e + n, t, 1, i, s, o)) || (u = this.circleCollision(e + n, t + r, 1, i, s, o)) || (u = this.circleCollision(e, t + r, 1, i, s, o)) || (u = this.collision(e, t, n, r, i - (o >> 1), s - (o >> 1), o, o)), u
            },
            polygonCollision: function(e, t, n, r, i, s, o, u) {
                return this.polygonSAT(e, t, n, r, i, s, o, u) && this.polygonSAT(t, e, i, s, n, r, u, o)
            },
            polygonSAT: function(e, t, n, r, i, s, o, u) {
                var a = e.length,
                    f = t.length,
                    l = n || 0,
                    c = r || 0,
                    h = i || 0,
                    p = s || 0,
                    d = o,
                    v = u,
                    m = l + e[e.length - 1][0],
                    g = c + e[e.length - 1][1],
                    y, b, w, E, S, x, T, N, C, k, L;
                for (k = 0; k < a; k++) {
                    y = l + e[k][0], b = c + e[k][1], w = b - g, E = m - y, S = w * m + E * g, x = !0;
                    for (L = 0; L < f; L++) {
                        T = h + t[L][0], N = p + t[L][1], C = w * T + E * N - S;
                        if (C < 0) {
                            x = !1;
                            break
                        }
                    }
                    if (x) {
                        if (d[0] != 0 || d[1] != 0 || v[0] != 0 || v[1] != 0) {
                            S = w * (m + d[0]) + E * (g + d[1]);
                            for (L = 0; L < f; L++) {
                                T = h + t[L][0] + v[0], N = p + t[L][1] + v[1], C = w * T + E * N - S;
                                if (C < 0) {
                                    x = !1;
                                    break
                                }
                            }
                        }
                        if (x) return !1
                    }
                    m = y, g = b
                }
                return !0
            },
            setMatrixRotate: function(e, t) {
                if (!e || !e[0]) return null;
                var n = 50,
                    r = 50,
                    i, s, o = Math.PI / 180 * t,
                    u = Math.sin(o),
                    a = Math.cos(o);
                for (var f = 0; f < e.length; f++) i = e[f][0], s = e[f][1], e[f][0] = a * i - u * s, e[f][1] = u * i + a * s;
                return this
            },
            createPath: function(e, t, n, r, i) {
                var s = [],
                    o = e || 0,
                    u = t || 0,
                    a = n || 0,
                    f = r || 0,
                    l = a - o,
                    c = f - u,
                    h = Math.sqrt(Math.pow(l, 2) + Math.pow(c, 2)),
                    p = i || 5,
                    d = p,
                    v = 0,
                    m = 0,
                    g, y, b = Math.atan2(c, l) / Math.PI * 180;
                b = b >= 0 ? b : b + 360, d >= h && (d = h >> 1);
                while (d < h + p) d = d > h ? h : d, g = d * Math.cos(b / 180 * Math.PI), y = d * Math.sin(b / 180 * Math.PI), s.unshift([g - v, y - m]), v = g, m = y, d += p;
                return s.angle = b + 90, o = u = a = f = l = c = h = p = d = b = null, s
            }
        },
        localStorage: function() {
            var e, t, n = function() {
                var e;
                try {
                    e = window.localStorage, e.getItem || (e.getItem = function() {
                        return null
                    }), e.setItem || (e.setItem = function() {})
                } catch (t) {
                    e = {
                        getItem: function() {
                            return null
                        },
                        setItem: function() {}
                    }
                }
                return e
            };
            return {
                init: function() {
                    return e = this, t || (t = n()), e
                },
                setItem: function(n, r) {
                    try {
                        t.setItem(n, r)
                    } catch (i) {}
                    return e
                },
                getItem: function(e) {
                    return t.getItem(e)
                },
                removeItem: function(n) {
                    return t.removeItem(n), e
                },
                clear: function() {
                    return t.clear(), e
                },
                key: function(e) {
                    return t.key(e)
                },
                getLength: function() {
                    return t.length
                },
                base: function() {
                    return m
                }
            }
        }(),
        sessionStorage: function() {
            var e, t, n = function() {
                var e;
                try {
                    e = window.sessionStorage, e.getItem || (e.getItem = function() {
                        return null
                    }), e.setItem || (e.setItem = function() {})
                } catch (t) {
                    e = {
                        getItem: function() {
                            return null
                        },
                        setItem: function() {}
                    }
                }
                return e
            };
            return {
                init: function() {
                    return e = this, t || (t = n()), e
                },
                setItem: function(n, r) {
                    return t.setItem(n, r), e
                },
                getItem: function(e) {
                    return t.getItem(e)
                },
                removeItem: function(n) {
                    return t.removeItem(n), e
                },
                clear: function() {
                    return t.clear(), e
                },
                key: function(e) {
                    return t.key(e)
                },
                getLength: function() {
                    return t.length
                },
                base: function() {
                    return m
                }
            }
        }(),
        pageLoad: function(e) {
            return n.system.pageLoad == null && (n.system.pageLoad = e, window.addEventListener("load", function() {
                m.main(n.system.pageLoad)
            }, !1)), m
        },
        main: function(e) {
            n.system.pageLoad == null && (n.system.pageLoad = e), this.canvas.init(), this.graphics.ANCHOR_LT = r.canvas.graphics.ANCHOR_LT, this.graphics.ANCHOR_LV = r.canvas.graphics.ANCHOR_LV, this.graphics.ANCHOR_LB = r.canvas.graphics.ANCHOR_LB, this.graphics.ANCHOR_HT = r.canvas.graphics.ANCHOR_HT, this.graphics.ANCHOR_HV = r.canvas.graphics.ANCHOR_HV, this.graphics.ANCHOR_HB = r.canvas.graphics.ANCHOR_HB, this.graphics.ANCHOR_RT = r.canvas.graphics.ANCHOR_RT, this.graphics.ANCHOR_RV = r.canvas.graphics.ANCHOR_RV, this.graphics.ANCHOR_RB = r.canvas.graphics.ANCHOR_RB;
            var t = this.getDom(n.canvas.defaultId);
            t && (this.canvas.screen.getTouch() ? (window.addEventListener("orientationchange", i.orientationchange, !1), t.addEventListener("touchstart", i.touchstart, !1), t.addEventListener("touchend", i.touchend, !1), t.addEventListener("touchmove", i.touchmove, !1), t.addEventListener("touchcancel", i.touchcancel, !1)) : (document.onkeydown = i.keydown, document.onkeyup = i.keyup, t.addEventListener("click", i.click, !1), t.addEventListener("mousedown", i.mouseDown, !1), t.addEventListener("mouseup", i.mouseUp, !1), t.addEventListener("mousemove", i.mouseMove, !1))), t = null;
            var s = this.canvas.screen.getDevice();
            return s == "ipad" || s == "iphone" ? (n.event.focused = !0, window.addEventListener("pageshow", i.pageFocus, !1), window.addEventListener("pagehide", i.pageUnFocus, !1)) : (s == "firefox" && (n.event.focused = !0), window.addEventListener("focus", i.pageFocus, !1), window.addEventListener("blur", i.pageUnFocus, !1)), this.canvas.fillStyle(n.canvas.bgColor).fillRect(0, 0, this.canvas.screen.getWidth(), this.canvas.screen.getHeight()), n.image.inited = !1, this.gameFlow.run().base().play(), n.image.imgObjs.length > 0 ? this.loadImage(n.image.imgObjs) : i.pageLoaded(), this
        },
        menu: function(e) {
            return typeof e == "function" && (n.system.menu = e), this
        },
        run: function(e) {
            return typeof e == "function" && (n.system.runFn = e), this
        },
        stop: function(e) {
            return typeof e == "function" && (n.system.stop = e), this
        },
        over: function(e) {
            return typeof e == "function" && (n.system.over = e), this
        },
        zone: function(e) {
            return typeof e == "function" && (n.system.zone = e), this
        },
        active: function(e) {
            return typeof e == "function" && (n.system.active = e), this
        },
        play: function() {
            return n.system.run || (n.system.run = function() {
                var e = Date.now();
                switch (n.system.gameFlow) {
                    case r.system.gameFlowType.menu:
                        n.system.menu();
                        break;
                    case r.system.gameFlowType.run:
                        n.system.runFn();
                        break;
                    case r.system.gameFlowType.stop:
                        n.system.stop();
                        break;
                    case r.system.gameFlowType.over:
                        n.system.over();
                        break;
                    case r.system.gameFlowType.zone:
                        n.system.zone(n.system.zoneArgs);
                        break;
                    case r.system.gameFlowType.active:
                        n.system.active(n.system.activeArgs);
                        break;
                    case r.system.gameFlowType.loadImage:
                        if (i.loadingCallBack != null) {
                            var t = n.image.imgCount,
                                s = n.image.countLoaded > t ? t : n.image.countLoaded;
                            s == t && (n.system.gameFlow = r.system.gameFlowType.loadedImage), t > 0 && i.loadingCallBack(s, t, "image"), s == t && i.loadingEndCallBack && (i.loadingEndCallBack(s, t, "image"), i.loadingEndCallBack = null), s = t = null
                        }
                        break;
                    case r.system.gameFlowType.loadedImage:
                        n.system.gameFlow = n.system.loadedImageToGameFlow, n.image.imgObjs = [], n.image.countLoaded = 0, n.image.inited || i.pageLoaded();
                        break;
                    default:
                }
                i.buttonLayoutAction(), n.system.spendTime = Date.now() - e, e = null
            }), n.system.playTimer || (n.system.isPause = !1, (n.system.rafRun = function() {
                var e = Date.now();
                e - n.system.lastDate >= n.system.timeout - n.system.spendTime && (n.system.lastDate = e, n.system.isPause || n.system.run()), e = null, n.system.rafRun && (n.system.playTimer = requestAnimationFrame(n.system.rafRun))
            })()), this
        },
        pause: function() {
            return n.system.playTimer && (n.system.isPause = !0, n.system.rafRun = null, cancelAnimationFrame(n.system.playTimer), n.system.playTimer = null), this
        },
        gameFlow: {
            menu: function() {
                return n.system.menu != null && (n.system.gameFlow = r.system.gameFlowType.menu, m.resetKeys()), this
            },
            run: function() {
                return n.system.runFn != null && (n.system.gameFlow = r.system.gameFlowType.run, m.resetKeys()), this
            },
            stop: function() {
                return n.system.stop != null && (n.system.gameFlow = r.system.gameFlowType.stop, m.resetKeys()), this
            },
            over: function() {
                return n.system.over != null && (n.system.gameFlow = r.system.gameFlowType.over, m.resetKeys()), this
            },
            zone: function(e) {
                return n.system.zone != null && (n.system.gameFlow = r.system.gameFlowType.zone, n.system.zoneArgs = e, m.resetKeys()), this
            },
            active: function(e) {
                return n.system.active != null && (n.system.gameFlow = r.system.gameFlowType.active, n.system.activeArgs = e, m.resetKeys()), this
            },
            isIn: function(e) {
                return n.system.gameFlow == r.system.gameFlowType[e]
            },
            base: function() {
                return m
            }
        },
        keyRepeated: function(e) {
            return n.event.keyDownGo || (n.event.keyDownGo = !0), n.event.keys[e]
        },
        keyPressed: function(e) {
            n.event.keyPressedGo || (n.event.keyPressedGo = !0);
            var t = n.event.pressedKey[e];
            return n.event.pressedKey[e] = !1, t
        },
        keyReleased: function(e) {
            n.event.keyUpGo || (n.event.keyUpGo = !0);
            var t = n.event.lastKey[e];
            return n.event.lastKey[e] = !1, t
        },
        setKeyCode: function(e, t) {
            return n.event.keys[e] = !1, n.event.lastKey[e] = !1, n.event.pressedKey[e] = !1, n.event.keyPressCtrl[e] = !0, r.event.key[e] = t, this
        },
        resetKeys: function() {
            for (var e in n.event.keys) n.event.keys[e] = !1;
            for (var e in n.event.lastKey) n.event.lastKey[e] = !1;
            for (var e in n.event.pressedKey) n.event.pressedKey[e] = !1;
            for (var e in n.event.keyPressCtrl) n.event.keyPressCtrl[e] = !0;
            return this
        },
        canvas: {
            init: function() {
                return o = {
                    x: 0,
                    y: 0
                }, u = {
                    fillColor: "#000000",
                    strokeColor: "#000000"
                }, a = {
                    x: 0,
                    y: 0
                }, f = {
                    x: 0,
                    y: 0
                }, l = {
                    x: 0,
                    y: 0,
                    fillStyle: "#FFFFFF",
                    strokeStyle: "#CCCCCC"
                }, this.pass()
            },
            initDevice: function() {
                return h = i.getDeviceConfig(), n.canvas.device = h.device, n.canvas.fps = h.fps, n.canvas.touch = h.touch, n.canvas.zoom = h.zoom, this
            },
            pass: function(e, t, r) {
                var i, o;
                return !e || e == "" ? i = n.canvas.defaultId : i = e, n.canvas.ctxs[i] || (o = this.base().getDom(i) || document.createElement("canvas"), n.canvas.ctxs[i] = null, delete n.canvas.ctxs[i], n.canvas.ctxs[i] = o.getContext("2d"), o.width = t ? t : n.canvas.defaultWidth, o.style.width = parseInt(o.width * n.canvas.zoom) + "px", o.height = r ? r : n.canvas.defaultHeight, o.style.height = parseInt(o.height * n.canvas.zoom) + "px", n.canvas.cavansDoms[i] = null, delete n.canvas.cavansDoms[i], n.canvas.cavansDoms[i] = o), s = n.canvas.ctxs[i], s.font = n.canvas.defaultFont, c = n.canvas.cavansDoms[i], p = parseInt(c.width), d = parseInt(c.height), this.screen.setId(i), this
            },
            font: function(e) {
                return n.canvas.defaultFont = e, s.font = n.canvas.defaultFont, this
            },
            del: function(e) {
                return n.canvas.ctxs[e] && (n.canvas.ctxs[e] = null, delete n.canvas.ctxs[e], n.canvas.cavansDoms[e] = null, delete n.canvas.cavansDoms[e]), this
            },
            setCurrent: function(e) {
                return _canvas.pass(e)
            },
            screen: {
                setId: function(e) {
                    return n.canvas.ctxs[e] && (n.canvas.id = e), this
                },
                getId: function() {
                    return n.canvas.id
                },
                getWidth: function() {
                    return p
                },
                setWidth: function(e) {
                    return n.canvas.defaultWidth = e, c && (c.width = n.canvas.defaultWidth, c.style.width = c.width + "px", p = parseInt(c.width)), this
                },
                getHeight: function() {
                    return d
                },
                setHeight: function(e) {
                    return n.canvas.defaultHeight = e, c && (c.height = n.canvas.defaultHeight, c.style.height = c.height + "px", d = parseInt(c.height)), this
                },
                getDevice: function() {
                    return n.canvas.device
                },
                getFps: function() {
                    return n.canvas.fps
                },
                setFps: function(e) {
                    return e > 0 && (n.canvas.fps = e), this
                },
                getTouch: function() {
                    return n.canvas.touch
                },
                getZoom: function() {
                    return n.canvas.zoom
                }
            },
            fillStyle: function(e) {
                return s.fillStyle = e, this
            },
            fillRect: function(e, t, n, r, o) {
                return n = n ? n : 0, r = r ? r : 0, o ? f = i.getAnchor(e, t, n, r, o) : (f.x = e, f.y = t), s.fillRect(f.x, f.y, n, r), this
            },
            fillText: function(e, t, r, i) {
                return s.font = i || n.canvas.defaultFont, s.fillText(e, t, r), this
            },
            clearRect: function(e, t, n, r) {
                return s.clearRect(e, t, n, r), this
            },
            clearScreen: function() {
                return this.clearRect(0, 0, p, d)
            },
            fillScreen: function() {
                return this.fillRect(0, 0, p, d)
            },
            strokeStyle: function(e) {
                return s.strokeStyle = e, this
            },
            lineWidth: function(e) {
                return s.lineWidth = e || 1, this
            },
            strokeRect: function(e, t, n, r, o) {
                return o ? a = i.getAnchor(e, t, n, r, o) : (a.x = e, a.y = t), s.strokeRect(a.x, a.y, n, r), this
            },
            strokeText: function(e, t, r, i) {
                return s.font = i || n.canvas.defaultFont, s.strokeText(e, t, r), this
            },
            setColor: function(e, t, n) {
                return n == null ? (u.fillColor = e, u.strokeColor = t ? t : e) : (u.fillColor = "rgb(" + e + ", " + t + ", " + n + ")", u.strokeColor = u.fillColor), this.fillStyle(u.fillColor).strokeStyle(u.strokeColor)
            },
            drawImage: function(e, t, r, u, a, f, l, c, h, p) {
                var d = m.getImage(e);
                if (d.refreshed) this.drawCache(e, t, r, u, a, f, l, c, h, p);
                else if (d.src != null) c != null && (t = t < 0 ? 0 : t, c = c <= 0 ? .1 : c), h != null && (r = r < 0 ? 0 : r, h = h <= 0 ? .1 : h), u != null && c != null && (u = u <= 0 ? .1 : t + u <= d.width ? u : d.width - t), a != null && h != null && (a = a <= 0 ? .1 : r + a <= d.height ? a : d.height - r), d.loaded && (u ? a ? p ? (o = i.getAnchor(f, l, c, h, p), s.drawImage(d, t, r, u, a, o.x, o.y, c, h)) : s.drawImage(d, t, r, u, a, f, l, c, h) : (o = i.getAnchor(t, r, d.width, d.height, u), s.drawImage(d, o.x, o.y)) : s.drawImage(d, t, r));
                else {
                    var v = n.image.asyncImgObjs[e];
                    v && !v.inited && (i.setImage(v.id, v.src, v.benchId, v.bench, v.cache), v.inited = !0), v = null
                }
                return d = null, this
            },
            drawRotate: function(e, t, r, i, o, u, a, f, l, c) {
                var h = parseInt(f >> 1),
                    p = parseInt(l >> 1),
                    d = m.getImage(e),
                    v = d.src ? d : n.canvas.cavansDoms[e];
                return u -= h, a -= p, s.save(), s.translate(u + h, a + p), s.rotate(c * Math.PI / 180), s.translate(-(u + h), -(a + p)), s.drawImage(v, t, r, i, o, u, a, f, l), s.restore(), v = null, d = null, p = null, h = null, this
            },
            drawCache: function(e, t, r, u, a, f, l, c, h, p) {
                var d = n.canvas.cavansDoms[e];
                return d && (c != null && (t = t < 0 ? 0 : t, c = c <= 0 ? .1 : c), h != null && (r = r < 0 ? 0 : r, h = h <= 0 ? .1 : h), u != null && c != null && (u = u <= 0 ? .1 : t + u <= d.width ? u : d.width - t), a != null && h != null && (a = a <= 0 ? .1 : r + a <= d.height ? a : d.height - r), u ? a ? p ? (o = i.getAnchor(f, l, c, h, p), s.drawImage(d, t, r, u, a, o.x, o.y, c, h)) : s.drawImage(d, t, r, u, a, f, l, c, h) : (o = i.getAnchor(t, r, d.width, d.height, u), s.drawImage(d, o.x, o.y)) : s.drawImage(d, t, r)), d = null, this
            },
            drawRegion: function(e, t, n, i, o, u, a, f, l) {
                switch (u) {
                    case r.canvas.trans.TRANS_NONE:
                    default:
                        s.transform(1, 0, 0, 1, a, f);
                        break;
                    case r.canvas.trans.TRANS_ROT90:
                        s.transform(0, 1, -1, 0, o + a, f);
                        break;
                    case r.canvas.trans.TRANS_ROT180:
                        s.transform(-1, 0, 0, -1, i + a, o + f);
                        break;
                    case r.canvas.trans.TRANS_ROT270:
                        s.transform(0, -1, 1, 0, a, i + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR:
                        s.transform(-1, 0, 0, 1, i + a, f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT90:
                        s.transform(0, -1, -1, 0, o + a, i + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT180:
                        s.transform(1, 0, 0, -1, a, o + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT270:
                        s.transform(0, 1, 1, 0, a, f)
                }
                var c = m.getImage(e),
                    h = c.cache ? this.drawCache : this.drawImage;
                return h(e, t, n, i, o, 0, 0, i, o), s.setTransform(1, 0, 0, 1, 0, 0), h = null, c = null, this
            },
            drawRegionAndZoom: function(e, t, n, i, o, u, a, f, l, c, h) {
                switch (u) {
                    case r.canvas.trans.TRANS_NONE:
                    default:
                        s.transform(1, 0, 0, 1, a, f);
                        break;
                    case r.canvas.trans.TRANS_ROT90:
                        s.transform(0, 1, -1, 0, h + a, f);
                        break;
                    case r.canvas.trans.TRANS_ROT180:
                        s.transform(-1, 0, 0, -1, c + a, h + f);
                        break;
                    case r.canvas.trans.TRANS_ROT270:
                        s.transform(0, -1, 1, 0, a, c + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR:
                        s.transform(-1, 0, 0, 1, c + a, f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT90:
                        s.transform(0, -1, -1, 0, h + a, c + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT180:
                        s.transform(1, 0, 0, -1, a, h + f);
                        break;
                    case r.canvas.trans.TRANS_MIRROR_ROT270:
                        s.transform(0, 1, 1, 0, a, f)
                }
                var p = m.getImage(e),
                    d = p.cache ? this.drawCache : this.drawImage;
                return d(e, t, n, i, o, 0, 0, c, h), s.setTransform(1, 0, 0, 1, 0, 0), d = null, p = null, this
            },
            drawNumber: function(e, t, n, r, i, s, o, u, a) {
                var f = e.toString(),
                    l = f.length,
                    c = u ? u : n,
                    h = a ? a : r;
                if (o == "center") {
                    var d = i + parseInt(p - c * l >> 1);
                    for (var v = 0; v < l; v++) this.drawImage(t, parseInt(f.charAt(v)) * n, 0, n, r, d + v * c, s, c, h);
                    d = null
                } else if (o == 1)
                    for (var v = 0; v < l; v++) this.drawImage(t, parseInt(f.charAt(v)) * n, 0, n, r, i + v * c, s, c, h);
                else if (o == 0)
                    for (var v = l - 1; v >= 0; v--) this.drawImage(t, parseInt(f.charAt(v)) * n, 0, n, r, i - (l - 1 - v) * c, s, c, h, m.graphics.ANCHOR_RT);
                return h = null, c = null, l = null, f = null, this
            },
            moveTo: function(e, t) {
                return s.moveTo(e, t), this
            },
            lineTo: function(e, t) {
                return s.lineTo(e, t), this
            },
            stroke: function() {
                return s.stroke(), this
            },
            fill: function() {
                return s.fill(), this
            },
            beginPath: function() {
                return s.beginPath(), this
            },
            closePath: function() {
                return s.closePath(), this
            },
            arc: function(e, t, n, r, i, o) {
                return s.arc(e, t, n, r, i, o), this
            },
            quadraticCurveTo: function(e, t, n, r) {
                return s.quadraticCurveTo(e, t, n, r), this
            },
            bezierCurveTo: function(e, t, n, r, i, o) {
                return s.bezierCurveTo(e, t, n, r, i, o), this
            },
            measureText: function(e) {
                var t = s.measureText(e),
                    n = t.width,
                    r = t.height ? t.height : parseInt(s.font);
                return {
                    width: this.screen.getDevice() == "j2me" ? s.measureText(e) : n,
                    height: r
                }
            },
            translate: function(e, t) {
                return s.translate(e, t), this
            },
            drawLine: function(e, t, n, r) {
                return this.beginPath().moveTo(e, t).lineTo(n, r).closePath().stroke()
            },
            drawRect: function(e, t, n, r, i) {
                return this.strokeRect(e, t, n, r, i)
            },
            drawString: function(e, t, i, o, u, a, f, c) {
                l.x = t, l.y = i, s.font = c || n.canvas.defaultFont;
                if (o) switch (o) {
                    case r.canvas.graphics.LEFT:
                        l.x = 0;
                        break;
                    case r.canvas.graphics.VCENTER:
                        l.x = parseInt(this.screen.getWidth() - this.measureText(e).width >> 1);
                        break;
                    case r.canvas.graphics.RIGHT:
                        l.x = this.screen.getWidth() - this.measureText(e).width;
                        break;
                    default:
                }
                return u && (a ? l.fillStyle = a : l.fillStyle = "#000000", f ? l.strokeStyle = f : l.strokeStyle = "#CCCCCC", this.fillStyle(l.strokeStyle).fillText(e, l.x + 1, l.y + 1, c).fillStyle(l.fillStyle)), this.fillText(e, l.x, l.y, c).fillStyle(n.canvas.defaultColor)
            },
            drawSubstring: function(e, t, n, r, i, s, o, u, a, f) {
                return this.drawString(e.substring(t, t + n), r, i, s, o, u, a, f)
            },
            clip: function() {
                return s.clip(), this
            },
            save: function() {
                return s.save(), this
            },
            restore: function() {
                return s.restore(), this
            },
            rect: function(e, t, n, r) {
                return s.rect(e, t, n, r), this
            },
            rotate: function(e) {
                return s.rotate(e), this
            },
            setTransform: function(e, t, n, r, i, o) {
                return s.setTransform(e, t, n, r, i, o), this
            },
            scale: function(e, t) {
                return s.scale(e, t), this
            },
            globalAlpha: function(e) {
                return s.globalAlpha = e, this
            },
            getContext: function() {
                return s
            },
            base: function() {
                return m
            }
        },
        pushImage: function(e, t) {
            if (n.image.inited) return this;
            var r;
            for (var i = 0, s = e.length; i < s; i++) r = e[i], r && !n.image.initImgs[r.id] && (n.image.initImgs[r.id] = !0, n.image.imgObjs.push(e[i]));
            return this.loadingEndCallBack(t), r = null, this
        },
        loadImage: function(e, t) {
            if (n.system.gameFlow != r.system.gameFlowType.loadImage && e.length > 0) {
                n.system.loadedImageToGameFlow = n.system.gameFlow, n.system.gameFlow = r.system.gameFlowType.loadImage, n.image.imgObjs = e, n.image.imgCount = n.image.imgObjs.length, n.image.countLoaded = 0;
                for (var s = 0, o; o = n.image.imgObjs[s]; s++) n.image.imgs[o.id] ? n.image.countLoaded++ : i.setImage(o.id, o.src, o.benchId);
                this.loadingEndCallBack(t)
            }
            return this
        },
        asyncImage: function(e) {
            var t;
            for (var r = 0, i = e.length; r < i; r++) t = e[r] || {}, n.image.asyncImgObjs[t.id] || (n.image.asyncImgObjs[t.id] = t);
            return t = null, this
        },
        verImage: function(e) {
            return n.image.version == "" && (n.image.version = e), this
        },
        loadingCallBack: function(e) {
            return typeof e == "function" && (i.loadingCallBack = e), this
        },
        loadingEndCallBack: function(e) {
            return typeof e == "function" && (i.loadingEndCallBack = e), this
        },
        addImage: function(e, t) {
            return e && t && !n.image.imgs[e] && (n.image.imgs[e] = t), this
        },
        getImage: function(e) {
            return n.image.imgs[e] ? n.image.imgs[e] : {
                src: null
            }
        },
        delImage: function(e, t) {
            return n.image.imgs[e] && (n.image.imgs[e] = null, delete n.image.imgs[e], t && (n.image.imgs[e] = {
                id: e,
                loaded: !0,
                cache: !0,
                refreshed: !0
            })), this
        },
        getAsyncImage: function(e) {
            return n.image.asyncImgObjs[e] ? n.image.asyncImgObjs[e] : {
                src: null
            }
        },
        clearAsyncImageCache: function() {
            try {
                var e = n.image.imgs,
                    t, r;
                for (var i in e) t = e[i], t && (r = n.image.asyncImgObjs[i], r && (r.inited = !1, this.delImage(i).canvas.del(i)));
                e = t = r = null
            } catch (s) {}
            return this
        },
        audio: {
            play: function(e) {
                var t = n.audio.audios[e];
                if (t) try {
                    t.currentTime >= t.duration ? this.replay(e) : t.paused && t.play()
                } catch (r) {}
                return t = null, this
            },
            playRange: function(e, t, r) {
                var i = n.audio.audios[e];
                if (i) try {
                    i.__timeupdateCallBack__ || i.addEventListener("timeupdate", i.__timeupdateCallBack__ = function() {
                        this.currentTime >= this.__to__ && (this.loop ? this.currentTime = this.__from__ : this.pause())
                    }, !1), i.__from__ = t == null ? 0 : t, i.__to__ = r == null ? i.duration : r, this.setCurrentTime(i.id, i.__from__).play(i.id)
                } catch (s) {}
                return i = null, this
            },
            pause: function(e) {
                if (n.audio.audios[e]) try {
                    n.audio.audios[e].pause()
                } catch (t) {}
                return this
            },
            pauseAll: function() {
                for (var e in n.audio.audios) this.pause(e);
                return this
            },
            mute: function(e, t) {
                if (n.audio.audios[e]) try {
                    n.audio.audios[e].muted = t
                } catch (r) {}
            },
            vol: function(e, t) {
                if (n.audio.audios[e]) try {
                    n.audio.audios[e].volume = t
                } catch (r) {}
                return this
            },
            loop: function(e, t) {
                if (n.audio.audios[e]) try {
                    n.audio.audios[e].loop = t
                } catch (r) {}
                return this
            },
            replay: function(e) {
                return this.setCurrentTime(e, 0).play(e), this
            },
            setCurrentTime: function(e, t) {
                var r = n.audio.audios[e];
                if (r) try {
                    t < 0 ? t = 0 : t > r.duration && (t = r.duration), r.currentTime = t || 0
                } catch (i) {}
                return r = null, this
            },
            getAudio: function(e) {
                return n.audio.audios[e]
            },
            del: function(e) {
                var t = n.audio.audios[e];
                return t && t.__timeupdateCallBack__ && (t.pause(), t.removeEventListener("timeupdate", t.__timeupdateCallBack__, !1), n.audio.audios[e] = null, delete n.audio.audios[e]), t = null, this
            },
            base: function() {
                return m
            }
        },
        initAudio: function(e) {
            if (!window.Audio) return this;
            if (e.length > 0) {
                n.audio.audios = {};
                var t, r, s, o, u;
                for (var a = 0; a < e.length; a++) t = e[a], t && i.setAudio(t.id, t.src, t.loop, t.autoplay, t.preload, t.autobuffer);
                t = r = s = o = u = null
            }
            return this
        },
        setRunFrequency: function(e) {
            return n.system.timeout = e, this
        },
        events: {
            keyDown: function(e) {
                return n.event.keyDownGo || (n.event.keyDownGo = !0), n.event.keyUpGo || (n.event.keyUpGo = !0), n.event.keyPressedGo || (n.event.keyPressedGo = !0), n.event.keyDownCallBack = e, this
            },
            keyUp: function(e) {
                return n.event.keyDownGo || (n.event.keyDownGo = !0), n.event.keyUpGo || (n.event.keyUpGo = !0), n.event.keyPressedGo || (n.event.keyPressedGo = !0), n.event.keyUpCallBack = e, this
            },
            orientationChange: function(e) {
                return n.event.orientationChange = e, this
            },
            touchStart: function(e) {
                return n.event.touchStart = e, this
            },
            touchEnd: function(e) {
                return n.event.touchEnd = e, this
            },
            touchMove: function(e) {
                return n.event.touchMove = e, this
            },
            touchCancel: function(e) {
                return n.event.touchCancel = e, this
            },
            click: function(e) {
                return n.event.clickCallBack = e, this
            },
            mouseDown: function(e) {
                return n.event.mouseDownCallBack = e, this
            },
            mouseUp: function(e) {
                return n.event.mouseUpCallBack = e, this
            },
            mouseMove: function(e) {
                return n.event.mouseMoveCallBack = e, this
            },
            createEvent: function(e, t) {
                var n = document.getElementById(e);
                if (n) {
                    var r = document.createEvent("HTMLEvents");
                    r.initEvent(t, !1, !0), n.dispatchEvent(r), r = null
                }
                n = null
            },
            pageFocus: function(e) {
                return n.event.pageFocusCallBack = e, this
            },
            pageUnFocus: function(e) {
                return n.event.pageUnFocusCallBack = e, this
            },
            swipe: function(e, t, r) {
                n.event.swipeCallBack = e, t != null && (n.event.swipeTimeout = t), r != null && (n.event.swipeRange = r)
            },
            base: function() {
                return m
            }
        },
        ui: {},
        graphics: {
            HCENTER: r.canvas.graphics.HCENTER,
            VCENTER: r.canvas.graphics.VCENTER,
            LEFT: r.canvas.graphics.LEFT,
            RIGHT: r.canvas.graphics.RIGHT,
            TOP: r.canvas.graphics.TOP,
            BOTTOM: r.canvas.graphics.BOTTOM
        },
        trans: {
            TRANS_NONE: r.canvas.trans.TRANS_NONE,
            TRANS_ROT90: r.canvas.trans.TRANS_ROT90,
            TRANS_ROT180: r.canvas.trans.TRANS_ROT180,
            TRANS_ROT270: r.canvas.trans.TRANS_ROT270,
            TRANS_MIRROR: r.canvas.trans.TRANS_MIRROR,
            TRANS_MIRROR_ROT90: r.canvas.trans.TRANS_MIRROR_ROT90,
            TRANS_MIRROR_ROT180: r.canvas.trans.TRANS_MIRROR_ROT180,
            TRANS_MIRROR_ROT270: r.canvas.trans.TRANS_MIRROR_ROT270
        },
        request: {
            init: function() {
                i.initUrlParams(window.leiyooHref ? window.leiyooHref : location.href)
            },
            get: function(e) {
                return n.request.gets[e] ? n.request.gets[e] : ""
            }
        },
        buttonLayout: {
            create: function(e) {
                var t = this.base().objExtend({
                    id: "",
                    value: "",
                    x: 0,
                    y: 0,
                    width: 60,
                    height: 30,
                    bgColor: "#000",
                    bgStroke: "#FFF",
                    stroke: "#000",
                    font: "12px Arial",
                    imageId: "",
                    sx: 0,
                    sy: 0,
                    color: "#FFF",
                    hx: 0,
                    hy: 0,
                    hColor: "#0FF",
                    dex: 0,
                    dey: 0,
                    deColor: "#CCC",
                    hided: !1,
                    disabled: !1,
                    path: []
                }, e || {});
                return this.get(t.id) || n.buttonLayout.buttons.push(new n.buttonLayout.Button(t)), t = null, this
            },
            destroy: function(e) {
                var t = n.buttonLayout.buttons,
                    r;
                for (var i = t.length - 1; i >= 0; i--)
                    if (r = t[i])
                        if (r.id == e) {
                            r.disposed(), t.splice(i, 1);
                            break
                        }
                return t = r = null, this
            },
            clear: function() {
                var e = n.buttonLayout.buttons,
                    t;
                for (var r = e.length - 1; r >= 0; r--)
                    if (t = e[r]) t.disposed(), e.splice(r, 1);
                return e = t = null, this
            },
            gone: function(e, t, n) {
                var r = this.get(e);
                if (r) {
                    var i = t || [];
                    r.gone(i, n), i = null
                }
                return r = null, this
            },
            get: function(e) {
                var t = n.buttonLayout.buttons;
                return t[t.indexOfAttr("id", e)]
            },
            show: function(e) {
                var t = this.get(e);
                return t && t.show(), t = null, this
            },
            hide: function(e) {
                var t = this.get(e);
                return t && t.hide(), t = null, this
            },
            disable: function(e, t) {
                var n = this.get(e);
                return n && n.disable(t), n = null, this
            },
            repeated: function(e) {
                var t = this.get(e);
                if (t) return t.repeated
            },
            pressed: function(e) {
                var t = this.get(e);
                if (t) {
                    var n = t.pressed;
                    return t.pressed = !1, n
                }
            },
            released: function(e) {
                var t = this.get(e);
                if (t) {
                    var n = t.released;
                    return t.released = !1, n
                }
            },
            base: function() {
                return m
            }
        }
    }.init();
    var m = jsGame = link,
        g = document.getElementsByTagName("head")[0],
        y = null,
        b = null,
        w = null,
        E = null,
        S = function() {
            b && (clearTimeout(b), b = null)
        };
    link.getScript = function(e) {
        if (!g || y) return !1;
        var t = m.objExtend({
            url: "",
            before: function() {},
            success: function() {},
            error: function(e) {},
            timeout: 5e3,
            contentType: "text/javascript",
            destroyed: !0
        }, e || {});
        return t.url != "" && (t.before(), y = document.createElement("script"), y.type = t.contentType, y.async = !0, y.src = t.url, y.destroyed = t.destroyed, w = t.success, E = t.error, y.onload = function() {
            S(), w && (w(), w = null), this.destroyed && g.removeChild(this), y = null
        }, g.appendChild(y), S(), b = setTimeout(function() {
            S(), E && (E("timeout"), E = null), y && y.destroyed && g.removeChild(y), y = null
        }, t.timeout)), t = null, m
    };
    var x = function() {
        return ((1 + Math.random()) * 65536 | 0).toString(16).substring(1)
    };
    link.getNewGuid = function() {
        return x() + x() + "-" + x() + "-" + x() + "-" + x() + "-" + x() + x() + x()
    }, link.classes.Observer = function() {
        this.group = []
    }, link.classes.Observer.prototype.register = function(e) {
        if (e == null) return this;
        var t = m.comm.inArray(e, this.group);
        return t == -1 && this.group.push(e), this
    }, link.classes.Observer.prototype.unregister = function(e) {
        if (e == null) return this;
        var t = m.commandFuns.inArray(e, this.group);
        return t > -1 && this.group.splice(t, 1), this
    }, link.classes.Observer.prototype.notify = function(e) {
        for (var t = 0; t < this.group.length; t++) this.group[t] != null && this.group[t](e);
        return this
    }, link.classes.Observer.prototype.clear = function() {
        return this.group.length > 0 && this.group.splice(0, this.group.length), this
    }, link.classes.Timer = function(e, t, n, r, i) {
        this.id = e, this._initTime = t, this._dateTime = Date.now(), this.time = this._initTime, this.callBack = n, this.millisec = r || 1e3, this.data = i, this.timeout = null
    }, link.classes.Timer.prototype.stop = function() {
        this.timeout && (clearTimeout(this.timeout), this.timeout = null)
    }, link.classes.Timer.prototype.start = function(e) {
        e && (this.time = this._initTime, this._dateTime = Date.now()), this.stop(), this.timeout = setTimeout(function(e) {
            var t = Date.now(),
                n = parseInt(Math.round((t - e._dateTime) / e.millisec));
            e._dateTime = t, e.time -= n, e.callBack ? e.callBack(e) : e.stop(), e.time >= 0 ? e.start() : (e.stop(), e.time = 0), t = n = null
        }, this.millisec, this)
    }, link.classes.WebSocket = function(e, t, n, r, i) {
        this.ipPort = e || "", this.socket = new WebSocket(this.ipPort), this.socket.onopen = t, this.socket.onmessage = n, this.socket.onclose = r, this.socket.onerror = i
    }, link.classes.WebSocket.prototype.send = function(e) {
        this.socket.send(e)
    }, link.classes.WebSocket.prototype.close = function() {
        this.socket.close()
    }, link.classes.observer = link.classes.Observer, link.classes.timer = link.classes.Timer, link.classes.webSocket = link.classes.websocket = link.classes.WebSocket, link.commandFuns = link.comm, link.commandFuns.collisionCheck = link.commandFuns.collision, link.commandFuns.circleCollisionCheck = link.commandFuns.circleCollision, link.initImage = link.pushImage, typeof define == "function" && define("lib/link", [], function() {
        return link
    })
})(), require.config({
    baseUrl: "js"
}), require(["lib/link"], function(e) {
    var t = navigator.userAgent.toLowerCase(),
        n = !1;
    t.indexOf("android") >= 0 && t.indexOf("chrome") >= 0 && (n = !0), n || e.init(320, 480).main(function() {
        var t, n;
        e.canvas.screen.setHeight(window.innerHeight > 480 ? 480 : window.innerHeight), t = e.canvas.screen.getWidth(), n = e.canvas.screen.getHeight(), _newDate = Date.now();
        var r = {
                tileW: t >> 1,
                tileH: ~~(n / 3) + 1,
                states: "mainMenu",
                endMenuProps: null,
                mainMenuList: [ {
                    id: "btn5",
                    name: "极速",
                    bgColor: "#FFF",
                    color: "#000",
                    onClick: function() {
                        r.mainMenuGone(), i.start(4)
                    }
                }],
                createStaticsBtns: function() {
                    var t;
                    for (var n = 0; n < 3; n++)(t = this.mainMenuList[n]) && e.buttonLayout.create({
                        id: t.id,
                        value: t.name,
                        x: 0,
                        y: n * this.tileH,
                        width: this.tileW,
                        height: this.tileH,
                        bgColor: t.bgColor,
                        bgStroke: "",
                        color: t.color,
                        hColor: t.color,
                        stroke: "",
                        font: "28px 微软雅黑"
                    });
                    for (var n = 3; n < 6; n++)(t = this.mainMenuList[n]) && e.buttonLayout.create({
                        id: t.id,
                        value: t.name,
                        x: this.tileW,
                        y: (n - 3) * this.tileH,
                        width: this.tileW,
                        height: this.tileH,
                        bgColor: t.bgColor,
                        bgStroke: "",
                        color: t.color,
                        hColor: t.color,
                        stroke: "",
                        font: "28px 微软雅黑"
                    });
                    return this
                },
                createAnimationBtns: function() {
                    var n;
                    for (var r = 0; r < 3; r++)(n = this.mainMenuList[r]) && e.buttonLayout.create({
                        id: n.id,
                        value: n.name,
                        x: (r + 1) * -this.tileW,
                        y: r * this.tileH,
                        path: e.comm.createPath((r + 1) * -this.tileW, r * this.tileH, 0, r * this.tileH, 20),
                        width: this.tileW,
                        height: this.tileH,
                        bgColor: n.bgColor,
                        bgStroke: "",
                        color: n.color,
                        hColor: n.color,
                        stroke: "",
                        font: "28px 微软雅黑"
                    });
                    for (var r = 3; r < 6; r++)(n = this.mainMenuList[r]) && e.buttonLayout.create({
                        id: n.id,
                        value: n.name,
                        x: t + (r - 3) * this.tileW,
                        y: (r - 3) * this.tileH,
                        path: e.comm.createPath(t + (r - 3) * this.tileW, (r - 3) * this.tileH, this.tileW, (r - 3) * this.tileH, 20),
                        width: this.tileW,
                        height: this.tileH,
                        bgColor: n.bgColor,
                        bgStroke: "",
                        color: n.color,
                        hColor: n.color,
                        stroke: "",
                        font: "28px 微软雅黑"
                    });
                    return this
                },
                mainMenuAcion: function() {
                    if (this.states != "mainMenu") return this;
                    for (var t = 0, n; n = this.mainMenuList[t]; t++) e.buttonLayout.pressed(n.id) && n.onClick();
                    return this
                },
                goToMainMenu: function(t) {
                	//alert('goToMainMenu')
                    return this.states = "mainMenu", e.gameFlow.menu(), e.buttonLayout.clear(), t ? this.createAnimationBtns() : this.createStaticsBtns(), this
                },
                mainMenuGone: function() {
                    var n;
                    for (var r = 0; r < 3; r++)(n = this.mainMenuList[r]) && e.buttonLayout.gone(n.id, e.comm.createPath(0, r * this.tileH, -this.tileW, r * this.tileH, 20), r * 200);
                    for (var r = 3; r < 6; r++)(n = this.mainMenuList[r]) && e.buttonLayout.gone(n.id, e.comm.createPath(this.tileW, (r - 3) * this.tileH, t, (r - 3) * this.tileH, 20), (r - 3) * 200);
                    return this.endMenuProps = null, this
                },
                gotoEndMenu: function(r) {
                    var i = e.objExtend({
                        gameModule: 0,
                        record: 0,
                        x: 0,
                        y: 0,
                        path: [],
                        scales: [.4, .6, .8, .85, .9, .92, .94, .96, .98, 1],
                        bgColor: "#F00",
                        titleFont: "35px 微软雅黑",
                        titleColor: "#FFF",
                        title: "title",
                        desc1Font: "40px 微软雅黑",
                        desc1Color: "#000",
                        desc1: "desc1",
                        desc2Font: "25px 微软雅黑",
                        desc2Color: "#000",
                        desc2: "desc2"
                    }, r || {});
                    this.states = "endMenu", e.gameFlow.menu(), e.buttonLayout.create({
                        id: "back",
                        value: "",
                        x: 72,
                        y: n - 150,
                        width: 60,
                        height: 33,
                        bgColor: "",
                        bgStroke: ""
                    }), e.buttonLayout.create({
                        id: "restart",
                        value: "",
                        x: 195,
                        y: n - 150,
                        width: 60,
                        height: 33,
                        bgColor: "",
                        bgStroke: ""
                    }), e.buttonLayout.create({
                        id: "share",
                        value: "",
                        x: 72,
                        y: n - 70,
                        width: 60,
                        height: 33,
                        bgColor: "",
                        bgStroke: ""
                    }), e.buttonLayout.create({
                        id: "moregames",
                        value: "",
                        x: 170,
                        y: n - 70,
                        width: 120,
                        height: 33,
                        bgColor: "",
                        bgStroke: ""
                    });
                    var s = n - 600 >> 1;
                    //alert('gotoEndMenu'+i.record+'             '+this.touchTimes2);
                    //alert('gotoEndMenu'+i.record+'             '+this.touchTimes);
                    
                    score=i.record;
                    post_result();
                    return this.endMenuProps = i, this.endMenuProps.titleX = t - e.canvas.font(this.endMenuProps.titleFont).measureText(this.endMenuProps.title).width >> 1, this.endMenuProps.titleY = s + 130, this.endMenuProps.desc1X = t - e.canvas.font(this.endMenuProps.desc1Font).measureText(this.endMenuProps.desc1).width >> 1, this.endMenuProps.desc1Y = s + 230, this.endMenuProps.desc2X = t - e.canvas.font(this.endMenuProps.desc2Font).measureText(this.endMenuProps.desc2).width >> 1, this.endMenuProps.desc2Y = s + 310, this.endMenuProps.zoom = 1, updateShareScore(i.gameModule, i.record), i = s = null, this
                },
                endMenuAction: function() {
                	//alert('endMenuAction');
                    if (this.states != "endMenu") return this;
                    this.endMenuProps.scales.length > 0 && (this.endMenuProps.zoom = this.endMenuProps.scales.shift());
                    if (this.endMenuProps.path.length > 0) {
                        var t = this.endMenuProps.path.shift();
                        this.endMenuProps.x += t[0], this.endMenuProps.y += t[1], t = null
                    }
                    return e.buttonLayout.pressed("back") ? r.goToMainMenu(!0) : e.buttonLayout.pressed("restart") ? (e.buttonLayout.clear(), i.start(this.endMenuProps.gameModule)) : e.buttonLayout.pressed("share") ? setTimeout(function() {
                        show_share()
                    }, 500) : e.buttonLayout.pressed("moregames") && goHome(), this
                },
                endMenuRender: function() {
                	//alert('endMenuRender');
                    return this.endMenuProps && (this.endMenuProps.zoom != 0 && e.canvas.save().translate(t >> 1, n >> 1).scale(this.endMenuProps.zoom, this.endMenuProps.zoom).translate(-(t >> 1), -(n >> 1)), e.canvas.fillStyle(this.endMenuProps.bgColor).fillRect(this.endMenuProps.x, this.endMenuProps.y, t, n).fillStyle(this.endMenuProps.titleColor).font(this.endMenuProps.titleFont).fillText(this.endMenuProps.title, this.endMenuProps.x + this.endMenuProps.titleX, this.endMenuProps.y + this.endMenuProps.titleY).fillStyle(this.endMenuProps.desc1Color).font(this.endMenuProps.desc1Font).fillText(this.endMenuProps.desc1, this.endMenuProps.x + this.endMenuProps.desc1X, this.endMenuProps.y + this.endMenuProps.desc1Y).fillStyle(this.endMenuProps.desc2Color).font(this.endMenuProps.desc2Font).fillText(this.endMenuProps.desc2, this.endMenuProps.x + this.endMenuProps.desc2X, this.endMenuProps.y + this.endMenuProps.desc2Y).font("25px 微软雅黑").fillStyle("#FFF").fillText("返回", this.endMenuProps.x + 80, this.endMenuProps.y + n - 130).fillText("重来", this.endMenuProps.x + 200, this.endMenuProps.y + n - 130).fillText("炫耀", this.endMenuProps.x + 80, this.endMenuProps.y + n - 50).fillText("更多游戏", this.endMenuProps.x + 175, this.endMenuProps.y + n - 50), this.endMenuProps.zoom != 0 && e.canvas.restore()), this
                }
            },
            i = {
                gameModuleStrs: ["经典模式", "禅模式", "接力模式", "街机模式", "极速模式"],
                gameModule: 0,
                states: "normal",
                recordGameModule0: 0,
                dateGameModule0: null,
                recordGameModule1: 0,
                dateGameModule1: null,
                recordGameModule2: 0,
                dateGameModule2: null,
                dateGameModule3: null,
                recordGameModule4: 0,
                dateGameModule4: null,
                shownTut0: false,
                shownTut1: false,
                shownTut2: false,
                shownTut3: false,
                shownTut4: false,
                touchTimes2: 0,
                topTitle: "",
                topTitleColor: "#F00",
                topTitleColorPath: [],
                tileW: ~~(t / 4),
                tileH: ~~(n / 4),
                tiles: [],
                touchedWhite: !1,
                touchedBlack: !1,
                touchTimesColor: "",
                touchTimes: 0,
                touchRowNum: 0,
                rowNum: 0,
                maxTouchTimes: 0,
                fallNum: 1e7,
                fallSpeed: 0,
                screenY: 0,
                curTile: null,
                Tile: e.extend(function(t) {
                    this.x = t.x, this.y = t.y, this.width = t.width, this.height = t.height, this.rowNum = t.rowNum, this.type = t.type, this.type == 0 ? this.bgColor = "#FFF" : this.type == 1 ? this.bgColor = "#333" : this.bgColor = t.bgColor || "", this.strokeColor = t.strokeColor, this.value = t.value || "";
                    var n = e.canvas.font("20px 微软雅黑").measureText(this.value);
                    this._valueX = this.width - n.width >> 1, this._valueY = this.height + n.height >> 1, this.path = t.path || [], this._colorPath = [], this._color = null, this._colorX = null, this._colorY = null, this._colorW = null, this._colorH = null, this.touched = !1, n = null
                }, null, {
                    setPath: function(e) {
                        return this.path = e, this
                    },
                    setColorPath: function(e) {
                        return this._colorPath = e, this
                    },
                    endPath: function() {
                        return this.path.length == 0
                    },
                    endColorPath: function() {
                        return this._colorPath.length == 0
                    },
                    move: function(e, t) {
                        var n = e || 0,
                            r = t || 0;
                        return this.x += n, this.y += r, n = r = null, this
                    },
                    collision: function(t, n) {
                        if (this._color != null) return !1;
                        var r = e.comm.collision(this.x, this.y, this.width, this.height, t, n, 1, 1);
                        return r && (this.type == 0 ? this._colorPath = [
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#FFF", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height],
                            ["#F00", this.width, this.height]
                        ] : this.type == 1 && (this._colorPath = [
                            ["#CCC", ~~(this.width * .5), ~~(this.height * .5)],
                            ["#CCC", ~~(this.width * .7), ~~(this.height * .7)],
                            ["#CCC", ~~(this.width * .9), ~~(this.height * .9)],
                            ["#CCC", this.width, this.height]
                        ]), this.touched = !0), r
                    },
                    action: function() {
                        if (this.path.length > 0) {
                            var e = this.path.shift();
                            this.x += e[0], this.y += e[1]
                        }
                        if (this._colorPath.length > 0) {
                            var t = this._colorPath.shift();
                            this._color = t[0], this._colorW = t[1], this._colorH = t[2], this._colorX = this.width - this._colorW >> 1, this._colorY = this.height - this._colorH >> 1, t = null
                        }
                        return this
                    },
                    render: function() {
                        return this.strokeColor != null && e.canvas.strokeStyle(this.strokeColor).strokeRect(this.x, this.y, this.width, this.height), e.canvas.fillStyle(this.bgColor).fillRect(this.x, this.y, this.width, this.height), this.vaule != "" && e.canvas.font("20px 微软雅黑").fillStyle("#FFF").fillText(this.value, this.x + this._valueX, this.y + this._valueY), this._color != null && (e.canvas.fillStyle(this._color).fillRect(this.x + this._colorX, this.y + this._colorY, this._colorW, this._colorH), _colorNode = null), this
                    }
                }),
                init: function(e) {
                    this.states = "normal", this.gameModule = e || 0, this.tiles.length = 0, this.curTile = null, this.touchTimes = 0, this.touchRowNum = 0, this.rowNum = 0, this.fallNum = 1e8, this.fallSpeed = 0, this.topTitle = "", this.topTitleColorPath = [], this.screenY = 0;
                    switch (this.gameModule) {
                        case 0:
                            this.fallNum = 47, this.maxTouchTimes = 50, this.recordGameModule0 = 0, this.dateGameModule0 = null, this.topTitleColor = "#F00", this.topTitle = this.getRecordGameModuleStr(this.recordGameModule0) + '"';
                            break;
                        case 1:
                            this.recordGameModule1 = 3e4, this.dateGameModule1 = null, this.topTitleColor = "#0F0", this.topTitle = this.getRecordGameModuleStr(this.recordGameModule1) + '"';
                            break;
                        case 2:
                            this.touchTimes2 = 0, this.recordGameModule2 = 1e4, this.maxTouchTimes = 30, this.dateGameModule1 = null, this.topTitleColor = "#0F0", this.topTitle = this.getRecordGameModuleStr(this.recordGameModule2) + '"';
                            break;
                        case 3:
                            this.fallSpeed = 9, this.topTitle = "00", this.topTitleColor = "#F00";
                            break;
                        case 4:
                            this.fallSpeed = 9, this.recordGameModule4 = 0, this.topTitle = "0.00/s", this.topTitleColor = "#F00";
                            break;
                        default:
                    }
                    return this.releaseTouched(), this.addRow({
                        type: 0,
                        bgColor: "#FF0"
                    }), this.addRow({
                        type: 2
                    }), this.addRow({
                        type: 1
                    }), this.addRow({
                        type: 1
                    }), this.addRow({
                        type: 1
                    }), this.addRow({
                        type: 1
                    }), this
                },
                addRow: function(t) {
                    var r = e.objExtend({
                            type: 0,
                            bgColor: "",
                            strokeColor: "#000"
                        }, t || {}),
                        i = [],
                        s = e.comm.getRandom(0, 3),
                        o, u = "",
                        a = "",
                        f = this.rowNum++;
                    for (var l = 0; l < 4; l++) r.type == 0 ? (o = 2, u = r.bgColor) : r.type == 1 ? o = s == l ? 1 : 0 : (o = s == l ? 1 : 0, a = s == l ? "开始" : 0), i.push(new this.Tile({
                        x: l * this.tileW,
                        y: n - (this.tiles.length + 1) * this.tileH + this.screenY % this.tileH,
                        width: this.tileW,
                        height: this.tileH,
                        rowNum: f,
                        type: o,
                        bgColor: u,
                        strokeColor: r.strokeColor,
                        value: a,
                        path: []
                    }));
                    return this.tiles.push(i), r = i = s = o = u = a = f = null, this
                },
                removeRow: function() {
                    return this.tiles.shift(), this
                },
                tilesFallOneRow: function() {
                    for (var t = 0, n; n = this.tiles[t]; t++)
                        for (var r = 0, i; i = n[r]; r++) i.setPath(e.comm.createPath(i.x, i.y, i.x, i.y + i.height, 70));
                    return this.fallNum--, this
                },
                tilesBackOneRow: function() {
                    for (var t = 0, n; n = this.tiles[t]; t++)
                        for (var r = 0, i; i = n[r]; r++) i.setPath(e.comm.createPath(i.x, i.y, i.x, i.y - i.height, 70));
                    return this
                },
                tilesFall: function(e) {
                    for (var t = 0, n; n = this.tiles[t]; t++)
                        for (var r = 0, i; i = n[r]; r++) i.move(0, e);
                    return this.screenY += e, this
                },
                touchStart: function(e, t) {
                    if (this.curTile && !this.curTile.endPath()) return this;
                    for (var n = 0, r; r = this.tiles[n]; n++)
                        for (var i = 0, s; s = r[i]; i++)
                            if (s.type < 2 && this.touchRowNum + 1 == s.rowNum && s.collision(e, t)) return this.touchRowNum++, s.type == 0 ? this.touchedWhite = !0 : s.type == 1 && (this.touchedBlack = !0, this.touchTimes++), this.curTile = s, this;
                    return this
                },
                getRecordGameModuleStr: function(e) {
                    var t = e % 1e3,
                        n;
                    return t < 10 ? t = "00" + t : t < 100 && (t = "0" + t), n = ~~(e / 1e3) + "." + t, n
                },
                compRecords: function(e, t) {
                    var n = e || "0.000",
                        r = n.split("."),
                        i = t || "0.000",
                        s = i.split("."),
                        o = ~~r[0] + r[1] * .001,
                        u = ~~s[0] + s[1] * .001;
                    return o > u || n == "0.000" ? !0 : !1
                },
                action: function() {
                    for (var t = 0, i; i = this.tiles[t]; t++)
                        for (var s = 0, o; o = i[s]; s++) o.action();
                    switch (this.states) {
                        case "normal":
                            if (this.tiles[0][0].y >= n) {
                                var u = !1;
                                for (var t = 0, o; o = this.tiles[0][t]; t++) {
                                    if (o.type == 2 || o.touched) {
                                        u = !0;
                                        break
                                    }
                                    o.type == 1 && !o.touched && (this.curTile = o)
                                }
                                u ? this.fallNum > 0 ? this.removeRow().addRow({
                                    type: 1
                                }) : this.removeRow().addRow({
                                    type: 0,
                                    bgColor: "#00DD58",
                                    strokeColor: null
                                }) : (this.states = "back", this.fallSpeed = 0, this.tilesBackOneRow(), this.dateGameModule3 = null, this.dateGameModule4 = null)
                            }
                            break;
                        case "back":
                            this.curTile && this.curTile.endPath() && (this.curTile.setColorPath([
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#CCC", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH],
                                ["#000", this.tileW, this.tileH]
                            ]), this.states = "end");
                            break;
                        case "end":
                            if (this.curTile && this.curTile.endColorPath())
                                if (this.gameModule == 3) {
                                    var a = parseInt(e.localStorage.getItem("TouchTimesGameModule3") || 0),
                                        f;
                                    this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule3", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                        gameModule: 3,
                                        record: this.touchTimes,
                                        bgColor: "#000",
                                        desc1Color: "#FFF",
                                        desc2Color: "#FFF",
                                        title: this.gameModuleStrs[this.gameModule],
                                        desc1: this.touchTimes,
                                        desc2: f
                                    }), a = f = null, this.states = ""
                                } else if (this.gameModule == 4) {
                                var l = e.localStorage.getItem("RecordGameModule4") || 0,
                                    f;
                                l = l * 1e3 / 1e3, this.recordGameModule4 > l || l == 0 ? (e.localStorage.setItem("RecordGameModule4", this.recordGameModule4), f = "新纪录") : f = "最佳 " + l + "/s", r.gotoEndMenu({
                                    gameModule: 4,
                                    record: this.recordGameModule4 + "/s",
                                    bgColor: "#000",
                                    desc1Color: "#FFF",
                                    desc2Color: "#FFF",
                                    title: this.gameModuleStrs[this.gameModule],
                                    desc1: this.recordGameModule4 + "/s",
                                    desc2: f
                                }), this.dateGameModule4 = l = f = null, this.states = ""
                            }
                            break;
                        default:
                    }
                    if (this.curTile) switch (this.gameModule) {
                        case 0:
                            this.touchedBlack ? (this.tilesFallOneRow(), this.dateGameModule0 || (this.dateGameModule0 = Date.now()), this.releaseTouched()) : this.touchedWhite && (this.dateGameModule0 = null, this.curTile.endColorPath() && r.gotoEndMenu({
                                gameModule: 0,
                                record: "",
                                title: this.gameModuleStrs[this.gameModule],
                                desc1: "败了!",
                                desc2: e.localStorage.getItem("RecordGameModule0") != null ? "最佳 " + (e.localStorage.getItem("RecordGameModule0") || "0.000") + '"' : ""
                            }));
                            if (this.fallNum <= -3) {
                                var f;
                                this.compRecords(e.localStorage.getItem("RecordGameModule0"), this.getRecordGameModuleStr(this.recordGameModule0)) ? (e.localStorage.setItem("RecordGameModule0", this.getRecordGameModuleStr(this.recordGameModule0)), f = "新纪录") : f = "最佳 " + (e.localStorage.getItem("RecordGameModule0") || "0.000") + '"', r.gotoEndMenu({
                                    gameModule: 0,
                                    record: this.getRecordGameModuleStr(this.recordGameModule0) + '"',
                                    bgColor: "#00DD58",
                                    y: -this.tileH * 2,
                                    path: e.comm.createPath(0, 0, 0, this.tileH * 2, 60),
                                    scales: [],
                                    title: this.gameModuleStrs[this.gameModule],
                                    desc1: this.getRecordGameModuleStr(this.recordGameModule0) + '"',
                                    desc2: f
                                }), f = null
                            }
                            this.shownTut0 = true;
                            this.dateGameModule0 && (this.recordGameModule0 = Date.now() - this.dateGameModule0), this.topTitle = this.getRecordGameModuleStr(this.recordGameModule0) + '"', this.touchTimesColor = "rgba(" + ~~(256 - 100 * (this.touchTimes / this.maxTouchTimes)) + "," + ~~(256 * (this.touchTimes / this.maxTouchTimes)) + ", 0, 1)";
                            break;
                        case 1:
                            if (this.recordGameModule1 > 0) {
                                this.shownTut1 = true;
                                if (this.touchedBlack) this.tilesFallOneRow(), this.dateGameModule1 || (this.dateGameModule1 = Date.now()), this.releaseTouched();
                                else if (this.touchedWhite) {
                                    this.dateGameModule1 = null;
                                    if (this.curTile.endColorPath()) {
                                        var a = parseInt(e.localStorage.getItem("TouchTimesGameModule1") || 0),
                                            f;
                                        this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule1", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                            gameModule: 1,
                                            record: this.touchTimes,
                                            title: this.gameModuleStrs[this.gameModule],
                                            desc1: this.touchTimes,
                                            desc2: f
                                        }), a = f = null
                                    }
                                }
                                if (this.dateGameModule1) {
                                    var c = Date.now();
                                    this.recordGameModule1 -= c - this.dateGameModule1, this.dateGameModule1 = c, c = null
                                }
                                this.topTitle = this.getRecordGameModuleStr(this.recordGameModule1) + '"', this.recordGameModule1 > 2e4 ? this.topTitleColor = "#0F0" : this.recordGameModule1 > 1e4 ? this.topTitleColor = "#FF9900" : this.topTitleColor = "#F00"
                            } else {
                                this.recordGameModule1 = 0, this.topTitle = "时间到";
                                if (this.topTitleColorPath.length == 0) this.topTitleColorPath = ["#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00"];
                                else {
                                    this.topTitleColor = this.topTitleColorPath.shift();
                                    if (this.topTitleColorPath.length == 0) {
                                        var a = parseInt(e.localStorage.getItem("TouchTimesGameModule1") || 0),
                                            f;
                                        this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule1", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                            gameModule: 1,
                                            record: this.touchTimes,
                                            bgColor: "#AAA",
                                            title: this.gameModuleStrs[this.gameModule],
                                            desc1: this.touchTimes,
                                            desc2: f
                                        }), a = f = null
                                    }
                                }
                            }
                            break;
                        case 2:
                            if (this.recordGameModule2 > 0) {
                                this.shownTut2 = true;
                                if (this.touchedBlack) this.tilesFallOneRow(), this.dateGameModule2 || (this.dateGameModule2 = Date.now()), this.touchTimes2++, this.releaseTouched();
                                else if (this.touchedWhite) {
                                    this.dateGameModule2 = null;
                                    if (this.curTile.endColorPath()) {
                                        var a = parseInt(e.localStorage.getItem("TouchTimesGameModule2") || 0),
                                            f;
                                        this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule2", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                            gameModule: 2,
                                            record: this.touchTimes,
                                            title: this.gameModuleStrs[this.gameModule],
                                            desc1: this.touchTimes,
                                            desc2: f
                                        }), a = f = null
                                    }
                                }
                                if (this.dateGameModule2) {
                                    var c = Date.now();
                                    this.recordGameModule2 -= c - this.dateGameModule2, this.dateGameModule2 = c, c = null
                                }
                                this.topTitle = this.getRecordGameModuleStr(this.recordGameModule2) + '"', this.recordGameModule2 > 5e3 ? this.topTitleColor = "#0F0" : this.recordGameModule2 > 2e3 ? this.topTitleColor = "#FF9900" : this.topTitleColor = "#F00", this.touchTimesColor = "rgba(" + ~~(256 - 100 * (this.touchTimes2 / this.maxTouchTimes)) + "," + ~~(256 * (this.touchTimes2 / this.maxTouchTimes)) + ", 0, 1)", this.touchTimes2 >= this.maxTouchTimes && (this.touchTimes2 = 0, this.recordGameModule2 = 1e4, this.dateGameModule1 = Date.now())
                            } else {
                                this.recordGameModule2 = 0, this.topTitle = "时间到";
                                if (this.topTitleColorPath.length == 0) this.topTitleColorPath = ["#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#FFF", "#FFF", "#FFF", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00", "#F00"];
                                else {
                                    this.topTitleColor = this.topTitleColorPath.shift();
                                    if (this.topTitleColorPath.length == 0) {
                                        var a = parseInt(e.localStorage.getItem("TouchTimesGameModule2") || 0),
                                            f;
                                        this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule2", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                            gameModule: 2,
                                            record: this.touchTimes,
                                            bgColor: "#AAA",
                                            title: this.gameModuleStrs[this.gameModule],
                                            desc1: this.touchTimes,
                                            desc2: f
                                        }), a = f = null
                                    }
                                }
                            }
                            break;
                        case 3:
                            if (this.touchedBlack) this.dateGameModule3 || (this.dateGameModule3 = Date.now()), this.releaseTouched();
                            else if (this.touchedWhite) {
                                this.dateGameModule3 = null;
                                if (this.curTile.endColorPath()) {
                                    var a = parseInt(e.localStorage.getItem("TouchTimesGameModule3") || 0),
                                        f;
                                    this.touchTimes > a ? (e.localStorage.setItem("TouchTimesGameModule3", this.touchTimes), f = "新纪录") : f = "最佳 " + a, r.gotoEndMenu({
                                        gameModule: 3,
                                        record: this.touchTimes,
                                        title: this.gameModuleStrs[this.gameModule],
                                        desc1: this.touchTimes,
                                        desc2: f
                                    }), a = f = null
                                }
                            }
                            this.shownTut3 = true;
                            this.fallSpeed += .005, this.dateGameModule3 && (this.tilesFall(this.fallSpeed), this.topTitle = this.touchTimes < 10 ? "0" + this.touchTimes : this.touchTimes);
                            break;
                        case 4:
                            if (this.touchedBlack) this.dateGameModule4 || (this.dateGameModule4 = Date.now()), this.releaseTouched();
                            else if (this.touchedWhite) {
                                this.dateGameModule4 = null;
                                if (this.curTile.endColorPath()) {
                                    var l = e.localStorage.getItem("RecordGameModule4") || 0,
                                        f;
                                    l = l * 1e3 / 1e3, this.recordGameModule4 > l || l == 0 ? (e.localStorage.setItem("RecordGameModule4", this.recordGameModule4), f = "新纪录") : f = "最佳 " + l + "/s", r.gotoEndMenu({
                                        gameModule: 4,
                                        record: this.recordGameModule4 + "/s",
                                        title: this.gameModuleStrs[this.gameModule],
                                        desc1: this.recordGameModule4 + "/s",
                                        desc2: f
                                    }), l = f = null
                                  
                                }
                            }
                            if (this.dateGameModule4) {
                                this.shownTut4 = true;
                                var c = Date.now();
                                this.tilesFall(this.fallSpeed);
                                this.fallSpeed += .005;
                                var h = (3.7 + (c - this.dateGameModule4) / 1e4).toFixed(3);
                                this.recordGameModule4 = h, this.topTitle = this.recordGameModule4 + "/s", c = h = null
                                //alert( this.recordGameModule4);
                                
                               
                                
                            }
                            break;
                        default:
                    }
                    return this
                },
                releaseTouched: function() {
                    return this.touchedWhite = !1, this.touchedBlack = !1, this
                },
                render: function() {
                    for (var n = 0, r; r = this.tiles[n]; n++)
                        for (var i = 0, s; s = r[i]; i++) s.render();
                    switch (this.gameModule) {
                        case 0:
                            e.canvas.drawString(this.topTitle, 0, 80, e.graphics.VCENTER, !0, this.topTitleColor, "#000", "30px 微软雅黑").fillStyle(this.touchTimesColor).fillRect(0, 0, ~~(t * (this.touchTimes / this.maxTouchTimes)), 4);
                            if (!this.shownTut0) {
                                e.canvas.drawString("别点到白块儿噢", 0, 130, e.graphics.VCENTER, !0, "#f00", "#000", "28px 微软雅黑");
                                e.canvas.drawString("点击最下面的黑块儿", 0, 160, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("越快到达终点越棒噢", 0, 190, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑")
                            }
                            break;
                        case 1:
                            e.canvas.drawString(this.topTitle, 0, 80, e.graphics.VCENTER, !0, this.topTitleColor, "#000", "30px 微软雅黑");
                            if (!this.shownTut1) {
                                e.canvas.drawString("别点到白块儿噢", 0, 130, e.graphics.VCENTER, !0, "#f00", "#000", "28px 微软雅黑");
                                e.canvas.drawString("点击最下面的黑块儿", 0, 160, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("30秒内看点击到多少黑色块儿", 0, 190, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑")
                            }
                            break;
                        case 2:
                            e.canvas.drawString(this.topTitle, 0, 80, e.graphics.VCENTER, !0, this.topTitleColor, "#000", "30px 微软雅黑").fillStyle(this.touchTimesColor).fillRect(0, 0, ~~(t * (this.touchTimes2 / this.maxTouchTimes)), 4);
                            if (!this.shownTut2) {
                                e.canvas.drawString("别点到白块儿噢", 0, 130, e.graphics.VCENTER, !0, "#f00", "#000", "28px 微软雅黑");
                                e.canvas.drawString("点击最下面的黑块儿", 0, 160, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("10秒内完成50块儿，", 0, 190, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("会有多10秒完成新的50块儿", 0, 220, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑")
                            }
                            break;
                        case 3:
                            e.canvas.drawString(this.topTitle, 0, 80, e.graphics.VCENTER, !0, this.topTitleColor, "#000", "30px 微软雅黑").fillStyle(this.touchTimesColor).fillRect(0, 0, ~~(t * (this.touchTimes2 / this.maxTouchTimes)), 4);
                            if (!this.shownTut3) {
                                e.canvas.drawString("别点到白块儿噢", 0, 130, e.graphics.VCENTER, !0, "#f00", "#000", "28px 微软雅黑");
                                e.canvas.drawString("点击最下面的黑块儿", 0, 160, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("不要漏掉任何黑块儿噢", 0, 190, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑")
                            }
                            break;
                        case 4:
                            e.canvas.drawString(this.topTitle, 0, 80, e.graphics.VCENTER, !0, this.topTitleColor, "#000", "30px 微软雅黑");
                            if (!this.shownTut4) {
                                e.canvas.drawString("别点到白块儿噢", 0, 130, e.graphics.VCENTER, !0, "#f00", "#000", "28px 微软雅黑");
                                e.canvas.drawString("点击最下面的黑块儿", 0, 160, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑");
                                e.canvas.drawString("不要漏掉任何黑块儿噢", 0, 190, e.graphics.VCENTER, !0, "#0f0", "#000", "23px 微软雅黑")
                            }
                            break;
                        default:
                    }
                    return this
                },
                start: function(t) {
                    return e.gameFlow.run(), this.init(t), this
                }
            };
        e.run(function() {
            e.canvas.clearScreen(), i.action().render()
        }).menu(function() {
            e.canvas.clearScreen(), r.mainMenuAcion().endMenuAction().endMenuRender()
        }).events.touchStart(function(e, t, n) {
            i.touchStart(t, n)
        }).mouseDown(function(e, t, n) {
            i.touchStart(t, n)
        }), r.goToMainMenu(!0)
    })
}), define("doNotTouchWhite", function() {})