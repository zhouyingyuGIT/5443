﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="SG-game-show" style="background:none;background-color:transparent; width:100%;" manifest="manifest.mf">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta charset="UTF-8">
<script type="text/javascript">
	var SpilGamesBrandTimer = +new Date(),
	_SPTimer={w:{},start:function(a){this.w[(a||"_")]=+new Date()},end:function(a){window._gaq=window._gaq||[],a=a||"_";if(this.w[a]){ 
	}}};
	_SPTimer.start('pageLoad');
</script>
    <script src="jquery.js"></script>
    <SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
    <script src="/lattice/js/oneui/opes_post_result_util.js"></script>
<meta http-equiv="Content-Type" content="text/html">
<meta name="apple-mobile-web-app-capable" content="yes"> 
<meta name="robots" content="index,follow"> 
<meta name="apple-touch-fullscreen" content="yes">
<meta name="description" content="">		
<title>开心消消乐-懒人模板</title>		
<style type="text/css"> * { padding: 0px; margin: 0px; cursor: default; } body { font: 12px/20px Palatino; }</style>
<!--<script type="text/javascript">document.write('<script type="text/javascript" src="../resource/js/resource_loader.js?ver='+Math.random()+'"><\/script>')</script>-->
	
</head>
<%
Users u=(Users)request.getSession().getAttribute("cu");
int uid=u.getUserid();
int taskid=Integer.parseInt(request.getParameter("taskid"));
String lan=request.getParameter("lan");
String targetpagename=request.getParameter("targetpagename");

int projectid=0;
if (!(request.getParameter("projectid")==null)) {
projectid=Integer.parseInt(request.getParameter("projectid"));
}

int codematerial=0;
if (!(request.getParameter("codematerial")==null)) {
codematerial=Integer.parseInt(request.getParameter("codematerial"));
}

int sumitcoids=u.getCoid();


Vector
<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
    if (ots.size()==0)
    {
    response.sendRedirect("/lattice/"+targetpagename);
    return;
    }
    ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
    request.getSession().setAttribute("ot",ots.get(0));

    %>
<body>
<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
<div id="spilgames-root"></div>
<script type="text/javascript" >

    SpilGamesBrand = function() {
        var d = window.document;
        documentElement = d.documentElement || {};
        element = d.createElement("div");
        container = d.getElementById("spilgames-root");
        emptyFn = function() {};
        globalSettings = {};
        api = {};

        updateBodyCheck = function(d) {
            var a, b = d,
                c = !1;
            return function(d, f) {
                b = d || b;
                c = f || c;
                clearTimeout(a);
                c && (a = setTimeout(function() {
                    updateBodyCheck = function(a) {
                        b = a || b;
                        b()
                    };
                    b()
                }, 100))
            }
        }(emptyFn);
        updateSize = function() {
            var h = d.body || d.getElementsByTagName("body")[0];
            updateSize = function(a) {
                a = h.getElementsByTagName("*");
                for (var b = a.length, c = 0, k = element.style.zIndex, f = 0; f < b; f++) c++, a[f] !== element && a[f].style.zIndex > c && (c = a[f].style.zIndex), c > k && (k = c, updateBodyCheck());
                element.style.zIndex = k;
                element.style.width = (window.innerWidth || documentElement.clientWidth || d.getElementsByTagName("body")[0].clientWidth) + "px";
                element.style.height = (window.innerHeight || documentElement.clientHeight || d.getElementsByTagName("body")[0].clientHeight) + "px";
                waitId = setTimeout(updateSize, updateSpeed)
            };
            updateSize()
        };
        und = function(d) {
            return void 0 === d
        };
        fadeOut = function(d) {
            var a = d.style,
                b = function() {
                    _SPTimer.end("splashscreen");
                    clearTimeout(waitId);
                    globalSettings.container.removeChild(d)
                };
            return und(a.webkitTransition) && und(a.MozTransition) && und(a.transition) ? (a.opacity = 1, function() {
                console.info("opacity")
            }) : function() {
                a.opacity = 0;
                a.webkitTransition = a.MozTransition = a.transition = "opacity 500ms ease 0ms";
                d.addEventListener("webkitTransitionEnd", b);
                d.addEventListener("mozTransitionEnd", b);
                d.addEventListener("transitionend", b)
            }
        }(element);
        waitId = null;
        updateSpeed = 100;
        endTriggered = !1;
        element.id = "splashscreen";
        api.show = function(d) {
            d = d || {};
            globalSettings = {
                time: d.time || 2500,
                onEnd: d.onEnd || emptyFn,
                onStart: d.onStart || emptyFn,
                container: d.container || container,
                css: d.css || ""
            };
            0 > globalSettings.time && (globalSettings.time = 0);
            setTimeout(function() {
                updateSpeed = 300
            }, 3E4);
            updateSize();
            globalSettings.container.appendChild(element);
            element.style.cssText = globalSettings.css;
            _SPTimer.start("splashscreen");
            globalSettings.onStart()
        };
        api.end = function() {
            var d = !1,
                a;
            end = function() {
                a = d ? 0 : globalSettings.time;
                updateBodyCheck(emptyFn);
                0 > a ? fadeOut() : setTimeout(fadeOut, a)
            };
            return function(b) {
                endTriggered || (d = b || !1, endTriggered = !0, b ? end() : updateBodyCheck(end, !0))
            }
        }();
        return api
    }(window);
    SpilGamesBrand.show({
        css: "top: 0px; left: 0px; z-index: 9999; position: absolute; background: #d0e8fd url('logo.png') no-repeat center; -webkit-background-size: 320px 320px !important;"
    });
    window.FZ = {};
    (function() {
        window.Gamehub && (window.SpilGames = {
            _: function(d) {
                var h = arguments,
                    a = 0;
                return d.replace(/%s/g, function(b) {
                    a++;
                    return void 0 !== h[a] ? h[a] : b
                })
            },
            Highscores: {
                insert: function(d) {
                    Gamehub.Score.submit(d.score)
                },
                showScoreboard: function(d) {
                    Gamehub.ShowScoreboard();
                    d && setTimeout(d, 100)
                }
            },
            Settings: {
                get: function(d) {
                    switch (d) {
                        case "currentGameInfo":
                            return {
                                splashScreen: Gamehub.Settings.splashScreen,
                                rotationLockSreen: {
                                    portrait: Gamehub.Settings.rotationLockScreen.portrait,
                                    landscape: Gamehub.Settings.rotationLockScreen.landscape
                                }
                            };
                        default:
                            return {}
                    }
                }
            }
        });
        FZ.SpilAPI = {
            SubmitScore: function(d) {
                FZ.SpilAPI.checkSpilAPI();
                SpilGames.Highscores.insert({
                    score: d
                })
            },
            ShowHighscore: function() {
                FZ.SpilAPI.checkSpilAPI();
                !FZ.SpilAPI.___noSpilGamesAPI && FZ.GameBase && FZ.GameBase.pauseGame();
                SpilGames.Highscores.showScoreboard(function() {
                    FZ.GameBase && FZ.GameBase.resumeGame()
                })
            },
            GetSplashScreenURL: function() {
                FZ.SpilAPI.checkSpilAPI();
                return FZ.SpilAPI.___noSpilGamesAPI ? "" : SpilGames.Settings.get("currentGameInfo").splashScreen
            },
            GetPortraitLockURL: function() {
                FZ.SpilAPI.checkSpilAPI();
                return FZ.SpilAPI.___noSpilGamesAPI ? "" : SpilGames.Settings.get("currentGameInfo").rotationLockSreen.portrait
            },
            GetLandscapeLockURL: function() {
                FZ.SpilAPI.checkSpilAPI();
                return FZ.SpilAPI.___noSpilGamesAPI ? "" : SpilGames.Settings.get("currentGameInfo").rotationLockSreen.landscape
            },
            checkSpilAPI: function() {
                return !FZ.SpilAPI.___noSpilGamesAPI
            },
            init: function() {
                FZ.SpilAPI.___noSpilGamesAPI = !window.SpilGames;
                window.SpilGames || (window.SpilGames = {
                    _: function(d) {
                        var h = arguments,
                            a = 0;
                        return d.replace(/%s/g, function(b) {
                            a++;
                            return void 0 !== h[a] ? h[a] : b
                        })
                    },
                    Highscores: {
                        insert: function(d) {
                            FZ.__localSubmitHighscore && FZ.__localSubmitHighscore(d.score)
                        },
                        showScoreboard: function(d) {
                            FZ.__localShowHighscore ? FZ.__localShowHighscore(d) : setTimeout(d, 0)
                        }
                    }
                })
            }
        };
        FZ.SpilAPI.init()
    })();
    (function(d, h) {
        d.SpilGames || (d.SpilGames = {
            _: function(g) {
                var b = 1,
                    a = arguments;
                return g.replace(/%s/g, function() {
                    return a[b++]
                })
            }
        });
        var a = d.JSON,
            b = d.document,
            c = d.navigator.userAgent,
            k = d.navigator.language ? d.navigator.language : d.navigator.userLanguage;
        namespace = d.location.href.replace(/\/[^\/]*$/i, "");
        var f = /\?/ig,
            e = /([^a-z0-9]|^)-([^0-9])/ig,
            l = /^([\W\w]*)\.([^:.]*)(:[\W\w]*)$/i,
            m = "$1" + (/Webkit/i.test(c) ? "-webkit-" : /Gecko/i.test(c) ? "-moz-" : "") + "$2",
            n = {
                computer: !/(iPhone|iPad|iPod|Android)/i.test(c),
                mobile: /(iPhone|iPad|iPod|Android)/i.test(c),
                iOS: /(iPhone|iPad|iPod)/i.test(c),
                iPad: /iPad/i.test(c),
                iPhone: /iPhone/i.test(c),
                iPod: /iPod/i.test(c),
                android: /Android/i.test(c),
                version: parseFloat(/(iPhone|iPad|iPod|Android|Chrome|Safari|Firefox|MSIE)[^0-9]*([0-9._]*)/i.exec(c)[2].replace("_", "."))
            },
            p, q, r, s, y, A = {},
            t = {},
            u = {},
            z = {},
            O = Array.prototype.slice,
            H = function(g) {
                for (var b, a, d = arguments.length; 1 < d--;) for (b in a = arguments[d], a) g[b] = a[b];
                return g
            },
            w = function(g) {
                if (g.nodeType) return g;
                if (g.__mate__ && g.__mate__.nodeType) return g.__mate__
            },
            B = function(g) {
                for (; g && !g.__mate__;) g = g.parentNode;
                return g ? g.__mate__ : h
            },
            C = function() {
                d.setTimeout(function() {
                    d.scrollTo(0, n.android ? 1 : 0)
                }, 500)
            },
            I = function() {
                var g = w(t.root).getBoundingClientRect();
                q = 0 > g.left ? 0 : g.left;
                r = 0 > g.top ? 0 : g.top
            },
            J = function(g) {
                var b, a, d, c = u[g];
                if (c) for (b in d = O.call(arguments, 1), c)(a = c[b])[g].apply(a, d)
            },
            v = function(g, b, c) {
                var e, f = 0,
                    k = z;
                g = g.split(".");
                for (e = g.length - 1; f < e; f++) k = "object" === typeof k[g[f]] ? k[g[f]] : k[g[f]] = {};
                if (b === h) return k[g[f]];
                k[g[f]] = b;
                !0 === c && d.localStorage.setItem(namespace, a.stringify(z))
            },
            L = function(g) {
                var b = 0,
                    a = arguments;
                return g.replace(f, function() {
                    return a[++b]
                })
            },
            x = function(g, b) {
                if ((g = w(g)) !== h) if (-1 !== b.indexOf(":")) g.style.cssText += b.replace(e, m);
                else return g.style[b]
            },
            E = function(g) {
                g = w(g).getBoundingClientRect();
                return {
                    top: g.top - r,
                    left: g.left - q,
                    right: g.right - q,
                    bottom: g.bottom - r,
                    width: g.width,
                    height: g.height
                }
            },
            M = function(g) {
                var a, d, c, e, f = p.store.local && p.store.local[g];
                if (f !== h && arguments.callee.lang !== g) for (p.language = arguments.callee.lang = g, a = b.querySelectorAll("*[local]"), d = a.length; d--;) e = a[d].__mate__, c = a[d].getAttribute("local"), e !== h && (e.lang ? e.lang(f[c]) : e.text(f[c]))
            },
            N = function(g, b) {
                var a;
                a = A[g] = function() {};
                H(a.prototype, b, F.__make__);
                a.prototype.className = g
            },
            F = function(g, a, d, c, e) {
                var f;
                g = w(g);
                if (g !== h && g.__mate__) return f = g.__mate__.path + "." + a, d = t[f] = new A[d], d.name = a, d.path = f, d.__mate__ = g.appendChild(b.createElement(e || "DIV")), d.__mate__.appendChild(b.createElement("DIV")), d.__mate__.__mate__ = d, x(d, "position: absolute; " + (c || "")), d
            },
            G = function(g) {
                var b = arguments.callee,
                    a = G.__make__[g],
                    c = function() {
                        !0 !== this.finish && (this.finish = !0, d.setTimeout(function() {
                            J(++b.finish >= b.count ? "after" : "load", b.finish, b.count)
                        }, 0))
                    };
                g === h && 0 === b.count && c();
                b.finish === h && (b.count = 0, b.finish = 0);
                return a !== h ?
                    function(g) {
                        b.count++;
                        return a.call(b, g, c)
                    } : function(g) {
                        return g
                    }
            };
        tween = function(g, b, a, c, e) {
            for (var f = +new Date, k = tween.__make__, l = g.concat(), m = g.length; m--;) g[m].time = f;
            a = "number" === typeof a ? a : 20;
            c = !0 === c ? !0 : !1;
            return function() {
                var f, m = g.length;
                f = d.setTimeout(function() {
                    for (var e, n, D = [], p = 0, K = [], q = +new Date; p < m; p++) e = g[p], e === h ? K[K.length] = !0 : (n = q - e.time, n < e[3] ? D[p] = k[e[0]](n, e[1], e[2], e[3]) : n >= e[3] && e[4] === h ? (D[p] = k[e[0]](e[3], e[1], e[2], e[3]), g[p] = h) : (D[p] = k[e[0]](e[3], e[1], e[2], e[3]), g[p] = e.slice(4), g[p].time = q));
                    b(D);
                    if (K.length < m) f = d.setTimeout(arguments.callee, a);
                    else if (!0 === c) {
                        g = l.concat();
                        for (p = g.length; p--;) g[p].time = q;
                        f = d.setTimeout(arguments.callee, a)
                    }
                }, a);
                return function() {
                    d.clearTimeout(f);
                    e && e()
                }
            }()
        };
        canvas2D = function(g, a) {
            var d, c;
            g = w(g);
            d = E(g);
            c = g.appendChild(b.createElement("CANVAS"));
            c.width = d.width;
            c.height = d.height;
            x(c, "position: absolute; left: 0px; top: 0px;");
            a = c.getContext(a);
            a.dirtyRect = [];
            a.childNodes = [];
            return a
        };
        sprite = function(g, b) {
            g.childNodes.push(this);
            this.source = b;
            this.parent = g
        };
        parse = function(g) {
            for (var a, c = ["config", "class", "object", "store"], e = 0, f = c.length, k = parse.__make__; e < f; e++) a = c[e], k[a](g[a]);
            g = b.createEvent("HTMLEvents");
            g.initEvent("orientationchange", !0, !0, d, 0, 0, 0, 0, 0, !1, !1, !1, !1, 0, null);
            d.dispatchEvent(g)
        };
        debug = function() {
            return t
        };
        assignEvent = function() {
            var g, a, b;
            return n.mobile ?
                function(g) {
                    var d, c;
                    d = g.type;
                    var e = 3 === g.target.nodeType ? g.target.parentNode : g.target,
                        f = g.touches[0];
                    if (!(1 < g.touches.length) && (c = B(e), c !== h)) {
                        f && (a = f.pageX - q, b = f.pageY - r);
                        argument = {
                            target: e,
                            code: g.keyCode,
                            button: 1,
                            clientX: a,
                            clientY: b
                        };
                        switch (d) {
                            case "touchstart":
                                c.mouseover && c.mouseover(argument);
                                c.mousedown && c.mousedown(argument);
                                break;
                            case "touchmove":
                                c.mousemove && c.mousemove(argument);
                                break;
                            case "touchend":
                                c.mouseup && c.mouseup(argument), c.click && (d = E(e), a > d.left && a < d.right && b > d.top && b < d.bottom && c.click(argument)), c.mouseout && c.mouseout(argument)
                        }
                        g.stopPropagation();
                        "DIV" === e.nodeName && g.preventDefault()
                    }
                } : function(a) {
                    var b, d, c = a.type,
                        e = 3 === a.target.nodeType ? a.target.parentNode : a.target,
                        e = "mousedown" === c ? g = e : g || e;
                    "mouseup" === c && (g = h);
                    b = B(e);
                    b !== h && "function" === typeof b[c] && (d = {
                        target: e,
                        code: a.keyCode,
                        button: g === h ? 0 : 1,
                        clientX: a.pageX - q,
                        clientY: a.pageY - r
                    }, b[c](d), a.stopPropagation(), "DIV" === e.nodeName && a.preventDefault())
                }
        }();
        parse.__make__ = {
            config: function(g) {
                var c;
                g.target = g.target === h ? b.body : b.getElementById(g.target) || b.body;
                g.angle = 90 === g.angle ? 90 : 0;
                g.width = g.width || 320;
                g.height = g.height || 416;
                g.offset = g.offset === h ? ["auto", "auto"] : g.offset.split(" ");
                1 === g.offset.length && g.offset.push(g.offset[0]);
                g.offsetLeft = "auto" === g.offset[1] ? -g.width / 2 + "px" : g.offset[1];
                g.offsetTop = "auto" === g.offset[0] ? -g.height / 2 + "px" : g.offset[0];
                N(":Unknown", {});
                c = t.root = g.target.appendChild(b.createElement("DIV"));
                c.__mate__ = {
                    name: "root",
                    path: "root",
                    className: ":Unknown"
                };
                x(c, L("position: absolute; left: ?; top: ?; width: ?px; height: ?px; margin: ? 0px 0px ?; -user-select: none; overflow: hidden; background: ?;", "auto" === g.offset[1] ? "50%" : "0px", "auto" === g.offset[0] ? "50%" : "0px", g.width, g.height, g.offsetTop, g.offsetLeft, g.background !== h ? "url(" + g.background + ") no-repeat center" || "#FFF" : ""));
                H(CanvasRenderingContext2D.prototype, canvas2D.__make__);
                s = !0 === g.dirty ? b.body.appendChild(b.createElement("CANVAS")) : b.createElement("CANVAS");
                s.width = 600;
                s.height = 600;
                y = s.getContext("2d");
                c = b.getElementsByTagName("head")[0].appendChild(b.createElement("STYLE"));
                c.type = "text/css";
                c.textContent = " * { padding: 0px; margin: 0px; cursor: default; } body { font: 12px/20px Palatino; }";
                I();
                z = a.parse(d.localStorage.getItem(namespace) || "{}");
                p.config = g
            },
            "class": function(g) {
                for (var a in g) N(a, g[a])
            },
            object: function(g) {
                var a, b;
                for (a in g) b = l.exec(a), F(t[b[1]], b[2], b[3], g[a]);
                for (a in t)(b = t[a]).construct && b.construct()
            },
            store: function(a) {
                var b, c, d, e;
                J("before");
                for (b in a) switch (d = a[b], c = G(b), typeof d) {
                    case "string":
                        a[b] = c(a[b]);
                        break;
                    case "object":
                        if (!(d instanceof Array)) {
                            for (e in d) d[e] = c(d[e]);
                            break
                        }
                    case "array":
                        for (e = d.length; e--;) d[e] = c(d[e])
                }
                p.store = a || {};
                G()
            }
        };
        F.__make__ = {
            parent: function() {
                return B(this.__mate__.parentNode)
            },
            child: function(a) {
                return t[this.path + "." + a]
            },
            local: function(a) {
                return a === h ? this.__mate__.getAttribute("local") : this.__mate__.setAttribute("local", a)
            },
            text: function(a) {
                var b = this.__mate__.firstChild;
                return a === h ? b.innerHTML : b.innerHTML = a
            },
            rect: function() {
                return E(this.__mate__)
            },
            context: function(a) {
                this.__context__ === h && (this.__context__ = canvas2D(this, a));
                return this.__context__
            }
        };
        G.__make__ = {
            image: function(a, b) {
                var c = new Image;
                c.addEventListener("load", b, !1);
                c.src = a;
                return c
            },
            audio: function(a, b) {
                var c = new Audio;
                b();
                c.src = a;
                c.load();
                c.play();
                c.pause();
                return c
            },
            file: function(a, b) {
                var c = new XMLHttpRequest;
                c.addEventListener("readystatechange", function() {
                    4 === c.readyState && 200 === c.status && b()
                }, !1);
                c.open("GET", a, !0);
                c.send(null);
                return c
            }
        };
        tween.__make__ = {
            linear: function(a, b, c, d) {
                return c * a / d + b
            },
            "cubic-ease-in": function(a, b, c, d) {
                return c * (a /= d) * a * a + b
            },
            "cubic-ease-out": function(a, b, c, d) {
                return c * ((a = a / d - 1) * a * a + 1) + b
            },
            "cubic-ease-in-out": function(a, b, c, d) {
                return 1 > (a /= d / 2) ? c / 2 * a * a * a + b : c / 2 * ((a -= 2) * a * a + 2) + b
            },
            "elastic-ease-out": function(a, b, c, d, e, f) {
                if (0 == a) return b;
                if (1 == (a /= d)) return b + c;
                f || (f = 0.3 * d);
                if (!e || e < Math.abs(c)) {
                    e = c;
                    var k = f / 4
                } else k = f / (2 * Math.PI) * Math.asin(c / e);
                return e * Math.pow(2, -10 * a) * Math.sin(2 * (a * d - k) * Math.PI / f) + c + b
            },
            "bounce-ease-out": function(a, b, c, d) {
                return (a /= d) < 1 / 2.75 ? 7.5625 * c * a * a + b : a < 2 / 2.75 ? c * (7.5625 * (a -= 1.5 / 2.75) * a + 0.75) + b : a < 2.5 / 2.75 ? c * (7.5625 * (a -= 2.25 / 2.75) * a + 0.9375) + b : c * (7.5625 * (a -= 2.625 / 2.75) * a + 0.984375) + b
            }
        };
        canvas2D.__make__ = {
            appendChild: function(a, b, c) {
                a = new sprite(this, a);
                a.size(b, c);
                return a
            },
            clear: function() {
                this.childNodes.length = 0;
                this.clearRect(0, 0, this.canvas.width, this.canvas.height)
            },
            draw: function() {
                var a, b = 0,
                    c = this.childNodes,
                    d = c.length;
                this.setTransform(1, 0, 0, 1, 0, 0);
                for (this.clearRect(0, 0, this.canvas.width, this.canvas.height); b < d; b++) a = c[b], this.globalAlpha = a.alpha, this.setTransform(a.m11, a.m12, a.m21, a.m22, a.left, a.top), a.draw(this);
                this.setTransform(1, 0, 0, 1, 0, 0)
            },
            refresh: function() {
                var a, b, c = 0,
                    d = this.childNodes,
                    e = d.length;
                a = this.dirtyRect;
                var f = this.canvas.width;
                b = this.canvas.height;
                var k, h, l, m, n, p, q, r, t;
                if (0 !== a.length && (k = 0 > a[0] ? 0 : Math.floor(a[0]), f = Math.ceil(a[2] > f ? f : a[2]), h = 0 > a[1] ? 0 : Math.floor(a[1]), l = Math.ceil(a[3] > b ? b : a[3]), m = f - k, n = l - h, !(0 >= m || 0 >= n))) {
                    b = y;
                    b.setTransform(1, 0, 0, 1, 0, 0);
                    for (b.clearRect(k, h, m, n); c < e; c++) if (a = d[c], p = a.left, q = a.left + a.width, r = a.top, t = a.top + a.height, !0 === a.dirty || (q < f ? q : f) >= (p > k ? p : k) && (t < l ? t : l) >= (r > h ? r : h)) b.globalAlpha = a.alpha, b.setTransform(a.m11, a.m12, a.m21, a.m22, p, r), a.draw(b), a.dirty = !1;
                    this.clearRect(k, h, m, n);
                    this.drawImage(s, k, h, m, n, k, h, m, n);
                    this.dirtyRect.length = 0
                }
            }
        };
        sprite.prototype = {
            RAD: Math.PI / 180,
            parent: h,
            source: h,
            dirty: !1,
            alpha: 1,
            left: 0,
            top: 0,
            width: 0,
            height: 0,
            m11: 1,
            m12: 0,
            m21: 0,
            m22: 1,
            col: 0,
            row: 0,
            cellWidth: 0,
            cellHeight: 0,
            offset: 0,
            draw: function(a) {
                a.drawImage(this.source, 0, 0, this.width, this.height)
            },
            remove: function() {
                var a;
                a = this.parent.childNodes.indexOf(this); - 1 !== a && (this.merge(), this.parent.childNodes.splice(a, 1))
            },
            slice: function(a, b) {
                0 === a ? (this.cellWidth = this.cellHeight = parseInt(this.source.naturalHeight / b), this.row = b, this.col = this.source.naturalWidth / this.cellWidth) : 0 === b ? (this.cellHeight = this.cellWidth = parseInt(this.source.naturalWidth / a), this.col = a, this.row = this.source.naturalHeight / this.cellHeight) : (this.cellWidth = parseInt(this.source.naturalWidth / a), this.cellHeight = parseInt(this.source.naturalHeight / b), this.col = a, this.row = b)
            },
            index: function(a) {
                var b, c, d = !1;
                if (0 === this.col || 0 === this.row) return d;
                a === h && (a = this.offset, a = ++a < this.col * this.row ? a : 0, 0 === a && (d = !0));
                this.offset = a;
                b = a % this.col * this.cellWidth;
                c = parseInt(a / this.cellHeight) * this.cellHeight;
                this.draw = function(a) {
                    a.drawImage(this.source, b, c, this.cellWidth, this.cellHeight, 0, 0, this.width, this.height)
                };
                this.merge();
                return d
            },
            merge: function() {
                var a = this.parent.dirtyRect,
                    b = this.left,
                    c = this.top,
                    d = b + this.width,
                    e = c + this.height;
                this.dirty = !0;
                a[0] < b || (a[0] = b);
                a[1] < c || (a[1] = c);
                a[2] > d || (a[2] = d);
                a[3] > e || (a[3] = e)
            },
            sprite: function(a) {
                this.source = a;
                this.merge();
                delete this.draw;
                this.col = this.row = 0
            },
            opacity: function(a) {
                this.alpha = a;
                this.merge()
            },
            position: function(a, b) {
                this.merge();
                this.left = a;
                this.top = b;
                this.merge()
            },
            rotate: function(a) {
                var b = this.RAD * a;
                a = Math.cos(b);
                b = Math.sin(b);
                this.m11 = a;
                this.m12 = b;
                this.m21 = -b;
                this.m22 = a
            },
            size: function(a, b) {
                this.merge();
                this.width = a;
                this.height = b;
                this.merge()
            }
        };
        b.addEventListener("DOMContentLoaded", function() {
            d.Audio = d.Audio ||
                function() {};
            d.addEventListener("scroll", C, !1);
            d.addEventListener("load", C, !1);
            b.addEventListener("touchstart", function(a) {
                a.target.value === h && a.preventDefault()
            }, !0);
            (function() {
                var a, c, e;
                n.mobile ? (a = b.body.appendChild(b.createElement("DIV")), x(a, "position: absolute; display: none; background: url(./bitmap/flip.png) no-repeat 50% 10px #FFF; left: 0px; top: 0px; width: 100%; font: bolder 20px/200px Verdana; text-align: center; -user-select: none; z-index: 100000;"), c = b.getElementsByTagName("head")[0].appendChild(b.createElement("META")), c.name = "viewport", c.content = n.android ? "initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0;" : n.iPad ? "width=devive-width, initial-scale=2.3, minimum-scale=2.3, maximum-scale=2.3, user-scalable=no;" : "width=devive-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no;", b.addEventListener("touchstart", assignEvent, !1), b.addEventListener("touchmove", assignEvent, !1), b.addEventListener("touchend", assignEvent, !1), d.addEventListener("orientationchange", function() {
                    if (e === h || e !== (90 === Math.abs(d.orientation) ? 90 : 0)) I(), C(), d.setTimeout(function() {
                        e = 90 === Math.abs(d.orientation) ? 90 : 0;
                        p.message("orientation", e);
                        p.config && x(a, L("display: ?; width: ?px; height: ?px;", p.config.angle === e ? "none" : "block", d.innerWidth, d.innerHeight));
                        I();
                        C()
                    }, n.android ? 1E3 : 0)
                }, !1)) : (b.addEventListener("mouseover", assignEvent, !1), b.addEventListener("mousedown", assignEvent, !1), b.addEventListener("mousemove", assignEvent, !1), b.addEventListener("mouseup", assignEvent, !1), b.addEventListener("mouseout", assignEvent, !1), b.addEventListener("click", assignEvent, !1))
            })()
        }, !1);
        d.System = p = {
            platform: n,
            parse: parse,
            style: x,
            extend: H,
            input: function(a, b) {
                b = d.prompt(p.store.local[M.lang][a], b || v("system.input." + a));
                null !== b && v("system.input." + a, b, !0);
                return null !== b ? b : h
            },
            getNode: w,
            getObject: B,
            connect: function(a, b) {
                var c = a.path;
                c && "function" === typeof a[b] && (u[b] === h && (u[b] = {}), u[b][c] = a)
            },
            disconnect: function(a, b) {
                var c = a.path;
                c && delete u[b][c]
            },
            message: J,
            storage: v,
            template: L,
            timeout: function(a) {
                for (var b = 1, c = arguments.length, e = []; b < c;) e[e.length] = arguments[b++], e[e.length - 1].msec = arguments[b++];
                return function(b) {
                    var c, e;
                    c = b.shift();
                    e = d.setTimeout(function() {
                        c.call(a);
                        (c = b.shift()) && (e = d.setTimeout(argument.callee, c.msec))
                    }, c.msec);
                    return function() {
                        d.clearTimeout(e)
                    }
                }(e)
            },
            getNodeByPoint: function(a, c) {
                return b.elementFromPoint(a + q, c + r)
            },
            getNodeRect: E,
            local: M,
            createObject: F,
            tween: tween,
            random: function(a, b) {
                b = ~~b;
                return parseInt(Math.random() * (a + 1 - b) + b)
            },
            playAudio: function(a, b, c) {
                var e, f;
                if (a === h) return v("system.audio");
                if ("AUDIO" !== a.nodeName || !1 === v("system.audio") && !0 !== b) return function() {};
                v("system.audio", !0, !0);
                f = d.isNaN(a.duration);
                f || (a.currentTime = 0, a.loop = 1, a.play(), e = d.setInterval(function() {
                    a.currentTime = 0;
                    a.play()
                }, 1E3 * (parseInt(a.duration) - 1)), d.onpageshow = function() {
                    a.play()
                }, d.onpagehide = function() {
                    a.pause()
                });
                "function" === typeof c && c(!0);
                return function() {
                    f || (d.clearInterval(e), d.onpagehide = d.onpageshow = h, a.pause());
                    v("system.audio", !1, !0);
                    "function" === typeof c && c(!1)
                }
            },
            language: k.toLowerCase(),
            debug: debug,
            empty: "data:image/gif;base64,R0lGODlhAQABAJEAAAAAAP///////wAAACH5BAEAAAIALAAAAAABAAEAAAICVAEAOw=="
        }
    })(window);
    (function(d, h) {

        window.construct = {
            config: {
                offset: "0px auto",
                background: "./bitmap/background.png"
            },
            store: {
                image: "./bitmap/tile_0.png ./bitmap/tile_1.png ./bitmap/tile_2.png ./bitmap/tile_3.png ./bitmap/tile_4.png ./bitmap/tile_5.png ./bitmap/floor_0.png ./bitmap/floor_1.png ./bitmap/floor_2.png ./bitmap/hidden.png ./bitmap/bomb.png ./bitmap/lock_0.png ./bitmap/lock_1.png ./bitmap/bomb_0.png ./bitmap/bomb_1.png ./bitmap/bomb_2.png ./bitmap/bomb_3.png ./bitmap/bomb_4.png ./bitmap/bomb_5.png ./bitmap/crump_0.png ./bitmap/crump_1.png ./bitmap/crump_2.png ./bitmap/crump_3.png ./bitmap/crump_4.png ./bitmap/crump_5.png ./bitmap/time_0.png ./bitmap/time_1.png ./bitmap/time_2.png ./bitmap/time_3.png ./bitmap/time_4.png ./bitmap/time_5.png ./bitmap/flash_0.png ./bitmap/flash_1.png ./bitmap/flash_2.png ./bitmap/flash_3.png ./bitmap/flash_4.png ./bitmap/flash_5.png ./bitmap/convert_portait.png ./bitmap/convert_landscape.png ./bitmap/flash.png ./bitmap/button.png ./bitmap/failed.png ./bitmap/succeed.png ./bitmap/infotip.png ./bitmap/menu.png ./bitmap/title.png ./bitmap/button.png ./bitmap/operate.png ./bitmap/pause.png".split(" "),
                audio: "./audio/SeaTreasureMatch.mp3",
                local: {
                    en: {
                        start: SpilGames._("开始游戏"),
                        scoreboard: SpilGames._("更多游戏"),
                        level: SpilGames._("等级"),
                        clock: SpilGames._("剩余时间"),
                        score: SpilGames._("分数"),
                        menu: SpilGames._("菜单"),
                        statistic: SpilGames._("成就"),
                        restart: SpilGames._("重新开始"),
                        "return": SpilGames._("返回"),
                        quit: SpilGames._("退出游戏"),
                        "quit ask": SpilGames._("你是否决定要退出游戏?"),
                        combo: SpilGames._("组合 x %s", "?"),
                        sort: SpilGames._("无效的移动!<br />这个宝石将被重置"),
                        music: {
                            off: SpilGames._("音乐关闭"),
                            on: SpilGames._("音乐打开")
                        },
                        dialog: {
                            statistic: SpilGames._("成就"),
                            scoreboard: SpilGames._("更多游戏"),
                            "statistic content": SpilGames._("胜利次数: %s<br />失败次数: %s<br />成功率: %s%", "?", "?", "?"),
                            "time over": SpilGames._("时间截止"),
                            "time over content": SpilGames._("时间耗尽.<br />你要再来一次挑战么?"),
                            succeed: SpilGames._("本关完成!"),
                            "succeed content": SpilGames._("清除分数: %s<br />时间奖励: %s<br />总计: %s", "?", "?", "?"),
                            full: SpilGames._("恭喜你"),
                            "full content": SpilGames._("分数: %s", "?"),
                            "reset ask": SpilGames._("你需要重置一下成就数据么?"),
                            ok: SpilGames._("确定"),
                            rester: SpilGames._("重置"),
                            menu: SpilGames._("菜单"),
                            again: SpilGames._("再来一次")
                        }
                    }
                },
                level: [{
                    time: 300,
                    map: [
                        [, , , , , , , , ],
                        [, , , 0, 0, 0, , , ],
                        [, , 0, 0, 0, 0, 0, , ],
                        [, 0, 0, 1, 0, 1, 0, 0],
                        [, 0, 1, 0, 1, 0, 1, 0],
                        [, 0, 1, 1, 0, 1, 1, 0],
                        [, , 0, 0, , 0, 0, , ]
                    ]
                }, {
                    time: 300,
                    map: [
                        [, , , , , , , , ],
                        [, , 0, 0, 0, 0, 0, , ],
                        [, 0, 0, 1, 1, 1, 0, 0],
                        [, 0, 0, 1, , 1, 0, 0],
                        [, 0, 0, 1, 1, 1, 0, 0],
                        [, , 1, 1, 0, 1, 1, , ],
                        [, 0, 0, 0, 0, 0, 0, 0]
                    ]
                }, {
                    time: 300,
                    map: [
                        [, 0, 0, 0, 0, 0, 0, 0],
                        [, , 0, 0, 1, 0, 0, , ],
                        [, , , 1, 1, 1, , , ],
                        [, , , , 4, , , , ],
                        [, , , 0, 0, 0, , , ],
                        [, , 0, 0, 1, 0, 0, , ],
                        [, 0, 1, 1, 1, 1, 1, 0],
                        [0, 0, 0, 1, 1, 1, 0, 0, 0]
                    ]
                }, {
                    time: 300,
                    map: [
                        [, 0, 0, 0, 0, 0, 0, 0],
                        [, , 0, 0, 0, 0, 0, 0],
                        [, 0, 1, 0, , 1, 1, 0],
                        [, 0, 1, , 0, 0, 1, 0],
                        [, 0, 1, 0, 0, , 1, 0],
                        [, 0, 1, 1, , 0, 1, 0],
                        [, 0, 0, 0, 0, 0, 0, , ]
                    ]
                }, {
                    time: 300,
                    map: [
                        [0, 1, 0, 0, 0, 0, 0, 1, 1],
                        [0, 1, 0, 0, 0, 0, 1, 1, 0],
                        [, 0, 0, 0, 0, 1, 1, 0, 0],
                        [, , 0, 0, 1, 1, 0, 0, 0],
                        [, , , 1, 1, 4, 4, 4, 4],
                        [, , , , 0, 0, 0, 0, 0],
                        [, , , , , 0, 0, 1, 1],
                        [, , , , , , 0, 0, 0]
                    ]
                }, {
                    time: 300,
                    map: [
                        [, 0, 0, 0, , 0, 0, 0],
                        [, 0, 0, 0, , 0, 0, 0],
                        [0, 0, 0, 0, , 0, 0, 0, 0],
                        [0, 0, 0, 0, , 0, 0, 0, 0],
                        [1, 1, 1, 1, , 1, 1, 1, 1],
                        [0, 4, 4, 4, , 4, 4, 4, 0],
                        [, 1, 1, 1, , 1, 1, 1],
                        [, 0, 0, 0, , 0, 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [, , , 0, 0, 0, , , ],
                        [, , 0, 0, 1, 0, 0, , ],
                        [, , 0, 1, 1, 1, 0, , ],
                        [, , 0, 5, 5, 5, 0, , ],
                        [, 0, 0, 1, 1, 1, 0, 0],
                        [, 0, 0, 2, 2, 2, 0, 0],
                        [, 1, 1, 0, 0, 0, 1, 1],
                        [, 0, 0, , 0, , 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [0, 0, 0, 0, , 0, 0, 0, 0],
                        [, 0, 0, 0, , 0, 0, 0],
                        [, , 0, 0, 0, 0, 0, , ],
                        [, 0, 2, 2, 0, 2, 2, 0],
                        [0, 0, , 0, 0, 0, , 0, 0],
                        [1, 1, 1, 0, , 0, 1, 1, 1],
                        [0, 1, 1, 1, 0, 1, 1, 1, 0],
                        [, 0, 0, 0, , 0, 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [1, 1, 1, 0, 0, 0, 1, 1, 1],
                        [1, 2, 1, 0, , 0, 1, 2, 1],
                        [1, 1, 1, , 0, , 1, 1, 1],
                        [0, 0, , 0, 0, 0, , 0, 0],
                        [0, , 0, 0, 0, 0, 0, , 0],
                        [, , 0, 5, 5, 5, 0, , ],
                        [, 0, 0, 1, 2, 1, 0, 0],
                        [, 0, 0, 1, 1, 1, 0, 0]
                    ]
                }, {
                    time: 300,
                    map: [
                        [, , , 0, 0, 0, , , ],
                        [, , 0, 1, 1, 1, 0, , ],
                        [, 0, 0, 1, 1, 1, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, , , 0, , , 0, 0],
                        [0, 0, 0, 2, 8, 2, 0, 0, 0],
                        [, 0, 1, 0, 2, 0, 1, 0, 0],
                        [, 0, 1, 0, 0, 0, 1, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [, 0, 0, 0, , 0, 0, 0],
                        [, 0, 0, 1, 0, 1, 0, 0],
                        [0, 0, 1, 1, 0, 1, 1, 0, 0],
                        [1, 1, 1, , 0, , 1, 1, 1],
                        [1, 8, 1, 1, 1, 1, 1, 8, 1],
                        [, 0, , 1, 2, 1, , 0],
                        [, 0, 0, 1, 1, 1, 0, 0],
                        [0, 0, 0, 1, 1, 1, 0, 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [0, 0, 0, 0, 0, 0, 0, 0, 0],
                        [, 0, 1, 1, 1, 1, 1, 0],
                        [, 0, 1, 1, 1, 1, 1, 0],
                        [, , 0, , 0, , 0, , ],
                        [, 0, , 0, , 0, , 0],
                        [, 0, 1, 1, 1, 1, 1, 0],
                        [0, 0, 1, 2, 2, 2, 1, 0, 0],
                        [0, 0, 1, 2, 2, 2, 1, 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [, , 0, 0, , 0, 0, , ],
                        [, 0, 0, 0, , 0, 0, 0],
                        [0, 0, 2, 0, , 0, 2, 0, 0],
                        [0, 0, 2, 0, , 0, 2, 0, 0],
                        [, 5, 1, 5, 1, 5, 1, 5],
                        [, 0, 0, 2, 2, 2, 0, 0],
                        [, , 0, 0, 0, 0, 0, , ],
                        [, , 0, 0, , 0, 0, , ]
                    ]
                }, {
                    time: 360,
                    map: [
                        [0, 0, , 0, 0, 0, , 0, 0],
                        [0, 0, , 0, 0, 0, , 0, 0],
                        [0, 0, 0, 0, , 0, 0, 0, 0],
                        [, 0, 1, 0, , 0, 1, 0],
                        [0, , 1, 1, , 1, 1, , 0],
                        [0, 0, 1, 2, 0, 2, 1, 0, 0],
                        [0, 1, 0, 2, 0, 2, 0, 1, 0],
                        [0, 0, , 0, 0, 0, , 0, 0]
                    ]
                }, {
                    time: 360,
                    map: [
                        [, , 0, 0, 0, 0, 0, , ],
                        [, 0, 1, 1, 1, 1, 1, 1],
                        [0, 5, 5, 5, 1, 5, 5, 5, 0],
                        [0, 1, 1, 2, 2, 2, 1, 1, 0],
                        [0, 1, 1, 10, 10, 10, 1, 1, 0],
                        [0, 1, 1, 1, 1, 1, 1, 1, 0],
                        [, 0, 1, 1, 1, 1, 1, 0],
                        [, , 0, 0, 0, 0, 0, , ]
                    ]
                }]
            },
            object: {
                "root.load:Load": "left: 0px; top: 0px; width: 100%; height: 100%;",
                "root.load.title:Unknown": "left: 0px; top: 0px; width: 100%; height: 140px; background: url(./bitmap/title.png) no-repeat center;",
                "root.load.progress:Unknown": "left: 50%; bottom: 120px; width: 100%; height: 32px; font-weight: bold; color: white; text-shadow: #333 2px 2px 3px; font-size: 32px; text-align: center; margin-left: -50%;",
                "root.menu:Menu": "display: none; left: 0px; top: 0px; width: 100%; height: 100%; background: url(./bitmap/menu.png) no-repeat center;",
                "root.menu.title:Unknown": "left: 0px; top: 0px; width: 100%; height: 140px; background: url(./bitmap/title.png) no-repeat center;",
                "root.menu.highscore:Unknown": "display: none; left: 50%; top: 160px; width: 300px; height: 55px; margin-left: -150px; font: bold 16px/46px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.menu.start:Button": "left: 50%; top: 260px; width: 140px; height: 55px; margin-left: -70px; background: url(./bitmap/button.png) no-repeat center top; font: bold 16px/46px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.menu.music:Button": "left: 50%; top: 310px; width: 140px; height: 55px; margin-left: -70px; background: url(./bitmap/button.png) no-repeat center top; font: bold 16px/46px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.menu.scoreboard:Button": "left: 50%; top: 360px; width: 140px; height: 55px; margin-left: -70px; background: url(./bitmap/button.png) no-repeat center top; font: bold 16px/46px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.main:Main": "display: none; left: 0px; top: 0px; width: 100%; height: 100%;",
                "root.main.operate:Unknown": "left: 0px; bottom: 0px; width: 100%; height: 108px; background: url(./bitmap/operate.png) no-repeat center;",
                "root.main.operate.statistic:Button": "left: 50%; bottom: -8px; width: 140px; height: 55px; margin-left: -140px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.main.operate.menu:Button": "left: 50%; bottom: -8px; width: 140px; height: 55px; margin-left: 0px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.main.infotip:Unknown": "left: 0px; top: 0px; width: 100%; height: 54px; background: url(./bitmap/infotip.png) no-repeat center;",
                "root.main.clock:Clock": "left: 50%; top: 0px; width: 100px; margin-left: -50px; font: bold 14px/18px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3; margin-top: 8px;",
                "root.main.level:Level": "left: 50%; top: 0px; width: 110px; margin-left: -160px; font: bold 14px/18px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3; margin-top: 8px;",
                "root.main.score:Score": "left: 50%; top: 0px; width: 110px; margin-left: 50px; font: bold 14px/18px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3; margin-top: 8px;",
                "root.main.logic:Logic": "left: 50%; top: 40px; width: 306px; height: 306px; margin-left: -153px;" + (d.platform.android ? " /*-transform-style: preserve-3d;*/" : ""),
                "root.main.logic.floor:Delegate": "left: 0px; top: 0px; width: 100%; height: 100%;",
                "root.main.logic.tile:Delegate": "left: 0px; top: 0px; width: 100%; height: 100%;",
                "root.main.logic.surface:Delegate": "left: 0px; top: 0px; width: 100%; height: 100%;",
                "root.main.combo:Combo": "display: none; left: 0px; top: 80px; width: 100%; height: 40px; text-align: center; font: bold 26px/30px Verdana; color: #ffff99; -text-stroke: #006600 1px; -text-fill-color: #ffff99; text-shadow: rgba(255, 255, 255, 0.8) 0px 0px 8px;",
                "root.mask:Unknown": "display: none; left: 0px; top: 0px; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.2);",
                "root.mask.dialog:Dialog": "left: 50%; top: 50%;",
                "root.mask.dialog.title:Unknown": "left: 0px; top: 40px; width: 100%; text-align: center; font: bold 20px/24px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.content:Unknown": "left: 0px; top: 74px; width: 100%; height: 66px; text-align: center; font: bold 14px/22px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.left:Button": "display: none; left: 50%; top: 170px; width: 140px; height: 55px; margin-left: -136px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.right:Button": "display: none; left: 50%; top: 170px; width: 140px; height: 55px; margin-left: 4px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.center:Button": "display: none; left: 50%; top: 170px; width: 140px; height: 55px; margin-left: -68px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.restart:Button": "display: none; left: 50%; top: 35px; width: 140px; height: 55px; margin-left: -68px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.quit:Button": "display: none; left: 50%; top: 80px; width: 140px; height: 55px; margin-left: -68px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;",
                "root.mask.dialog.return:Button": "display: none; left: 50%; top: 165px; width: 140px; height: 55px; margin-left: -68px; background: url(./bitmap/button.png) no-repeat center top; font: bold 14px/42px Verdana; text-shadow: #333 2px 2px 2px; text-align: center; color: #f4ffa3;"
            },
            "class": {
                ":Button": {
                    construct: function() {
                        if ("music" === this.name) {
                            if (d.platform.android) {
                                d.style(this, "display: none;");
                                return
                            }
                            this.lang = function(a) {
                                var b = this;
                                this.language = a;
                                d.playAudio() ? (this.text(this.language.off), this.audio = d.playAudio(d.store.audio, !0, function(a) {
                                    b.text(a ? b.language.off : b.language.on)
                                })) : this.text(this.language.on)
                            }
                        }
                        this.local(this.name)
                    },
                    mouseover: function() {
                        d.style(this, "background-position: center bottom;")
                    },
                    mouseout: function() {
                        d.style(this, "background-position: center top;")
                    },
                    click: function() {
                        var a;
                        switch (this.name) {
                            case "scoreboard":
                                dp_Ranking();
                                break;
                            case "start":
                                d.message("scene", "main");
                                break;
                            case "menu":
                                d.message("dialog", "menu");
                                break;
                            case "statistic":
                                d.message("dialog", "statistic");
                                break;
                            case "restart":
                                d.message("undialog", "again");
                                break;
                            case "quit":
                                confirm(d.store.local[d.language]["quit ask"]) && d.message("undialog", "menu");
                                break;
                            case "music":
                                a = this;
                                this.audio ? (this.audio(), this.audio = h) : this.audio = d.playAudio(d.store.audio, !0, function(b) {
                                    a.text(b ? a.language.off : a.language.on)
                                });
                                break;
                            case "return":
                                d.message("undialog", "return")
                        }
                    }
                },
                ":Load": {
                    construct: function() {
                        d.connect(this, "load");
                        d.connect(this, "after");
                        this.progress = this.child("progress")
                    },
                    load: function(a, b) {
                        this.progress.text(parseInt(a / b * 100) + "%")
                    },
                    after: function() {
                        var a = d.store.image,
                            b = this;
                        d.Empty = new Image;
                        d.Empty.src = d.empty;
                        d.Floor = [a[6], a[7], a[8]];
                        d.Time = [a[25], a[26], a[27], a[28], a[29], a[30]];
                        d.Effect = [a[9], a[10], a[39]];
                        d.Lock = [d.Empty, a[11], a[12]];
                        d.Convert = [a[37], a[38]];
                        window.setTimeout(function() {
                            d.local("en");
                            d.tween([
                                ["linear", 1, -1, 500]
                            ], function(a) {
                                a[0] !== h ? d.style(b, "opacity: " + a[0] + ";") : d.style(b, "display: none;")
                            }, 20);
                            d.message("scene", "menu", b.name)
                        }, 200)
                    }
                },
                ":Menu": {
                    construct: function() {
                        d.connect(this, "scene");
                        this.child("highscore").text(SpilGames._("更多游戏: %s", ~~d.storage("highscore")))
                    },
                    scene: function(a, b) {
                        var c = this;
                        this.name === a ? "load" === b ? (d.style(this, "display: block; opacity: 0;"), d.tween([
                            ["linear", 0, 1, 500]
                        ], function(a) {
                            a[0] !== h && d.style(c, "opacity: " + a[0] + ";")
                        }, 20)) : d.style(this, "display: block;") : d.style(this, "display: none;")
                    }
                },
                ":Main": {
                    construct: function() {
                        d.connect(this, "scene")
                    },
                    scene: function(a) {
                        this.name === a ? (d.style(this, "display: block;"), d.message("start", "reset")) : d.style(this, "display: none;")
                    }
                },
                ":Combo": {
                    construct: function() {
                        d.connect(this, "combo");
                        this.local("combo")
                    },
                    lang: function(a) {
                        this.language = a
                    },
                    combo: function(a) {
                        var b = this;
                        this.tween && this.tween();
                        "number" === typeof a ? this.text(d.template(this.language, a)) : this.text(a);
                        d.style(b, "display: block; top: 150px;");
                        this.tween = d.tween([
                            ["cubic-ease-in", 1, -0.4, 1E3],
                            ["linear", 150, -100, 1E3],
                            ["cubic-ease-in", 1, -1, 1E3]
                        ], function(a) {
                            a[0] === h ? d.style(b, "display: none;") : d.style(b, "top: " + a[1] + "px; opacity: " + a[2] + "; -transform: scale(" + a[0] + ");")
                        }, 50)
                    }
                },
                ":Dialog": {
                    construct: function() {
                        d.connect(this, "dialog");
                        d.connect(this, "undialog");
                        this.local("dialog");
                        this.title = this.child("title");
                        this.content = this.child("content");
                        this.left = this.child("left");
                        this.right = this.child("right");
                        this.center = this.child("center");
                        this.restart = this.child("restart");
                        this.resume = this.child("return");
                        this.quit = this.child("quit")
                    },
                    lang: function(a) {
                        this.langList = a
                    },
                    setButtonNum: function(a) {
                        switch (a) {
                            case 1:
                                d.style(this.title, "display: block;");
                                d.style(this.content, "display: block;");
                                d.style(this.left, "display: none;");
                                d.style(this.right, "display: none;");
                                d.style(this.center, "display: block;");
                                d.style(this.restart, "display: none;");
                                d.style(this.resume, "display: none;");
                                d.style(this.quit, "display: none;");
                                break;
                            case 2:
                                d.style(this.title, "display: block;");
                                d.style(this.content, "display: block;");
                                d.style(this.left, "display: block;");
                                d.style(this.right, "display: block;");
                                d.style(this.center, "display: none;");
                                d.style(this.restart, "display: none;");
                                d.style(this.resume, "display: none;");
                                d.style(this.quit, "display: none;");
                                break;
                            case 3:
                                d.style(this.title, "display: none;"), d.style(this.content, "display: none;"), d.style(this.left, "display: none;"), d.style(this.right, "display: none;"), d.style(this.center, "display: none;"), d.style(this.restart, "display: block;"), d.style(this.resume, "display: block;"), d.style(this.quit, "display: block;")
                        }
                    },
                    undialog: function(a) {
                        switch (a) {
                            case "return":
                                d.message("resume");
                                break;
                            case "again":
                                d.message("start", "again");
                                break;
                            case "next":
                                d.message("start", "next");
                                break;
                            case "menu":
                                d.message("scene", "menu");
                                break;
                            case "sort":
                                d.message("start", "sort")
                        }
                        d.style(this.parent(), "display: none;")
                    },
                    dialog: function(a) {
                        var b = this.langList,
                            c = ~~d.storage("succeed"),
                            k = ~~d.storage("failed"),
                            f = c + k,
                            e = d.SCORE;
                        0 === f && (f = 1);
                        switch (a) {
                            case "menu":
                                d.style(this, "width: 207px; height: 240px; margin-top: -120px; margin-left: -108px; background: url(./bitmap/pause.png) no-repeat;");
                                this.setButtonNum(3);
                                break;
                            case "statistic":
                                d.style(this, "width: 310px; height: 231px; margin-top: -125px; margin-left: -160px; background: url(./bitmap/failed.png) no-repeat;");
                                d.style(this.content, "line-height: 22px;");
                                this.setButtonNum(2);
                                this.title.text(b.statistic);
                                this.content.text(d.template(b["statistic content"], c, k, parseInt(c / f * 100)));
                                this.left.text(b.rester);
                                this.left.click = function() {
                                    window.confirm(b["reset ask"]) && (d.storage("succeed", 0), d.storage("failed", 0, !0), d.message("undialog", "return"))
                                };
                                this.right.text(b.ok);
                                this.right.click = function() {
                                    d.message("undialog", "return")



                                };
                                break;
                            case "failed":
                                d.storage("failed", k + 1, !0);
                                d.style(this, "width: 310px; height: 231px; margin-top: -125px; margin-left: -160px; background: url(./bitmap/failed.png) no-repeat;");
                                d.style(this.content, "line-height: 33px;");
                                this.setButtonNum(2);
                                this.title.text(b["time over"]);
                                this.content.text(b["time over content"]);
                                post_result();
                                this.left.text(b.again);
                                this.left.click = function() {
                                    d.message("undialog", "again")
                                };
                                this.right.text(b.scoreboard);
                                this.right.click = function() {
                                    FZ.SpilAPI.ShowHighscore()
                                };
                                break;
                            case "succeed":
                                d.storage("succeed", c + 1, !0);
                                d.style(this, "width: 310px; height: 231px; margin-top: -125px; margin-left: -160px; background: url(./bitmap/succeed.png) no-repeat;");
                                d.style(this.content, "line-height: 22px;");
                                this.setButtonNum(1);
                                this.title.text(b.succeed);
                                a = e.total + e.score + e.time;
                                this.content.text(d.template(b["succeed content"], e.score, e.time, a));
                                FZ.SpilAPI.SubmitScore(a);
                                dp_submitScore(-1, a);~~d.storage("highscore") < a && d.storage("highscore", a, !0);
                                this.center.text(b.ok);
                                this.center.click = function() {
                                    d.message("undialog", "next")

                                };
                                break;
                            case "full":
                                d.storage("succeed", c + 1, !0);
                                d.style(this, "width: 310px; height: 231px; margin-top: -125px; margin-left: -160px; background: url(./bitmap/succeed.png) no-repeat;");
                                d.style(this.content, "line-height: 66px;");
                                a = e.total + e.score + e.time;
                                FZ.SpilAPI.SubmitScore(a);
                                dp_submitScore(-1, a);~~d.storage("highscore") < a && d.storage("highscore", a, !0);
                                this.setButtonNum(2);
                                this.title.text(b.full);
                                this.content.text(d.template(b["full content"], a));
                                this.left.text(b.ok);
                                this.left.click = function() {
                                    d.message("undialog", "menu")


                                };
                                this.right.text(b.scoreboard);
                                this.right.click = function() {
                                    FZ.SpilAPI.ShowHighscore()
                                };
                                break;
                            case "sort":
                                d.style(this, "width: 310px; height: 231px; margin-top: -125px; margin-left: -160px; background: url(./bitmap/failed.png) no-repeat;");
                                d.style(this.content, "line-height: 66px;");
                                this.setButtonNum(1);
                                this.title.text(b.sort);
                                this.content.text(d.template(b["sort content"]));
                                this.center.text(b.ok);
                                this.center.click = function() {
                                    d.message("undialog", "sort")


                                };
                                break;
                            default:
                                return
                        }
                        d.message("pause");
                        d.style(this.parent(), "display: block;")
                    }
                },
                ":Clock": {
                    construct: function() {
                        d.connect(this, "clock");
                        this.local("clock")
                    },
                    lang: function(a) {
                        this.script = a
                    },
                    clock: function(a) {
                        var b = a % 60,
                            b = 9 >= b ? "0" + b : b;
                        this.text(this.script + "<br />" + parseInt(a / 60) + ":" + b)
                    }
                },
                ":Level": {
                    construct: function() {
                        d.connect(this, "level");
                        this.local("level")
                    },
                    lang: function(a) {
                        this.script = a
                    },
                    level: function(a) {
                        this.text(this.script + "<br />" + a)
                    }
                },
                ":Score": {
                    construct: function() {
                        d.connect(this, "score");
                        this.local("score")
                    },
                    lang: function(a) {
                        this.script = a
                    },
                    score: function(a) {
                        this.text(this.script + "<br />" + a)
                    }
                },
                ":Delegate": {
                    mousedown: function(a) {
                        this.parent().mousedown(a)
                    },
                    mouseup: function(a) {
                        this.parent().mouseup(a)
                    }
                },
                ":Logic": {
                    level: 0,
                    total: 0,
                    score: 0,
                    timeLeft: 0,
                    offsetTop: 34,
                    graph: h,
                    busy: !1,
                    twice: !1,
                    combo: 0,
                    passLevel: !1,
                    effectList: {},
                    construct: function() {
                        d.connect(this, "start");
                        d.connect(this, "pause");
                        d.connect(this, "resume");
                        d.connect(this, "orientation")
                    },
                    orientation: function(a) {
                        this.graph !== h && (0 === a ? d.message("resume") : d.message("pause"))
                    },
                    addScore: function(a) {
                        this.score += a;
                        d.message("score", this.total + this.score);
                        scoreA=this.total + this.score;
                    },
                    start: function(a) {
                        var b, c, k, f = [];
                        c = d.store.image;
                        var e = d.Floor,
                            l = d.Lock;
                        this.floor === h && (this.floor = this.child("floor").context("2d"), this.tile = this.child("tile").context("2d"), this.surface = this.child("surface").context("2d"));
                        switch (a) {
                            case "reset":
                                this.level = this.total = this.score = 0;
                                break;
                            case "again":
                                this.score = 0;
                                break;
                            case "next":
                                this.level++;
                                this.total += this.score + 10 * this.timeLeft;
                                this.score = 0;
                                break;
                            case "sort":
                                this.resume(!0);
                                return;
                            default:
                                return
                        }
                        this.passLevel = !1;
                        d.message("level", this.level + 1);
                        d.message("score", this.total + this.score);
                        this.pause();
                        if (a = d.store.level[this.level]) {
                            10 <= this.level ? (d.Tile = [c[0], c[1], c[2], c[3], c[4], c[5]], d.Bomb = [c[13], c[14], c[15], c[16], c[17], c[18]], d.Crump = [c[19], c[20], c[21], c[22], c[23], c[24]], d.Flash = [c[31], c[32], c[33], c[34], c[35], c[36]]) : (d.Tile = [c[0], c[1], c[2], c[3], c[4]], d.Bomb = [c[13], c[14], c[15], c[16], c[17]], d.Crump = [c[19], c[20], c[21], c[22], c[23]], d.Flash = [c[31], c[32], c[33], c[34], c[35]]);
                            this.stopAnimation && this.stopAnimation();
                            this.floor.clear();
                            this.tile.clear();
                            this.surface.clear();
                            d.message("clock", this.timeLeft = a.time);
                            k = a.map;
                            for (a = k.length; a--;) for (f[a] = [], c = k[a].length; c--;) b = k[a][c], b !== h && (b = f[a][c] = [b & 3, b >>> 2, h, 0, h, h, h, 34 * c, 34 * a + this.offsetTop, 0, 0, 0, 0], b[4] = this.floor.appendChild(e[b[0]], 32, 32), b[4].position(b[7], b[8]), b[5] = this.tile.appendChild(d.Empty, 32, 32), b[5].position(b[7], b[8]), 0 < b[1] && (b[6] = this.surface.appendChild(l[b[1]], 32, 32), b[6].position(b[7], b[8])));
                            this.floor.draw();
                            this.tile.draw();
                            this.surface.draw();
                            this.graph = f;
                            this.resume(!0)
                        } else d.SCORE = {
                            total: this.total,
                            score: this.score,
                            time: 10 * this.timeLeft
                        }, d.message("dialog", "full")
                    },

                    pause: function() {
                        this.stopDrop = !0;
                        this.stopClock && this.stopClock()
                    },
                    resume: function(a) {
                        var b = this,
                            c = arguments.callee;
                        window.clearInterval(c.clock);
                        c.clock = window.setInterval(function() {
                            0 < b.timeLeft && d.message("clock", --b.timeLeft);
                            0 >= b.timeLeft && !1 === b.passLevel && d.message("dialog", "failed")
                        }, 1E3);
                        this.stopDrop = !1;
                        if (a) {
                            do this.autoFill();
                            while (!1 === this.findNext());
                            this.tile.refresh();
                            this.busy = !1;
                            window.clearTimeout(this.hintSortTime);
                            window.clearTimeout(this.hintLongTime);
                            this.hintSortTime = window.setTimeout(function() {
                                b.hintNext.reject = h;
                                b.hintNext()
                            }, 5E3);
                            this.hintLongTime = window.setTimeout(function() {
                                b.hintNext()
                            }, 1E4)
                        } else this.drop();
                        this.stopClock = function() {
                            window.clearInterval(c.clock)
                        }
                    },
                    pass: function() {
                        var a, b, c, k = this.graph;
                        for (a = k.length; a--;) for (b = k[a].length; b--;) if (c = k[a][b], c !== h && 0 !== c[0]) return !1;
                        d.SCORE = {
                            total: this.total,
                            score: this.score,
                            time: 10 * this.timeLeft
                        };
                        return this.passLevel = !0
                    },
                    convert: function(a, b) {
                        var c;
                        c = a[2];
                        a[2] = b[2];
                        b[2] = c;
                        c = a[3];
                        a[3] = b[3];
                        b[3] = c;
                        c = a[5];
                        a[5] = b[5];
                        b[5] = c;
                        c = a[11];
                        a[11] = b[11];
                        b[11] = c
                    },
                    autoFill: function() {
                        var a = this.graph,
                            b, c, k, f, e, l, m, n, p = d.Tile;
                        k = a.length;
                        for (b = 0; b < k; b++) for (c = a[b].length; c--;) if (f = a[b][c], f !== h && 0 === f[3] && (e = a[b - 1], e !== h && 0 !== e.length ? (m = (l = e[c - 1]) !== h && 0 === l[1] && l[2] !== h ? !0 : !1, n = (l = e[c]) !== h && 0 === l[1] && l[2] !== h ? !0 : !1, e = (l = e[c + 1]) !== h && 0 === l[1] && l[2] !== h ? !0 : !1) : m = n = e = !0, !0 === m || !0 === n || !0 === e)) {
                            f[2] = d.random(p.length - 1);
                            e = a[b];
                            n = 3;
                            for (m = h; n--;) if (l = e[c + n], 0 === n) {
                                m = l;
                                do l = d.random(p.length - 1);
                                while (f[2] === l);
                                f[2] = l
                            } else if (l === h || l[2] !== f[2]) break;
                            for (n = 3; n--;) if (l = a[b - n], 0 === n) {
                                do l = d.random(p.length - 1);
                                while (f[2] === l || f[2] === m);
                                f[2] = l
                            } else if (l === h || (l = l[c]) === h || l[2] !== f[2]) break
                        }
                        for (b = a.length; b--;) for (c = a[b].length; c--;) f = a[b][c], f !== h && f[2] !== h && 0 === f[3] && (f[5].sprite(p[f[2]]), f[5].position(f[7], f[8]), f[5].slice(0, 1), f[5].index(0));
                        this.tile.draw()
                    },
                    hintNext: function() {
                        var a = arguments.callee,
                            b = this.graph,
                            c = this,
                            k, f, e, h = d.Convert;
                        k = this.findNext(a.reject);
                        !1 !== k && (a.reject = k.reject, a = b[k.row][k.col], this.stopAnimation && this.stopAnimation(), 0 === k.convert ? (f = this.surface.appendChild(h[k.convert], 60, 100), f.position(a[7] - 14, a[8] - 18)) : (f = this.surface.appendChild(h[k.convert], 100, 60), f.position(a[7] - 20, a[8] - 14)), f.slice(13, 1), f.index(0), e = window.setInterval(function() {
                            f.index();
                            c.surface.refresh()
                        }, 50), this.stopAnimation = function() {
                            window.clearInterval(e);
                            f.remove();
                            c.surface.refresh()
                        })
                    },
                    findNext: function(a) {
                        var b = this.graph,
                            c = [],
                            d = [],
                            f, e, l, m, n, p, q, r;
                        for (f = b.length; f--;) for (e = b[f].length, c[f] = [], d[f] = []; e--;) n = b[f][e], c[f][e] = n === h ? h : n[2], d[f][e] = n === h || 0 === n[1] ? h : !0;
                        if ("object" === typeof a) for (b = a.length; b--;) n = a[b], c[n[0]][n[1]] = -1;
                        for (f = c.length; f--;) for (e = a = c[f].length; e--;) if (r = 4, n = c[f][e], n !== h && !0 !== d[f][e]) for (; r--;) {
                            b = h;
                            n = f;
                            p = e;
                            switch (r) {
                                case 0:
                                    0 < e - 1 && c[f][e - 1] !== h && !0 !== d[f][e - 1] && (q = 1, n = l = f, p = m = e - 1, b = c[f][e], c[f][e] = c[f][e - 1], c[f][e - 1] = b);
                                    break;
                                case 1:
                                    c[f - 1] !== h && c[f - 1][e] !== h && !0 !== d[f - 1][e] && (q = 0, n = l = f - 1, p = m = e, b = c[f][e], c[f][e] = c[f - 1][e], c[f - 1][e] = b);
                                    break;
                                case 2:
                                    e + 1 < a && c[f][e + 1] !== h && !0 !== d[f][e + 1] && (q = 1, l = f, m = e + 1, b = c[f][e], c[f][e] = c[f][e + 1], c[f][e + 1] = b);
                                    break;
                                case 3:
                                    c[f + 1] !== h && c[f + 1][e] !== h && !0 !== d[f + 1][e] && (q = 0, l = f + 1, m = e, b = c[f][e], c[f][e] = c[f + 1][e], c[f + 1][e] = b)
                            }
                            if (b !== h) {
                                if (!0 === this.autoCheck(c)) return {
                                    convert: q,
                                    row: n,
                                    col: p,
                                    reject: [
                                        [f, e],
                                        [l, m]
                                    ]
                                };
                                switch (r) {
                                    case 0:
                                        b = c[f][e];
                                        c[f][e] = c[f][e - 1];
                                        c[f][e - 1] = b;
                                        break;
                                    case 1:
                                        b = c[f][e];
                                        c[f][e] = c[f - 1][e];
                                        c[f - 1][e] = b;
                                        break;
                                    case 2:
                                        b = c[f][e];
                                        c[f][e] = c[f][e + 1];
                                        c[f][e + 1] = b;
                                        break;
                                    case 3:
                                        b = c[f][e], c[f][e] = c[f + 1][e], c[f + 1][e] = b
                                }
                            }
                        }
                        return !1
                    },
                    autoCheck: function(a) {
                        var b, c, d, f, e;
                        for (b = a.length; b--;) for (c = a[b].length; c--;) if (d = a[b][c], d !== h) {
                            for (e = 3; e--;) {
                                f = a[b][c + e];
                                if (0 === e) return !0;
                                if (f === h || f !== d) break
                            }
                            for (e = 3; e--;) {
                                f = a[b - e];
                                if (0 === e) return !0;
                                if (f === h || (f = f[c]) === h || f !== d) break
                            }
                        }
                        return !1
                    },
                    isProperty: function(a, b, c) {
                        var k, f, e, l, m = {},
                            n = this.graph,
                            p = d.Effect;
                        (l = n[b][c - 1]) && l[2] !== h && (l[11] = 2);
                        (l = n[b][c + 1]) && l[2] !== h && (l[11] = 1);
                        n[b][c][11] = 0;
                        k = p[0];
                        e = 17;
                        f = 69;
                        switch (a[3]) {
                            case 1:
                                a[3] = 0;
                                for (k = 2; - 2 < --k;) if (n[b - k] !== h) for (f = 2; - 2 < --f;) l = n[b - k][c - f], l !== h && (l[12] = 1, m[b - k + "," + (c - f)] = l);
                                delete m[b + "," + c];
                                for (l in m) k = this.effectList[l], "object" === typeof k && (k.sprite(p[1]), k.size(92, 92), k.position(k.left + e - 30, k.top + e - 30), k.slice(15, 1), k.index(0));
                                this.eliminate(m);
                                k = p[1];
                                e = 30;
                                f = 92;
                                break;
                            case 2:
                                a[3] = 0;
                                for (k = 3; - 3 < --k;) l = n[b][c - k], l !== h && (l[12] = 1, m[b + "," + (c - k)] = l), l = n[b - k], l !== h && l[c] !== h && (l[c][12] = 1, m[b - k + "," + c] = l[c]);
                                delete m[b + "," + c];
                                for (l in m) k = this.effectList[l], "object" === typeof k && (k.sprite(p[1]), k.size(92, 92), k.position(k.left + e - 30, k.top + e - 30), k.slice(15, 1), k.index(0));
                                this.eliminate(m);
                                k = p[1];
                                e = 30;
                                f = 92;
                                break;
                            case 3:
                                a[3] = 0;
                                this.timeLeft += 60;
                                break;
                            case 4:
                                a[3] = 0;
                                m = this.getFiveTile();
                                for (l in m) m[l][12] = 2;
                                this.eliminate(m);
                                k = p[2];
                                e = 19;
                                f = 70
                        }
                        switch (a[12]) {
                            case 1:
                                k = p[1];
                                e = 30;
                                f = 92;
                                break;
                            case 2:
                                k = p[2], e = 19, f = 70
                        }
                        a[2] = h;
                        a[5].sprite(d.Empty);
                        k = this.surface.appendChild(k, f, f);
                        k.position(a[7] - e, a[8] - e);
                        k.slice(0, 1);
                        k.index(0);
                        this.addScore(5 * this.combo);
                        return k
                    },
                    getFiveTile: function() {
                        var a = 0,
                            b = 0,
                            c, k, f, e = 0,
                            h = {},
                            m = this.graph;
                        for (k = a = m.length; a--;) c = m[a].length, c > b && (b = c);
                        for (c = b * k; 5 > e;) b = d.random(c), a = parseInt(b / k), b %= k, (f = m[a] && m[a][b]) && 0 === f[3] && (e++, h[a + "," + b] = f);
                        return h
                    },
                    eliminate: function(a) {
                        var b, c, k = this,
                            f, e = arguments.callee,
                            l = d.Floor,
                            m = d.Lock;
                        for (b in a) c = a[b], 0 < c[1] ? c[6].sprite(m[--c[1]]) : (0 < c[0] && c[4].sprite(l[--c[0]]), f = b.split(","), this.effectList[b] === h && (this.effectList[b] = !0, this.effectList[b] = this.isProperty(c, parseInt(f[0]), parseInt(f[1]))));
                        this.floor.refresh();
                        this.tile.refresh();
                        this.surface.refresh();
                        window.clearTimeout(e.timeout);
                        e.timeout = window.setTimeout(function() {
                            var a, b = k.effectList,
                                c = 0;
                            for (a in b) b[a].index() ? (over = !1, b[a].remove(), delete b[a]) : c++;
                            k.surface.refresh();
                            0 < c && (e.timeout = window.setTimeout(arguments.callee, 20))
                        }, 0)
                    },
                    drop: function() {
                        var a = this,
                            b, c = !1;
                        a.hitab();
                        b = this.moveList;
                        0 !== b.length ? d.tween([
                            ["linear", 34, -34, 150]
                        ], function(c) {
                            var d, e = b.length;
                            if (c[0] === h)!0 !== a.stopDrop && a.drop();
                            else {
                                for (; e--;) d = b[e], d[5].position(d[7] - d[9] * c[0], d[8] - d[10] * c[0]);
                                a.tile.refresh()
                            }
                        }, 30) : window.setTimeout(function() {
                            if (!1 === a.check()) {
                                for (; !1 === a.findNext();) a.autoFill(), c = !0;
                                a.tile.refresh();
                                !0 === c && d.message("combo", d.store.local[d.language].sort);
                                a.busy = !1
                            }
                        }, 150)
                    },
                    hitab: function() {
                        var a, b, c, k, f, e, l = [],
                            m = this.graph,
                            n = d.Tile;
                        for (a = m.length; a--;) for (c = m[a].length, b = -1; b++ < c;) if (k = m[a][b], k !== h && k[2] === h) {
                            f = 0 === a ? [] : m[a - 1];
                            if (f[b] && 0 === f[b][1] && f[b][2] !== h) this.convert(k, f[b]), l[l.length] = k;
                            else if ((e = f[b + 1]) && 0 === e[1] && 1 !== e[11] && e[2] !== h && ((e = m[a][b + 1]) === h || e[2] !== h)) this.convert(k, f[b + 1]), l[l.length] = k;
                            else if ((e = f[b - 1]) && 0 === e[1] && 2 !== e[11] && e[2] !== h && ((e = m[a][b - 1]) === h || e[2] !== h)) this.convert(k, f[b - 1]), l[l.length] = k;
                            else if (f[b] === h) {
                                if (f[b + 1] !== h) continue;
                                if (f[b - 1] !== h) continue;
                                l[l.length] = k;
                                k[11] = 0;
                                k[2] = d.random(n.length - 1);
                                e = k[5];
                                e.sprite(n[k[2]]);
                                e.slice(0, 1);
                                e.index(0);
                                e.position(k[7], k[8] - 34)
                            }
                            k[9] = k[7] !== k[5].left ? k[7] > k[5].left ? 1 : -1 : 0;
                            k[10] = k[8] !== k[5].top ? k[8] > k[5].top ? 1 : -1 : 0
                        }
                        this.tile.refresh();
                        this.moveList = l
                    },
                    check: function() {
                        var a, b, c, k, f, e, l = 0,
                            m = [],
                            n = [],
                            p = {},
                            q = {},
                            r = this,
                            s = this.graph,
                            y = d.Tile,
                            A = d.Bomb,
                            t = d.Crump,
                            u = d.Flash,
                            z = d.Time;
                        for (a = s.length; a--;) n[a] = [];
                        for (a = s.length; a--;) for (b = s[a].length; b--;) if (e = s[a][b], e !== h && e[2] !== h) {
                            e[12] = e[11] = 0;
                            k = e[2];
                            c = a;
                            for (m = []; 0 <= --c && (e = s[c][b]) && e[2] === k;) m[m.length] = [c + "," + b, e, c, b];
                            if (1 < m.length) for (m[m.length] = [a + "," + b, s[a][b], a, b], c = m.length; c--;) e = m[c], p[e[0]] = e[1], n[e[2]][e[3]] = e[1][2];
                            c = b;
                            for (m = []; 0 <= --c && (e = s[a][c]) && e[2] === k;) m[m.length] = [a + "," + c, e, a, c];
                            if (1 < m.length) for (m[m.length] = [a + "," + b, s[a][b], a, b], c = m.length; c--;) e = m[c], p[e[0]] = e[1], n[e[2]][e[3]] = e[1][2]
                        }
                        for (f in p) l++;
                        if (2 < l) {
                            this.combo++;
                            this.eliminate(p);
                            1 < this.combo && d.message("combo", this.combo);
                            if (4 === this.combo && !0 !== this.crumpSend) {
                                for (e in p) break;
                                e = e.split(",");
                                e = s[parseInt(e[0])][parseInt(e[1])];
                                e[3] = 2;
                                e[2] = d.random(y.length - 1);
                                e[5].sprite(t[e[2]]);
                                e[5].slice(0, 1);
                                e[5].index(0)
                            } else if (4 < l && ((e = this.srcItem)[2] === h || (e = this.tarItem)[2] === h)) {
                                switch (this.formation(n, q)) {
                                    case "T":
                                        e = s[q.row][q.col] || e;
                                        e[3] = 4;
                                        e[2] = q.color;
                                        e[5].sprite(u[e[2]]);
                                        break;
                                    case "L":
                                        e = s[q.row][q.col] || e;
                                        e[3] = 1;
                                        e[2] = q.color;
                                        e[5].sprite(A[e[2]]);
                                        break;
                                    case 5:
                                        e[3] = 3, e[2] = q.color || d.random(y.length - 1), e[5].sprite(z[e[2]])
                                }
                                e[5].slice(0, 1);
                                e[5].index(0)
                            }
                            this.tile.refresh();
                            window.setTimeout(function() {
                                var a = r.effectList,
                                    b;
                                for (b in a) {
                                    window.setTimeout(arguments.callee, 30);
                                    return
                                    return
                                }
                                r.drop()
                            }, 100);
                            this.findNextStart = !1;
                            this.pass();
                            return !0
                        }
                        this.combo = 0;
                        this.pass();
                        !0 === this.passLevel ? this.level === d.store.level.length - 1 ? d.message("dialog", "full") : d.message("dialog", "succeed") : (window.clearTimeout(this.hintSortTime), window.clearTimeout(this.hintLongTime), this.hintSortTime = window.setTimeout(function() {
                            r.hintNext.reject = h;
                            r.hintNext()
                        }, 5E3), this.hintLongTime = window.setTimeout(function() {
                            r.hintNext()
                        }, 1E4));
                        return !1
                    },
                    formation: function(a, b) {
                        for (var c = a.length, d, f, e = [], l, m; c--;) for (d = a[c].length; d--;) if (f = a[c][d], f !== h && (m = l = 0, f !== h)) switch (a[c + 1] && a[c + 1][d] === f && (l |= 1, m++), a[c - 1] && a[c - 1][d] === f && (l |= 2, m++), a[c][d + 1] === f && (l |= 4, m++), a[c][d - 1] === f && (l |= 8, m++), e[e.length] = m, b.color = f, m) {
                            case 3:
                                return b.row = c, b.col = d, "T";
                            case 2:
                                if (9 === l || 5 === l || 6 === l || 10 === l) return b.row = c, b.col = d, "L"
                        }
                        if (1 === e.pop() && 1 === e.shift()) for (c = e.length; c--;) if (2 !== e[c]) return !1;
                        return 5
                    },
                    swap: function(a, b) {
                        var c = this,
                            k = arguments.callee;
                        this.convert(a, b);
                        k.state = !0;
                        a[9] = a[7] !== a[5].left ? a[7] > a[5].left ? 1 : -1 : 0;
                        a[10] = a[8] !== a[5].top ? a[8] > a[5].top ? 1 : -1 : 0;
                        b[9] = b[7] !== b[5].left ? b[7] > b[5].left ? 1 : -1 : 0;
                        b[10] = b[8] !== b[5].top ? b[8] > b[5].top ? 1 : -1 : 0;
                        d.tween([
                            ["linear", 34, -34, 200]
                        ], function(d) {
                            d[0] === h ? (!0 === k.state ? !1 === c.check() && c.swap(a, b) : c.busy = !1, k.state = !1) : (a[5].position(a[7] - a[9] * d[0], a[8] - a[10] * d[0]), b[5].position(b[7] - b[9] * d[0], b[8] - b[10] * d[0]), c.tile.refresh())
                        }, 10)
                    },
                    mousedown: function(a) {
                        var b = this,
                            c = this.rect(),
                            d = a.clientX - c.left;
                        a = a.clientY - c.top;
                        var f, e;
                        this.stopAnimation && this.stopAnimation();
                        window.clearTimeout(this.hintSortTime);
                        window.clearTimeout(this.hintLongTime);
                        0 > a - this.offsetTop || (d = parseInt(d / 34), a = parseInt((a - this.offsetTop) / 34), this.active !== h && (this.active(), this.active = h), this.graph !== h && this.graph[a] !== h && (f = this.graph[a][d], f === h || 0 < f[1] || f[2] === h || !0 === this.busy || !0 === this.stopDrop || !0 === this.twice || (this.srcCol = d, this.srcRow = a, f = f[5], e = window.setTimeout(function() {
                            f.index();
                            e = window.setTimeout(arguments.callee, 30);
                            b.tile.refresh()
                        }, 30), this.active = function() {
                            window.clearTimeout(e);
                            f.index(0);
                            b.tile.refresh()
                        })))
                    },
                    mouseup: function(a) {
                        var b = this.rect(),
                            c = a.clientX - b.left;
                        a = a.clientY - b.top;
                        if (this.active !== h || !1 !== this.twice) this.busy = !0, this.tarCol = parseInt(c / 34), this.tarRow = parseInt((a - this.offsetTop) / 34), this.gesture()
                    },
                    gesture: function() {
                        var a = this,
                            b = this.graph[this.srcRow][this.srcCol],
                            c;
                        this.tarCol > this.srcCol ? c = this.graph[this.srcRow][this.srcCol + 1] : this.tarCol < this.srcCol ? c = this.graph[this.srcRow][this.srcCol - 1] : this.tarRow > this.srcRow ? c = this.graph[this.srcRow + 1] && this.graph[this.srcRow + 1][this.srcCol] : this.tarRow < this.srcRow && (c = this.graph[this.srcRow - 1] && this.graph[this.srcRow - 1][this.srcCol]);
                        c && 0 === c[1] && c[2] !== h ? (this.twice = !1, this.active !== h && this.active(), this.active = h, this.srcItem = b, this.tarItem = c, this.swap(b, c)) : !1 === this.twice ? this.twice = !0 : (this.busy = this.twice = !1, this.active !== h && this.active(), this.active = h, window.clearTimeout(this.hintSortTime), window.clearTimeout(this.hintLongTime), this.hintSortTime = window.setTimeout(function() {
                            a.hintNext.reject = h;
                            a.hintNext()
                        }, 5E3), this.hintLongTime = window.setTimeout(function() {
                            a.hintNext()
                        }, 1E4))
                    }
                }
            }
        };
        window.StartGame = function() {
            window.setTimeout(function() {
                construct && d.parse(construct)
            }, 0)
        };
        window.Gamehub || window.addEventListener("load", StartGame, !1)
    })(window.System);
    setTimeout(function() {
        SpilGamesBrand.end()
    }, 1.5 * (new Date - SpilGamesBrandTimer));
    _SPTimer.end("pageLoad");


</script>

    <script>
        function dp_Ranking() {
            // document.location.href = "http://g.lanrenmb.com/";
        }
    </script>

    <div id="share" style="display: none">
			<img width="100%" src="bitmap/share.png" style="position: fixed; z-index: 9999; top: 0; left: 0; display: " ontouchstart="document.getElementById(&#39;share&#39;).style.display=&#39;none&#39;;">
		</div>
    <script>
        // var mebtnopenurl = "http://mp.weixin.qq.com/s?__biz=MjM5NjA0MTI0OQ==&mid=200068987&idx=1&sn=1de5daeaae94c66a3c46a13e20e8011e#rd";
        var tit = "";
        var scoreA
        var maxtime=300;
        var DFW = {
            appId: "",
            TLImg: "http://g.lanrenmb.com/icon/kaixinlian.jpg",
            url: "http://g.lanrenmb.com/icon/kaixinlian.jpg",
            title: "开心消消乐-多多游戏",
            desc: "我消，我消，我消...！"
        };
        var onBridgeReady = function () {
            WeixinJSBridge.on('menu:share:appmessage', function (argv) {
                WeixinJSBridge.invoke('sendAppMessage', {
                    "appid": DFW.appId,
                    "img_url": DFW.TLImg,
                    "img_width": "120",
                    "img_height": "120",
                    "link": DFW.url,
                    "title": DFW.title + tit,
                    "desc": DFW.desc
                }
                );
            });
            WeixinJSBridge.on('menu:share:timeline', function (argv) {
                WeixinJSBridge.invoke('shareTimeline', {
                    "appid": DFW.appId,
                    "img_url": DFW.TLImg,
                    "img_width": "120",
                    "img_height": "120",
                    "link": DFW.url,
                    "title": DFW.title + tit,
                    "desc": DFW.desc
                }
                );
            });
        };
        if (document.addEventListener) { 
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
        } else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
        function do_share(score) {
            document.title = "我获得了" + score + "分，一起来消星星吧！";

            document.getElementById("share").style.display = "";
            window.DFW.title = document.title;
        }

        function dp_submitScore(level,score) {
            //alert("你获得" + score + "分");
            if (score > 5000) {
                if (confirm("你获得了" + score + " 要不要通知下小伙伴们呢？")) {
                   //do_share(score);
                }
            }
        }
        timer = setInterval(function () {
            CountDown();
        }, 1000);
        function CountDown(score) {
            if (maxtime >= 0) {
                minutes = Math.floor(maxtime / 60);
                seconds = Math.floor(maxtime % 60);
                msg = "距离结束还有" + minutes + "分" + seconds + "秒";
                document.getElementById("tir").innerHTML=msg;
                --maxtime;
            } else{
                console.log(scoreA);
                clearInterval(timer);
                post_result();
            }
        }
        function post_result() {
            var opes_result_data = {};

            opes_result_data.taskid =<%= taskid %>;
            opes_result_data.sumitcoids =<%= sumitcoids %>;
            opes_result_data.targetpagename = "<%=targetpagename%>";
            opes_result_data.codematerial =<%= codematerial %>;
            opes_result_data.uid =<%= uid %>;
            opes_result_data.lan = "<%=lan%>";
            opes_result_data.projectid =<%= projectid %>;

            opes_result_data.duration = 0;
            opes_result_data.timeaverage = Math.round(0);

            //以下判断总题数
            opes_result_data.type4set = "0";
            opes_result_data.stimidset = "0";
            opes_result_data.correctanswerset = "0";
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = "0";
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = "0";
            opes_result_data.commentset = "0";
            opes_result_data.numset = (scoreA/100).toString();
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;


        }


        function result_format(result) {
            var msg = "";
            var obj = result;
            for (var name in obj) {
                msg += obj[name] + "{" + name + "};";
            };
            msg = (msg.slice(msg.length - 1) == ';') ? msg.slice(0, -1) : msg;
            return msg;
        }
    </script>
<div style="display: none;"><script type="text/javascript" src="stats.js" charset="UTF-8"></script></div>
</body></html>