/*!
* jQuery JavaScript Library v1.5.1
* http://jquery.com/
*
* Copyright 2011, John Resig
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* Includes Sizzle.js
* http://sizzlejs.com/
* Copyright 2011, The Dojo Foundation
* Released under the MIT, BSD, and GPL Licenses.
*
* Date: Wed Feb 23 13:55:29 2011 -0500
*/
(function (a, b) { function cg(a) { return d.isWindow(a) ? a : a.nodeType === 9 ? a.defaultView || a.parentWindow : !1 } function cd(a) { if (!bZ[a]) { var b = d("<" + a + ">").appendTo("body"), c = b.css("display"); b.remove(); if (c === "none" || c === "") c = "block"; bZ[a] = c } return bZ[a] } function cc(a, b) { var c = {}; d.each(cb.concat.apply([], cb.slice(0, b)), function () { c[this] = a }); return c } function bY() { try { return new a.ActiveXObject("Microsoft.XMLHTTP") } catch (b) { } } function bX() { try { return new a.XMLHttpRequest } catch (b) { } } function bW() { d(a).unload(function () { for (var a in bU) bU[a](0, 1) }) } function bQ(a, c) { a.dataFilter && (c = a.dataFilter(c, a.dataType)); var e = a.dataTypes, f = {}, g, h, i = e.length, j, k = e[0], l, m, n, o, p; for (g = 1; g < i; g++) { if (g === 1) for (h in a.converters) typeof h === "string" && (f[h.toLowerCase()] = a.converters[h]); l = k, k = e[g]; if (k === "*") k = l; else if (l !== "*" && l !== k) { m = l + " " + k, n = f[m] || f["* " + k]; if (!n) { p = b; for (o in f) { j = o.split(" "); if (j[0] === l || j[0] === "*") { p = f[j[1] + " " + k]; if (p) { o = f[o], o === !0 ? n = p : p === !0 && (n = o); break } } } } !n && !p && d.error("No conversion from " + m.replace(" ", " to ")), n !== !0 && (c = n ? n(c) : p(o(c))) } } return c } function bP(a, c, d) { var e = a.contents, f = a.dataTypes, g = a.responseFields, h, i, j, k; for (i in g) i in d && (c[g[i]] = d[i]); while (f[0] === "*") f.shift(), h === b && (h = a.mimeType || c.getResponseHeader("content-type")); if (h) for (i in e) if (e[i] && e[i].test(h)) { f.unshift(i); break } if (f[0] in d) j = f[0]; else { for (i in d) { if (!f[0] || a.converters[i + " " + f[0]]) { j = i; break } k || (k = i) } j = j || k } if (j) { j !== f[0] && f.unshift(j); return d[j] } } function bO(a, b, c, e) { if (d.isArray(b) && b.length) d.each(b, function (b, f) { c || bq.test(a) ? e(a, f) : bO(a + "[" + (typeof f === "object" || d.isArray(f) ? b : "") + "]", f, c, e) }); else if (c || b == null || typeof b !== "object") e(a, b); else if (d.isArray(b) || d.isEmptyObject(b)) e(a, ""); else for (var f in b) bO(a + "[" + f + "]", b[f], c, e) } function bN(a, c, d, e, f, g) { f = f || c.dataTypes[0], g = g || {}, g[f] = !0; var h = a[f], i = 0, j = h ? h.length : 0, k = a === bH, l; for (; i < j && (k || !l); i++) l = h[i](c, d, e), typeof l === "string" && (!k || g[l] ? l = b : (c.dataTypes.unshift(l), l = bN(a, c, d, e, l, g))); (k || !l) && !g["*"] && (l = bN(a, c, d, e, "*", g)); return l } function bM(a) { return function (b, c) { typeof b !== "string" && (c = b, b = "*"); if (d.isFunction(c)) { var e = b.toLowerCase().split(bB), f = 0, g = e.length, h, i, j; for (; f < g; f++) h = e[f], j = /^\+/.test(h), j && (h = h.substr(1) || "*"), i = a[h] = a[h] || [], i[j ? "unshift" : "push"](c) } } } function bo(a, b, c) { var e = b === "width" ? bi : bj, f = b === "width" ? a.offsetWidth : a.offsetHeight; if (c === "border") return f; d.each(e, function () { c || (f -= parseFloat(d.css(a, "padding" + this)) || 0), c === "margin" ? f += parseFloat(d.css(a, "margin" + this)) || 0 : f -= parseFloat(d.css(a, "border" + this + "Width")) || 0 }); return f } function ba(a, b) { b.src ? d.ajax({ url: b.src, async: !1, dataType: "script" }) : d.globalEval(b.text || b.textContent || b.innerHTML || ""), b.parentNode && b.parentNode.removeChild(b) } function _(a) { return "getElementsByTagName" in a ? a.getElementsByTagName("*") : "querySelectorAll" in a ? a.querySelectorAll("*") : [] } function $(a, b) { if (b.nodeType === 1) { var c = b.nodeName.toLowerCase(); b.clearAttributes(), b.mergeAttributes(a); if (c === "object") b.outerHTML = a.outerHTML; else if (c !== "input" || a.type !== "checkbox" && a.type !== "radio") { if (c === "option") b.selected = a.defaultSelected; else if (c === "input" || c === "textarea") b.defaultValue = a.defaultValue } else a.checked && (b.defaultChecked = b.checked = a.checked), b.value !== a.value && (b.value = a.value); b.removeAttribute(d.expando) } } function Z(a, b) { if (b.nodeType === 1 && d.hasData(a)) { var c = d.expando, e = d.data(a), f = d.data(b, e); if (e = e[c]) { var g = e.events; f = f[c] = d.extend({}, e); if (g) { delete f.handle, f.events = {}; for (var h in g) for (var i = 0, j = g[h].length; i < j; i++) d.event.add(b, h + (g[h][i].namespace ? "." : "") + g[h][i].namespace, g[h][i], g[h][i].data) } } } } function Y(a, b) { return d.nodeName(a, "table") ? a.getElementsByTagName("tbody")[0] || a.appendChild(a.ownerDocument.createElement("tbody")) : a } function O(a, b, c) { if (d.isFunction(b)) return d.grep(a, function (a, d) { var e = !!b.call(a, d, a); return e === c }); if (b.nodeType) return d.grep(a, function (a, d) { return a === b === c }); if (typeof b === "string") { var e = d.grep(a, function (a) { return a.nodeType === 1 }); if (J.test(b)) return d.filter(b, e, !c); b = d.filter(b, e) } return d.grep(a, function (a, e) { return d.inArray(a, b) >= 0 === c }) } function N(a) { return !a || !a.parentNode || a.parentNode.nodeType === 11 } function F(a, b) { return (a && a !== "*" ? a + "." : "") + b.replace(r, "`").replace(s, "&") } function E(a) { var b, c, e, f, g, h, i, j, k, l, m, n, o, q = [], r = [], s = d._data(this, "events"); if (a.liveFired !== this && s && s.live && !a.target.disabled && (!a.button || a.type !== "click")) { a.namespace && (n = new RegExp("(^|\\.)" + a.namespace.split(".").join("\\.(?:.*\\.)?") + "(\\.|$)")), a.liveFired = this; var t = s.live.slice(0); for (i = 0; i < t.length; i++) g = t[i], g.origType.replace(p, "") === a.type ? r.push(g.selector) : t.splice(i--, 1); f = d(a.target).closest(r, a.currentTarget); for (j = 0, k = f.length; j < k; j++) { m = f[j]; for (i = 0; i < t.length; i++) { g = t[i]; if (m.selector === g.selector && (!n || n.test(g.namespace)) && !m.elem.disabled) { h = m.elem, e = null; if (g.preType === "mouseenter" || g.preType === "mouseleave") a.type = g.preType, e = d(a.relatedTarget).closest(g.selector)[0]; (!e || e !== h) && q.push({ elem: h, handleObj: g, level: m.level }) } } } for (j = 0, k = q.length; j < k; j++) { f = q[j]; if (c && f.level > c) break; a.currentTarget = f.elem, a.data = f.handleObj.data, a.handleObj = f.handleObj, o = f.handleObj.origHandler.apply(f.elem, arguments); if (o === !1 || a.isPropagationStopped()) { c = f.level, o === !1 && (b = !1); if (a.isImmediatePropagationStopped()) break } } return b } } function C(a, c, e) { var f = d.extend({}, e[0]); f.type = a, f.originalEvent = {}, f.liveFired = b, d.event.handle.call(c, f), f.isDefaultPrevented() && e[0].preventDefault() } function w() { return !0 } function v() { return !1 } function g(a) { for (var b in a) if (b !== "toJSON") return !1; return !0 } function f(a, c, f) { if (f === b && a.nodeType === 1) { f = a.getAttribute("data-" + c); if (typeof f === "string") { try { f = f === "true" ? !0 : f === "false" ? !1 : f === "null" ? null : d.isNaN(f) ? e.test(f) ? d.parseJSON(f) : f : parseFloat(f) } catch (g) { } d.data(a, c, f) } else f = b } return f } var c = a.document, d = function () { function I() { if (!d.isReady) { try { c.documentElement.doScroll("left") } catch (a) { setTimeout(I, 1); return } d.ready() } } var d = function (a, b) { return new d.fn.init(a, b, g) }, e = a.jQuery, f = a.$, g, h = /^(?:[^<]*(<[\w\W]+>)[^>]*$|#([\w\-]+)$)/, i = /\S/, j = /^\s+/, k = /\s+$/, l = /\d/, m = /^<(\w+)\s*\/?>(?:<\/\1>)?$/, n = /^[\],:{}\s]*$/, o = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, p = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, q = /(?:^|:|,)(?:\s*\[)+/g, r = /(webkit)[ \/]([\w.]+)/, s = /(opera)(?:.*version)?[ \/]([\w.]+)/, t = /(msie) ([\w.]+)/, u = /(mozilla)(?:.*? rv:([\w.]+))?/, v = navigator.userAgent, w, x = !1, y, z = "then done fail isResolved isRejected promise".split(" "), A, B = Object.prototype.toString, C = Object.prototype.hasOwnProperty, D = Array.prototype.push, E = Array.prototype.slice, F = String.prototype.trim, G = Array.prototype.indexOf, H = {}; d.fn = d.prototype = { constructor: d, init: function (a, e, f) { var g, i, j, k; if (!a) return this; if (a.nodeType) { this.context = this[0] = a, this.length = 1; return this } if (a === "body" && !e && c.body) { this.context = c, this[0] = c.body, this.selector = "body", this.length = 1; return this } if (typeof a === "string") { g = h.exec(a); if (!g || !g[1] && e) return !e || e.jquery ? (e || f).find(a) : this.constructor(e).find(a); if (g[1]) { e = e instanceof d ? e[0] : e, k = e ? e.ownerDocument || e : c, j = m.exec(a), j ? d.isPlainObject(e) ? (a = [c.createElement(j[1])], d.fn.attr.call(a, e, !0)) : a = [k.createElement(j[1])] : (j = d.buildFragment([g[1]], [k]), a = (j.cacheable ? d.clone(j.fragment) : j.fragment).childNodes); return d.merge(this, a) } i = c.getElementById(g[2]); if (i && i.parentNode) { if (i.id !== g[2]) return f.find(a); this.length = 1, this[0] = i } this.context = c, this.selector = a; return this } if (d.isFunction(a)) return f.ready(a); a.selector !== b && (this.selector = a.selector, this.context = a.context); return d.makeArray(a, this) }, selector: "", jquery: "1.5.1", length: 0, size: function () { return this.length }, toArray: function () { return E.call(this, 0) }, get: function (a) { return a == null ? this.toArray() : a < 0 ? this[this.length + a] : this[a] }, pushStack: function (a, b, c) { var e = this.constructor(); d.isArray(a) ? D.apply(e, a) : d.merge(e, a), e.prevObject = this, e.context = this.context, b === "find" ? e.selector = this.selector + (this.selector ? " " : "") + c : b && (e.selector = this.selector + "." + b + "(" + c + ")"); return e }, each: function (a, b) { return d.each(this, a, b) }, ready: function (a) { d.bindReady(), y.done(a); return this }, eq: function (a) { return a === -1 ? this.slice(a) : this.slice(a, +a + 1) }, first: function () { return this.eq(0) }, last: function () { return this.eq(-1) }, slice: function () { return this.pushStack(E.apply(this, arguments), "slice", E.call(arguments).join(",")) }, map: function (a) { return this.pushStack(d.map(this, function (b, c) { return a.call(b, c, b) })) }, end: function () { return this.prevObject || this.constructor(null) }, push: D, sort: [].sort, splice: [].splice }, d.fn.init.prototype = d.fn, d.extend = d.fn.extend = function () { var a, c, e, f, g, h, i = arguments[0] || {}, j = 1, k = arguments.length, l = !1; typeof i === "boolean" && (l = i, i = arguments[1] || {}, j = 2), typeof i !== "object" && !d.isFunction(i) && (i = {}), k === j && (i = this, --j); for (; j < k; j++) if ((a = arguments[j]) != null) for (c in a) { e = i[c], f = a[c]; if (i === f) continue; l && f && (d.isPlainObject(f) || (g = d.isArray(f))) ? (g ? (g = !1, h = e && d.isArray(e) ? e : []) : h = e && d.isPlainObject(e) ? e : {}, i[c] = d.extend(l, h, f)) : f !== b && (i[c] = f) } return i }, d.extend({ noConflict: function (b) { a.$ = f, b && (a.jQuery = e); return d }, isReady: !1, readyWait: 1, ready: function (a) { a === !0 && d.readyWait--; if (!d.readyWait || a !== !0 && !d.isReady) { if (!c.body) return setTimeout(d.ready, 1); d.isReady = !0; if (a !== !0 && --d.readyWait > 0) return; y.resolveWith(c, [d]), d.fn.trigger && d(c).trigger("ready").unbind("ready") } }, bindReady: function () { if (!x) { x = !0; if (c.readyState === "complete") return setTimeout(d.ready, 1); if (c.addEventListener) c.addEventListener("DOMContentLoaded", A, !1), a.addEventListener("load", d.ready, !1); else if (c.attachEvent) { c.attachEvent("onreadystatechange", A), a.attachEvent("onload", d.ready); var b = !1; try { b = a.frameElement == null } catch (e) { } c.documentElement.doScroll && b && I() } } }, isFunction: function (a) { return d.type(a) === "function" }, isArray: Array.isArray || function (a) { return d.type(a) === "array" }, isWindow: function (a) { return a && typeof a === "object" && "setInterval" in a }, isNaN: function (a) { return a == null || !l.test(a) || isNaN(a) }, type: function (a) { return a == null ? String(a) : H[B.call(a)] || "object" }, isPlainObject: function (a) { if (!a || d.type(a) !== "object" || a.nodeType || d.isWindow(a)) return !1; if (a.constructor && !C.call(a, "constructor") && !C.call(a.constructor.prototype, "isPrototypeOf")) return !1; var c; for (c in a) { } return c === b || C.call(a, c) }, isEmptyObject: function (a) { for (var b in a) return !1; return !0 }, error: function (a) { throw a }, parseJSON: function (b) { if (typeof b !== "string" || !b) return null; b = d.trim(b); if (n.test(b.replace(o, "@").replace(p, "]").replace(q, ""))) return a.JSON && a.JSON.parse ? a.JSON.parse(b) : (new Function("return " + b))(); d.error("Invalid JSON: " + b) }, parseXML: function (b, c, e) { a.DOMParser ? (e = new DOMParser, c = e.parseFromString(b, "text/xml")) : (c = new ActiveXObject("Microsoft.XMLDOM"), c.async = "false", c.loadXML(b)), e = c.documentElement, (!e || !e.nodeName || e.nodeName === "parsererror") && d.error("Invalid XML: " + b); return c }, noop: function () { }, globalEval: function (a) { if (a && i.test(a)) { var b = c.head || c.getElementsByTagName("head")[0] || c.documentElement, e = c.createElement("script"); d.support.scriptEval() ? e.appendChild(c.createTextNode(a)) : e.text = a, b.insertBefore(e, b.firstChild), b.removeChild(e) } }, nodeName: function (a, b) { return a.nodeName && a.nodeName.toUpperCase() === b.toUpperCase() }, each: function (a, c, e) { var f, g = 0, h = a.length, i = h === b || d.isFunction(a); if (e) { if (i) { for (f in a) if (c.apply(a[f], e) === !1) break } else for (; g < h; ) if (c.apply(a[g++], e) === !1) break } else if (i) { for (f in a) if (c.call(a[f], f, a[f]) === !1) break } else for (var j = a[0]; g < h && c.call(j, g, j) !== !1; j = a[++g]) { } return a }, trim: F ? function (a) { return a == null ? "" : F.call(a) } : function (a) { return a == null ? "" : (a + "").replace(j, "").replace(k, "") }, makeArray: function (a, b) { var c = b || []; if (a != null) { var e = d.type(a); a.length == null || e === "string" || e === "function" || e === "regexp" || d.isWindow(a) ? D.call(c, a) : d.merge(c, a) } return c }, inArray: function (a, b) { if (b.indexOf) return b.indexOf(a); for (var c = 0, d = b.length; c < d; c++) if (b[c] === a) return c; return -1 }, merge: function (a, c) { var d = a.length, e = 0; if (typeof c.length === "number") for (var f = c.length; e < f; e++) a[d++] = c[e]; else while (c[e] !== b) a[d++] = c[e++]; a.length = d; return a }, grep: function (a, b, c) { var d = [], e; c = !!c; for (var f = 0, g = a.length; f < g; f++) e = !!b(a[f], f), c !== e && d.push(a[f]); return d }, map: function (a, b, c) { var d = [], e; for (var f = 0, g = a.length; f < g; f++) e = b(a[f], f, c), e != null && (d[d.length] = e); return d.concat.apply([], d) }, guid: 1, proxy: function (a, c, e) { arguments.length === 2 && (typeof c === "string" ? (e = a, a = e[c], c = b) : c && !d.isFunction(c) && (e = c, c = b)), !c && a && (c = function () { return a.apply(e || this, arguments) }), a && (c.guid = a.guid = a.guid || c.guid || d.guid++); return c }, access: function (a, c, e, f, g, h) { var i = a.length; if (typeof c === "object") { for (var j in c) d.access(a, j, c[j], f, g, e); return a } if (e !== b) { f = !h && f && d.isFunction(e); for (var k = 0; k < i; k++) g(a[k], c, f ? e.call(a[k], k, g(a[k], c)) : e, h); return a } return i ? g(a[0], c) : b }, now: function () { return (new Date).getTime() }, _Deferred: function () { var a = [], b, c, e, f = { done: function () { if (!e) { var c = arguments, g, h, i, j, k; b && (k = b, b = 0); for (g = 0, h = c.length; g < h; g++) i = c[g], j = d.type(i), j === "array" ? f.done.apply(f, i) : j === "function" && a.push(i); k && f.resolveWith(k[0], k[1]) } return this }, resolveWith: function (d, f) { if (!e && !b && !c) { c = 1; try { while (a[0]) a.shift().apply(d, f) } catch (g) { throw g } finally { b = [d, f], c = 0 } } return this }, resolve: function () { f.resolveWith(d.isFunction(this.promise) ? this.promise() : this, arguments); return this }, isResolved: function () { return c || b }, cancel: function () { e = 1, a = []; return this } }; return f }, Deferred: function (a) { var b = d._Deferred(), c = d._Deferred(), e; d.extend(b, { then: function (a, c) { b.done(a).fail(c); return this }, fail: c.done, rejectWith: c.resolveWith, reject: c.resolve, isRejected: c.isResolved, promise: function (a) { if (a == null) { if (e) return e; e = a = {} } var c = z.length; while (c--) a[z[c]] = b[z[c]]; return a } }), b.done(c.cancel).fail(b.cancel), delete b.cancel, a && a.call(b, b); return b }, when: function (a) { var b = arguments.length, c = b <= 1 && a && d.isFunction(a.promise) ? a : d.Deferred(), e = c.promise(); if (b > 1) { var f = E.call(arguments, 0), g = b, h = function (a) { return function (b) { f[a] = arguments.length > 1 ? E.call(arguments, 0) : b, --g || c.resolveWith(e, f) } }; while (b--) a = f[b], a && d.isFunction(a.promise) ? a.promise().then(h(b), c.reject) : --g; g || c.resolveWith(e, f) } else c !== a && c.resolve(a); return e }, uaMatch: function (a) { a = a.toLowerCase(); var b = r.exec(a) || s.exec(a) || t.exec(a) || a.indexOf("compatible") < 0 && u.exec(a) || []; return { browser: b[1] || "", version: b[2] || "0"} }, sub: function () { function a(b, c) { return new a.fn.init(b, c) } d.extend(!0, a, this), a.superclass = this, a.fn = a.prototype = this(), a.fn.constructor = a, a.subclass = this.subclass, a.fn.init = function b(b, c) { c && c instanceof d && !(c instanceof a) && (c = a(c)); return d.fn.init.call(this, b, c, e) }, a.fn.init.prototype = a.fn; var e = a(c); return a }, browser: {} }), y = d._Deferred(), d.each("Boolean Number String Function Array Date RegExp Object".split(" "), function (a, b) { H["[object " + b + "]"] = b.toLowerCase() }), w = d.uaMatch(v), w.browser && (d.browser[w.browser] = !0, d.browser.version = w.version), d.browser.webkit && (d.browser.safari = !0), G && (d.inArray = function (a, b) { return G.call(b, a) }), i.test("Â ") && (j = /^[\s\xA0]+/, k = /[\s\xA0]+$/), g = d(c), c.addEventListener ? A = function () { c.removeEventListener("DOMContentLoaded", A, !1), d.ready() } : c.attachEvent && (A = function () { c.readyState === "complete" && (c.detachEvent("onreadystatechange", A), d.ready()) }); return d } (); (function () { d.support = {}; var b = c.createElement("div"); b.style.display = "none", b.innerHTML = "   <link/><table></table><a href='/a' style='color:red;float:left;opacity:.55;'>a</a><input type='checkbox'/>"; var e = b.getElementsByTagName("*"), f = b.getElementsByTagName("a")[0], g = c.createElement("select"), h = g.appendChild(c.createElement("option")), i = b.getElementsByTagName("input")[0]; if (e && e.length && f) { d.support = { leadingWhitespace: b.firstChild.nodeType === 3, tbody: !b.getElementsByTagName("tbody").length, htmlSerialize: !!b.getElementsByTagName("link").length, style: /red/.test(f.getAttribute("style")), hrefNormalized: f.getAttribute("href") === "/a", opacity: /^0.55$/.test(f.style.opacity), cssFloat: !!f.style.cssFloat, checkOn: i.value === "on", optSelected: h.selected, deleteExpando: !0, optDisabled: !1, checkClone: !1, noCloneEvent: !0, noCloneChecked: !0, boxModel: null, inlineBlockNeedsLayout: !1, shrinkWrapBlocks: !1, reliableHiddenOffsets: !0 }, i.checked = !0, d.support.noCloneChecked = i.cloneNode(!0).checked, g.disabled = !0, d.support.optDisabled = !h.disabled; var j = null; d.support.scriptEval = function () { if (j === null) { var b = c.documentElement, e = c.createElement("script"), f = "script" + d.now(); try { e.appendChild(c.createTextNode("window." + f + "=1;")) } catch (g) { } b.insertBefore(e, b.firstChild), a[f] ? (j = !0, delete a[f]) : j = !1, b.removeChild(e), b = e = f = null } return j }; try { delete b.test } catch (k) { d.support.deleteExpando = !1 } !b.addEventListener && b.attachEvent && b.fireEvent && (b.attachEvent("onclick", function l() { d.support.noCloneEvent = !1, b.detachEvent("onclick", l) }), b.cloneNode(!0).fireEvent("onclick")), b = c.createElement("div"), b.innerHTML = "<input type='radio' name='radiotest' checked='checked'/>"; var m = c.createDocumentFragment(); m.appendChild(b.firstChild), d.support.checkClone = m.cloneNode(!0).cloneNode(!0).lastChild.checked, d(function () { var a = c.createElement("div"), b = c.getElementsByTagName("body")[0]; if (b) { a.style.width = a.style.paddingLeft = "1px", b.appendChild(a), d.boxModel = d.support.boxModel = a.offsetWidth === 2, "zoom" in a.style && (a.style.display = "inline", a.style.zoom = 1, d.support.inlineBlockNeedsLayout = a.offsetWidth === 2, a.style.display = "", a.innerHTML = "<div style='width:4px;'></div>", d.support.shrinkWrapBlocks = a.offsetWidth !== 2), a.innerHTML = "<table><tr><td style='padding:0;border:0;display:none'></td><td>t</td></tr></table>"; var e = a.getElementsByTagName("td"); d.support.reliableHiddenOffsets = e[0].offsetHeight === 0, e[0].style.display = "", e[1].style.display = "none", d.support.reliableHiddenOffsets = d.support.reliableHiddenOffsets && e[0].offsetHeight === 0, a.innerHTML = "", b.removeChild(a).style.display = "none", a = e = null } }); var n = function (a) { var b = c.createElement("div"); a = "on" + a; if (!b.attachEvent) return !0; var d = a in b; d || (b.setAttribute(a, "return;"), d = typeof b[a] === "function"), b = null; return d }; d.support.submitBubbles = n("submit"), d.support.changeBubbles = n("change"), b = e = f = null } })(); var e = /^(?:\{.*\}|\[.*\])$/; d.extend({ cache: {}, uuid: 0, expando: "jQuery" + (d.fn.jquery + Math.random()).replace(/\D/g, ""), noData: { embed: !0, object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000", applet: !0 }, hasData: function (a) { a = a.nodeType ? d.cache[a[d.expando]] : a[d.expando]; return !!a && !g(a) }, data: function (a, c, e, f) { if (d.acceptData(a)) { var g = d.expando, h = typeof c === "string", i, j = a.nodeType, k = j ? d.cache : a, l = j ? a[d.expando] : a[d.expando] && d.expando; if ((!l || f && l && !k[l][g]) && h && e === b) return; l || (j ? a[d.expando] = l = ++d.uuid : l = d.expando), k[l] || (k[l] = {}, j || (k[l].toJSON = d.noop)); if (typeof c === "object" || typeof c === "function") f ? k[l][g] = d.extend(k[l][g], c) : k[l] = d.extend(k[l], c); i = k[l], f && (i[g] || (i[g] = {}), i = i[g]), e !== b && (i[c] = e); if (c === "events" && !i[c]) return i[g] && i[g].events; return h ? i[c] : i } }, removeData: function (b, c, e) { if (d.acceptData(b)) { var f = d.expando, h = b.nodeType, i = h ? d.cache : b, j = h ? b[d.expando] : d.expando; if (!i[j]) return; if (c) { var k = e ? i[j][f] : i[j]; if (k) { delete k[c]; if (!g(k)) return } } if (e) { delete i[j][f]; if (!g(i[j])) return } var l = i[j][f]; d.support.deleteExpando || i != a ? delete i[j] : i[j] = null, l ? (i[j] = {}, h || (i[j].toJSON = d.noop), i[j][f] = l) : h && (d.support.deleteExpando ? delete b[d.expando] : b.removeAttribute ? b.removeAttribute(d.expando) : b[d.expando] = null) } }, _data: function (a, b, c) { return d.data(a, b, c, !0) }, acceptData: function (a) { if (a.nodeName) { var b = d.noData[a.nodeName.toLowerCase()]; if (b) return b !== !0 && a.getAttribute("classid") === b } return !0 } }), d.fn.extend({ data: function (a, c) { var e = null; if (typeof a === "undefined") { if (this.length) { e = d.data(this[0]); if (this[0].nodeType === 1) { var g = this[0].attributes, h; for (var i = 0, j = g.length; i < j; i++) h = g[i].name, h.indexOf("data-") === 0 && (h = h.substr(5), f(this[0], h, e[h])) } } return e } if (typeof a === "object") return this.each(function () { d.data(this, a) }); var k = a.split("."); k[1] = k[1] ? "." + k[1] : ""; if (c === b) { e = this.triggerHandler("getData" + k[1] + "!", [k[0]]), e === b && this.length && (e = d.data(this[0], a), e = f(this[0], a, e)); return e === b && k[1] ? this.data(k[0]) : e } return this.each(function () { var b = d(this), e = [k[0], c]; b.triggerHandler("setData" + k[1] + "!", e), d.data(this, a, c), b.triggerHandler("changeData" + k[1] + "!", e) }) }, removeData: function (a) { return this.each(function () { d.removeData(this, a) }) } }), d.extend({ queue: function (a, b, c) { if (a) { b = (b || "fx") + "queue"; var e = d._data(a, b); if (!c) return e || []; !e || d.isArray(c) ? e = d._data(a, b, d.makeArray(c)) : e.push(c); return e } }, dequeue: function (a, b) { b = b || "fx"; var c = d.queue(a, b), e = c.shift(); e === "inprogress" && (e = c.shift()), e && (b === "fx" && c.unshift("inprogress"), e.call(a, function () { d.dequeue(a, b) })), c.length || d.removeData(a, b + "queue", !0) } }), d.fn.extend({ queue: function (a, c) { typeof a !== "string" && (c = a, a = "fx"); if (c === b) return d.queue(this[0], a); return this.each(function (b) { var e = d.queue(this, a, c); a === "fx" && e[0] !== "inprogress" && d.dequeue(this, a) }) }, dequeue: function (a) { return this.each(function () { d.dequeue(this, a) }) }, delay: function (a, b) { a = d.fx ? d.fx.speeds[a] || a : a, b = b || "fx"; return this.queue(b, function () { var c = this; setTimeout(function () { d.dequeue(c, b) }, a) }) }, clearQueue: function (a) { return this.queue(a || "fx", []) } }); var h = /[\n\t\r]/g, i = /\s+/, j = /\r/g, k = /^(?:href|src|style)$/, l = /^(?:button|input)$/i, m = /^(?:button|input|object|select|textarea)$/i, n = /^a(?:rea)?$/i, o = /^(?:radio|checkbox)$/i; d.props = { "for": "htmlFor", "class": "className", readonly: "readOnly", maxlength: "maxLength", cellspacing: "cellSpacing", rowspan: "rowSpan", colspan: "colSpan", tabindex: "tabIndex", usemap: "useMap", frameborder: "frameBorder" }, d.fn.extend({ attr: function (a, b) { return d.access(this, a, b, !0, d.attr) }, removeAttr: function (a, b) { return this.each(function () { d.attr(this, a, ""), this.nodeType === 1 && this.removeAttribute(a) }) }, addClass: function (a) { if (d.isFunction(a)) return this.each(function (b) { var c = d(this); c.addClass(a.call(this, b, c.attr("class"))) }); if (a && typeof a === "string") { var b = (a || "").split(i); for (var c = 0, e = this.length; c < e; c++) { var f = this[c]; if (f.nodeType === 1) if (f.className) { var g = " " + f.className + " ", h = f.className; for (var j = 0, k = b.length; j < k; j++) g.indexOf(" " + b[j] + " ") < 0 && (h += " " + b[j]); f.className = d.trim(h) } else f.className = a } } return this }, removeClass: function (a) { if (d.isFunction(a)) return this.each(function (b) { var c = d(this); c.removeClass(a.call(this, b, c.attr("class"))) }); if (a && typeof a === "string" || a === b) { var c = (a || "").split(i); for (var e = 0, f = this.length; e < f; e++) { var g = this[e]; if (g.nodeType === 1 && g.className) if (a) { var j = (" " + g.className + " ").replace(h, " "); for (var k = 0, l = c.length; k < l; k++) j = j.replace(" " + c[k] + " ", " "); g.className = d.trim(j) } else g.className = "" } } return this }, toggleClass: function (a, b) { var c = typeof a, e = typeof b === "boolean"; if (d.isFunction(a)) return this.each(function (c) { var e = d(this); e.toggleClass(a.call(this, c, e.attr("class"), b), b) }); return this.each(function () { if (c === "string") { var f, g = 0, h = d(this), j = b, k = a.split(i); while (f = k[g++]) j = e ? j : !h.hasClass(f), h[j ? "addClass" : "removeClass"](f) } else if (c === "undefined" || c === "boolean") this.className && d._data(this, "__className__", this.className), this.className = this.className || a === !1 ? "" : d._data(this, "__className__") || "" }) }, hasClass: function (a) { var b = " " + a + " "; for (var c = 0, d = this.length; c < d; c++) if ((" " + this[c].className + " ").replace(h, " ").indexOf(b) > -1) return !0; return !1 }, val: function (a) { if (!arguments.length) { var c = this[0]; if (c) { if (d.nodeName(c, "option")) { var e = c.attributes.value; return !e || e.specified ? c.value : c.text } if (d.nodeName(c, "select")) { var f = c.selectedIndex, g = [], h = c.options, i = c.type === "select-one"; if (f < 0) return null; for (var k = i ? f : 0, l = i ? f + 1 : h.length; k < l; k++) { var m = h[k]; if (m.selected && (d.support.optDisabled ? !m.disabled : m.getAttribute("disabled") === null) && (!m.parentNode.disabled || !d.nodeName(m.parentNode, "optgroup"))) { a = d(m).val(); if (i) return a; g.push(a) } } if (i && !g.length && h.length) return d(h[f]).val(); return g } if (o.test(c.type) && !d.support.checkOn) return c.getAttribute("value") === null ? "on" : c.value; return (c.value || "").replace(j, "") } return b } var n = d.isFunction(a); return this.each(function (b) { var c = d(this), e = a; if (this.nodeType === 1) { n && (e = a.call(this, b, c.val())), e == null ? e = "" : typeof e === "number" ? e += "" : d.isArray(e) && (e = d.map(e, function (a) { return a == null ? "" : a + "" })); if (d.isArray(e) && o.test(this.type)) this.checked = d.inArray(c.val(), e) >= 0; else if (d.nodeName(this, "select")) { var f = d.makeArray(e); d("option", this).each(function () { this.selected = d.inArray(d(this).val(), f) >= 0 }), f.length || (this.selectedIndex = -1) } else this.value = e } }) } }), d.extend({ attrFn: { val: !0, css: !0, html: !0, text: !0, data: !0, width: !0, height: !0, offset: !0 }, attr: function (a, c, e, f) { if (!a || a.nodeType === 3 || a.nodeType === 8 || a.nodeType === 2) return b; if (f && c in d.attrFn) return d(a)[c](e); var g = a.nodeType !== 1 || !d.isXMLDoc(a), h = e !== b; c = g && d.props[c] || c; if (a.nodeType === 1) { var i = k.test(c); if (c === "selected" && !d.support.optSelected) { var j = a.parentNode; j && (j.selectedIndex, j.parentNode && j.parentNode.selectedIndex) } if ((c in a || a[c] !== b) && g && !i) { h && (c === "type" && l.test(a.nodeName) && a.parentNode && d.error("type property can't be changed"), e === null ? a.nodeType === 1 && a.removeAttribute(c) : a[c] = e); if (d.nodeName(a, "form") && a.getAttributeNode(c)) return a.getAttributeNode(c).nodeValue; if (c === "tabIndex") { var o = a.getAttributeNode("tabIndex"); return o && o.specified ? o.value : m.test(a.nodeName) || n.test(a.nodeName) && a.href ? 0 : b } return a[c] } if (!d.support.style && g && c === "style") { h && (a.style.cssText = "" + e); return a.style.cssText } h && a.setAttribute(c, "" + e); if (!a.attributes[c] && (a.hasAttribute && !a.hasAttribute(c))) return b; var p = !d.support.hrefNormalized && g && i ? a.getAttribute(c, 2) : a.getAttribute(c); return p === null ? b : p } h && (a[c] = e); return a[c] } }); var p = /\.(.*)$/, q = /^(?:textarea|input|select)$/i, r = /\./g, s = / /g, t = /[^\w\s.|`]/g, u = function (a) { return a.replace(t, "\\$&") }; d.event = { add: function (c, e, f, g) { if (c.nodeType !== 3 && c.nodeType !== 8) { try { d.isWindow(c) && (c !== a && !c.frameElement) && (c = a) } catch (h) { } if (f === !1) f = v; else if (!f) return; var i, j; f.handler && (i = f, f = i.handler), f.guid || (f.guid = d.guid++); var k = d._data(c); if (!k) return; var l = k.events, m = k.handle; l || (k.events = l = {}), m || (k.handle = m = function () { return typeof d !== "undefined" && !d.event.triggered ? d.event.handle.apply(m.elem, arguments) : b }), m.elem = c, e = e.split(" "); var n, o = 0, p; while (n = e[o++]) { j = i ? d.extend({}, i) : { handler: f, data: g }, n.indexOf(".") > -1 ? (p = n.split("."), n = p.shift(), j.namespace = p.slice(0).sort().join(".")) : (p = [], j.namespace = ""), j.type = n, j.guid || (j.guid = f.guid); var q = l[n], r = d.event.special[n] || {}; if (!q) { q = l[n] = []; if (!r.setup || r.setup.call(c, g, p, m) === !1) c.addEventListener ? c.addEventListener(n, m, !1) : c.attachEvent && c.attachEvent("on" + n, m) } r.add && (r.add.call(c, j), j.handler.guid || (j.handler.guid = f.guid)), q.push(j), d.event.global[n] = !0 } c = null } }, global: {}, remove: function (a, c, e, f) { if (a.nodeType !== 3 && a.nodeType !== 8) { e === !1 && (e = v); var g, h, i, j, k = 0, l, m, n, o, p, q, r, s = d.hasData(a) && d._data(a), t = s && s.events; if (!s || !t) return; c && c.type && (e = c.handler, c = c.type); if (!c || typeof c === "string" && c.charAt(0) === ".") { c = c || ""; for (h in t) d.event.remove(a, h + c); return } c = c.split(" "); while (h = c[k++]) { r = h, q = null, l = h.indexOf(".") < 0, m = [], l || (m = h.split("."), h = m.shift(), n = new RegExp("(^|\\.)" + d.map(m.slice(0).sort(), u).join("\\.(?:.*\\.)?") + "(\\.|$)")), p = t[h]; if (!p) continue; if (!e) { for (j = 0; j < p.length; j++) { q = p[j]; if (l || n.test(q.namespace)) d.event.remove(a, r, q.handler, j), p.splice(j--, 1) } continue } o = d.event.special[h] || {}; for (j = f || 0; j < p.length; j++) { q = p[j]; if (e.guid === q.guid) { if (l || n.test(q.namespace)) f == null && p.splice(j--, 1), o.remove && o.remove.call(a, q); if (f != null) break } } if (p.length === 0 || f != null && p.length === 1) (!o.teardown || o.teardown.call(a, m) === !1) && d.removeEvent(a, h, s.handle), g = null, delete t[h] } if (d.isEmptyObject(t)) { var w = s.handle; w && (w.elem = null), delete s.events, delete s.handle, d.isEmptyObject(s) && d.removeData(a, b, !0) } } }, trigger: function (a, c, e) { var f = a.type || a, g = arguments[3]; if (!g) { a = typeof a === "object" ? a[d.expando] ? a : d.extend(d.Event(f), a) : d.Event(f), f.indexOf("!") >= 0 && (a.type = f = f.slice(0, -1), a.exclusive = !0), e || (a.stopPropagation(), d.event.global[f] && d.each(d.cache, function () { var b = d.expando, e = this[b]; e && e.events && e.events[f] && d.event.trigger(a, c, e.handle.elem) })); if (!e || e.nodeType === 3 || e.nodeType === 8) return b; a.result = b, a.target = e, c = d.makeArray(c), c.unshift(a) } a.currentTarget = e; var h = d._data(e, "handle"); h && h.apply(e, c); var i = e.parentNode || e.ownerDocument; try { e && e.nodeName && d.noData[e.nodeName.toLowerCase()] || e["on" + f] && e["on" + f].apply(e, c) === !1 && (a.result = !1, a.preventDefault()) } catch (j) { } if (!a.isPropagationStopped() && i) d.event.trigger(a, c, i, !0); else if (!a.isDefaultPrevented()) { var k, l = a.target, m = f.replace(p, ""), n = d.nodeName(l, "a") && m === "click", o = d.event.special[m] || {}; if ((!o._default || o._default.call(e, a) === !1) && !n && !(l && l.nodeName && d.noData[l.nodeName.toLowerCase()])) { try { l[m] && (k = l["on" + m], k && (l["on" + m] = null), d.event.triggered = !0, l[m]()) } catch (q) { } k && (l["on" + m] = k), d.event.triggered = !1 } } }, handle: function (c) { var e, f, g, h, i, j = [], k = d.makeArray(arguments); c = k[0] = d.event.fix(c || a.event), c.currentTarget = this, e = c.type.indexOf(".") < 0 && !c.exclusive, e || (g = c.type.split("."), c.type = g.shift(), j = g.slice(0).sort(), h = new RegExp("(^|\\.)" + j.join("\\.(?:.*\\.)?") + "(\\.|$)")), c.namespace = c.namespace || j.join("."), i = d._data(this, "events"), f = (i || {})[c.type]; if (i && f) { f = f.slice(0); for (var l = 0, m = f.length; l < m; l++) { var n = f[l]; if (e || h.test(n.namespace)) { c.handler = n.handler, c.data = n.data, c.handleObj = n; var o = n.handler.apply(this, k); o !== b && (c.result = o, o === !1 && (c.preventDefault(), c.stopPropagation())); if (c.isImmediatePropagationStopped()) break } } } return c.result }, props: "altKey attrChange attrName bubbles button cancelable charCode clientX clientY ctrlKey currentTarget data detail eventPhase fromElement handler keyCode layerX layerY metaKey newValue offsetX offsetY pageX pageY prevValue relatedNode relatedTarget screenX screenY shiftKey srcElement target toElement view wheelDelta which".split(" "), fix: function (a) { if (a[d.expando]) return a; var e = a; a = d.Event(e); for (var f = this.props.length, g; f; ) g = this.props[--f], a[g] = e[g]; a.target || (a.target = a.srcElement || c), a.target.nodeType === 3 && (a.target = a.target.parentNode), !a.relatedTarget && a.fromElement && (a.relatedTarget = a.fromElement === a.target ? a.toElement : a.fromElement); if (a.pageX == null && a.clientX != null) { var h = c.documentElement, i = c.body; a.pageX = a.clientX + (h && h.scrollLeft || i && i.scrollLeft || 0) - (h && h.clientLeft || i && i.clientLeft || 0), a.pageY = a.clientY + (h && h.scrollTop || i && i.scrollTop || 0) - (h && h.clientTop || i && i.clientTop || 0) } a.which == null && (a.charCode != null || a.keyCode != null) && (a.which = a.charCode != null ? a.charCode : a.keyCode), !a.metaKey && a.ctrlKey && (a.metaKey = a.ctrlKey), !a.which && a.button !== b && (a.which = a.button & 1 ? 1 : a.button & 2 ? 3 : a.button & 4 ? 2 : 0); return a }, guid: 1e8, proxy: d.proxy, special: { ready: { setup: d.bindReady, teardown: d.noop }, live: { add: function (a) { d.event.add(this, F(a.origType, a.selector), d.extend({}, a, { handler: E, guid: a.handler.guid })) }, remove: function (a) { d.event.remove(this, F(a.origType, a.selector), a) } }, beforeunload: { setup: function (a, b, c) { d.isWindow(this) && (this.onbeforeunload = c) }, teardown: function (a, b) { this.onbeforeunload === b && (this.onbeforeunload = null) } }} }, d.removeEvent = c.removeEventListener ? function (a, b, c) { a.removeEventListener && a.removeEventListener(b, c, !1) } : function (a, b, c) { a.detachEvent && a.detachEvent("on" + b, c) }, d.Event = function (a) { if (!this.preventDefault) return new d.Event(a); a && a.type ? (this.originalEvent = a, this.type = a.type, this.isDefaultPrevented = a.defaultPrevented || a.returnValue === !1 || a.getPreventDefault && a.getPreventDefault() ? w : v) : this.type = a, this.timeStamp = d.now(), this[d.expando] = !0 }, d.Event.prototype = { preventDefault: function () { this.isDefaultPrevented = w; var a = this.originalEvent; a && (a.preventDefault ? a.preventDefault() : a.returnValue = !1) }, stopPropagation: function () { this.isPropagationStopped = w; var a = this.originalEvent; a && (a.stopPropagation && a.stopPropagation(), a.cancelBubble = !0) }, stopImmediatePropagation: function () { this.isImmediatePropagationStopped = w, this.stopPropagation() }, isDefaultPrevented: v, isPropagationStopped: v, isImmediatePropagationStopped: v }; var x = function (a) { var b = a.relatedTarget; try { if (b !== c && !b.parentNode) return; while (b && b !== this) b = b.parentNode; b !== this && (a.type = a.data, d.event.handle.apply(this, arguments)) } catch (e) { } }, y = function (a) { a.type = a.data, d.event.handle.apply(this, arguments) }; d.each({ mouseenter: "mouseover", mouseleave: "mouseout" }, function (a, b) { d.event.special[a] = { setup: function (c) { d.event.add(this, b, c && c.selector ? y : x, a) }, teardown: function (a) { d.event.remove(this, b, a && a.selector ? y : x) } } }), d.support.submitBubbles || (d.event.special.submit = { setup: function (a, b) { if (this.nodeName && this.nodeName.toLowerCase() !== "form") d.event.add(this, "click.specialSubmit", function (a) { var b = a.target, c = b.type; (c === "submit" || c === "image") && d(b).closest("form").length && C("submit", this, arguments) }), d.event.add(this, "keypress.specialSubmit", function (a) { var b = a.target, c = b.type; (c === "text" || c === "password") && d(b).closest("form").length && a.keyCode === 13 && C("submit", this, arguments) }); else return !1 }, teardown: function (a) { d.event.remove(this, ".specialSubmit") } }); if (!d.support.changeBubbles) { var z, A = function (a) { var b = a.type, c = a.value; b === "radio" || b === "checkbox" ? c = a.checked : b === "select-multiple" ? c = a.selectedIndex > -1 ? d.map(a.options, function (a) { return a.selected }).join("-") : "" : a.nodeName.toLowerCase() === "select" && (c = a.selectedIndex); return c }, B = function B(a) { var c = a.target, e, f; if (q.test(c.nodeName) && !c.readOnly) { e = d._data(c, "_change_data"), f = A(c), (a.type !== "focusout" || c.type !== "radio") && d._data(c, "_change_data", f); if (e === b || f === e) return; if (e != null || f) a.type = "change", a.liveFired = b, d.event.trigger(a, arguments[1], c) } }; d.event.special.change = { filters: { focusout: B, beforedeactivate: B, click: function (a) { var b = a.target, c = b.type; (c === "radio" || c === "checkbox" || b.nodeName.toLowerCase() === "select") && B.call(this, a) }, keydown: function (a) { var b = a.target, c = b.type; (a.keyCode === 13 && b.nodeName.toLowerCase() !== "textarea" || a.keyCode === 32 && (c === "checkbox" || c === "radio") || c === "select-multiple") && B.call(this, a) }, beforeactivate: function (a) { var b = a.target; d._data(b, "_change_data", A(b)) } }, setup: function (a, b) { if (this.type === "file") return !1; for (var c in z) d.event.add(this, c + ".specialChange", z[c]); return q.test(this.nodeName) }, teardown: function (a) { d.event.remove(this, ".specialChange"); return q.test(this.nodeName) } }, z = d.event.special.change.filters, z.focus = z.beforeactivate } c.addEventListener && d.each({ focus: "focusin", blur: "focusout" }, function (a, b) { function c(a) { a = d.event.fix(a), a.type = b; return d.event.handle.call(this, a) } d.event.special[b] = { setup: function () { this.addEventListener(a, c, !0) }, teardown: function () { this.removeEventListener(a, c, !0) } } }), d.each(["bind", "one"], function (a, c) { d.fn[c] = function (a, e, f) { if (typeof a === "object") { for (var g in a) this[c](g, e, a[g], f); return this } if (d.isFunction(e) || e === !1) f = e, e = b; var h = c === "one" ? d.proxy(f, function (a) { d(this).unbind(a, h); return f.apply(this, arguments) }) : f; if (a === "unload" && c !== "one") this.one(a, e, f); else for (var i = 0, j = this.length; i < j; i++) d.event.add(this[i], a, h, e); return this } }), d.fn.extend({ unbind: function (a, b) { if (typeof a !== "object" || a.preventDefault) for (var e = 0, f = this.length; e < f; e++) d.event.remove(this[e], a, b); else for (var c in a) this.unbind(c, a[c]); return this }, delegate: function (a, b, c, d) { return this.live(b, c, d, a) }, undelegate: function (a, b, c) { return arguments.length === 0 ? this.unbind("live") : this.die(b, null, c, a) }, trigger: function (a, b) { return this.each(function () { d.event.trigger(a, b, this) }) }, triggerHandler: function (a, b) { if (this[0]) { var c = d.Event(a); c.preventDefault(), c.stopPropagation(), d.event.trigger(c, b, this[0]); return c.result } }, toggle: function (a) { var b = arguments, c = 1; while (c < b.length) d.proxy(a, b[c++]); return this.click(d.proxy(a, function (e) { var f = (d._data(this, "lastToggle" + a.guid) || 0) % c; d._data(this, "lastToggle" + a.guid, f + 1), e.preventDefault(); return b[f].apply(this, arguments) || !1 })) }, hover: function (a, b) { return this.mouseenter(a).mouseleave(b || a) } }); var D = { focus: "focusin", blur: "focusout", mouseenter: "mouseover", mouseleave: "mouseout" }; d.each(["live", "die"], function (a, c) { d.fn[c] = function (a, e, f, g) { var h, i = 0, j, k, l, m = g || this.selector, n = g ? this : d(this.context); if (typeof a === "object" && !a.preventDefault) { for (var o in a) n[c](o, e, a[o], m); return this } d.isFunction(e) && (f = e, e = b), a = (a || "").split(" "); while ((h = a[i++]) != null) { j = p.exec(h), k = "", j && (k = j[0], h = h.replace(p, "")); if (h === "hover") { a.push("mouseenter" + k, "mouseleave" + k); continue } l = h, h === "focus" || h === "blur" ? (a.push(D[h] + k), h = h + k) : h = (D[h] || h) + k; if (c === "live") for (var q = 0, r = n.length; q < r; q++) d.event.add(n[q], "live." + F(h, m), { data: e, selector: m, handler: f, origType: h, origHandler: f, preType: l }); else n.unbind("live." + F(h, m), f) } return this } }), d.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error".split(" "), function (a, b) { d.fn[b] = function (a, c) { c == null && (c = a, a = null); return arguments.length > 0 ? this.bind(b, a, c) : this.trigger(b) }, d.attrFn && (d.attrFn[b] = !0) }), function () { function u(a, b, c, d, e, f) { for (var g = 0, h = d.length; g < h; g++) { var i = d[g]; if (i) { var j = !1; i = i[a]; while (i) { if (i.sizcache === c) { j = d[i.sizset]; break } if (i.nodeType === 1) { f || (i.sizcache = c, i.sizset = g); if (typeof b !== "string") { if (i === b) { j = !0; break } } else if (k.filter(b, [i]).length > 0) { j = i; break } } i = i[a] } d[g] = j } } } function t(a, b, c, d, e, f) { for (var g = 0, h = d.length; g < h; g++) { var i = d[g]; if (i) { var j = !1; i = i[a]; while (i) { if (i.sizcache === c) { j = d[i.sizset]; break } i.nodeType === 1 && !f && (i.sizcache = c, i.sizset = g); if (i.nodeName.toLowerCase() === b) { j = i; break } i = i[a] } d[g] = j } } } var a = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g, e = 0, f = Object.prototype.toString, g = !1, h = !0, i = /\\/g, j = /\W/; [0, 0].sort(function () { h = !1; return 0 }); var k = function (b, d, e, g) { e = e || [], d = d || c; var h = d; if (d.nodeType !== 1 && d.nodeType !== 9) return []; if (!b || typeof b !== "string") return e; var i, j, n, o, q, r, s, t, u = !0, w = k.isXML(d), x = [], y = b; do { a.exec(""), i = a.exec(y); if (i) { y = i[3], x.push(i[1]); if (i[2]) { o = i[3]; break } } } while (i); if (x.length > 1 && m.exec(b)) if (x.length === 2 && l.relative[x[0]]) j = v(x[0] + x[1], d); else { j = l.relative[x[0]] ? [d] : k(x.shift(), d); while (x.length) b = x.shift(), l.relative[b] && (b += x.shift()), j = v(b, j) } else { !g && x.length > 1 && d.nodeType === 9 && !w && l.match.ID.test(x[0]) && !l.match.ID.test(x[x.length - 1]) && (q = k.find(x.shift(), d, w), d = q.expr ? k.filter(q.expr, q.set)[0] : q.set[0]); if (d) { q = g ? { expr: x.pop(), set: p(g)} : k.find(x.pop(), x.length === 1 && (x[0] === "~" || x[0] === "+") && d.parentNode ? d.parentNode : d, w), j = q.expr ? k.filter(q.expr, q.set) : q.set, x.length > 0 ? n = p(j) : u = !1; while (x.length) r = x.pop(), s = r, l.relative[r] ? s = x.pop() : r = "", s == null && (s = d), l.relative[r](n, s, w) } else n = x = [] } n || (n = j), n || k.error(r || b); if (f.call(n) === "[object Array]") if (u) if (d && d.nodeType === 1) for (t = 0; n[t] != null; t++) n[t] && (n[t] === !0 || n[t].nodeType === 1 && k.contains(d, n[t])) && e.push(j[t]); else for (t = 0; n[t] != null; t++) n[t] && n[t].nodeType === 1 && e.push(j[t]); else e.push.apply(e, n); else p(n, e); o && (k(o, h, e, g), k.uniqueSort(e)); return e }; k.uniqueSort = function (a) { if (r) { g = h, a.sort(r); if (g) for (var b = 1; b < a.length; b++) a[b] === a[b - 1] && a.splice(b--, 1) } return a }, k.matches = function (a, b) { return k(a, null, null, b) }, k.matchesSelector = function (a, b) { return k(b, null, null, [a]).length > 0 }, k.find = function (a, b, c) { var d; if (!a) return []; for (var e = 0, f = l.order.length; e < f; e++) { var g, h = l.order[e]; if (g = l.leftMatch[h].exec(a)) { var j = g[1]; g.splice(1, 1); if (j.substr(j.length - 1) !== "\\") { g[1] = (g[1] || "").replace(i, ""), d = l.find[h](g, b, c); if (d != null) { a = a.replace(l.match[h], ""); break } } } } d || (d = typeof b.getElementsByTagName !== "undefined" ? b.getElementsByTagName("*") : []); return { set: d, expr: a} }, k.filter = function (a, c, d, e) { var f, g, h = a, i = [], j = c, m = c && c[0] && k.isXML(c[0]); while (a && c.length) { for (var n in l.filter) if ((f = l.leftMatch[n].exec(a)) != null && f[2]) { var o, p, q = l.filter[n], r = f[1]; g = !1, f.splice(1, 1); if (r.substr(r.length - 1) === "\\") continue; j === i && (i = []); if (l.preFilter[n]) { f = l.preFilter[n](f, j, d, i, e, m); if (f) { if (f === !0) continue } else g = o = !0 } if (f) for (var s = 0; (p = j[s]) != null; s++) if (p) { o = q(p, f, s, j); var t = e ^ !!o; d && o != null ? t ? g = !0 : j[s] = !1 : t && (i.push(p), g = !0) } if (o !== b) { d || (j = i), a = a.replace(l.match[n], ""); if (!g) return []; break } } if (a === h) if (g == null) k.error(a); else break; h = a } return j }, k.error = function (a) { throw "Syntax error, unrecognized expression: " + a }; var l = k.selectors = { order: ["ID", "NAME", "TAG"], match: { ID: /#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/, CLASS: /\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/, NAME: /\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/, ATTR: /\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/, TAG: /^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/, CHILD: /:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/, POS: /:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/, PSEUDO: /:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/ }, leftMatch: {}, attrMap: { "class": "className", "for": "htmlFor" }, attrHandle: { href: function (a) { return a.getAttribute("href") }, type: function (a) { return a.getAttribute("type") } }, relative: { "+": function (a, b) { var c = typeof b === "string", d = c && !j.test(b), e = c && !d; d && (b = b.toLowerCase()); for (var f = 0, g = a.length, h; f < g; f++) if (h = a[f]) { while ((h = h.previousSibling) && h.nodeType !== 1) { } a[f] = e || h && h.nodeName.toLowerCase() === b ? h || !1 : h === b } e && k.filter(b, a, !0) }, ">": function (a, b) { var c, d = typeof b === "string", e = 0, f = a.length; if (d && !j.test(b)) { b = b.toLowerCase(); for (; e < f; e++) { c = a[e]; if (c) { var g = c.parentNode; a[e] = g.nodeName.toLowerCase() === b ? g : !1 } } } else { for (; e < f; e++) c = a[e], c && (a[e] = d ? c.parentNode : c.parentNode === b); d && k.filter(b, a, !0) } }, "": function (a, b, c) { var d, f = e++, g = u; typeof b === "string" && !j.test(b) && (b = b.toLowerCase(), d = b, g = t), g("parentNode", b, f, a, d, c) }, "~": function (a, b, c) { var d, f = e++, g = u; typeof b === "string" && !j.test(b) && (b = b.toLowerCase(), d = b, g = t), g("previousSibling", b, f, a, d, c) } }, find: { ID: function (a, b, c) { if (typeof b.getElementById !== "undefined" && !c) { var d = b.getElementById(a[1]); return d && d.parentNode ? [d] : [] } }, NAME: function (a, b) { if (typeof b.getElementsByName !== "undefined") { var c = [], d = b.getElementsByName(a[1]); for (var e = 0, f = d.length; e < f; e++) d[e].getAttribute("name") === a[1] && c.push(d[e]); return c.length === 0 ? null : c } }, TAG: function (a, b) { if (typeof b.getElementsByTagName !== "undefined") return b.getElementsByTagName(a[1]) } }, preFilter: { CLASS: function (a, b, c, d, e, f) { a = " " + a[1].replace(i, "") + " "; if (f) return a; for (var g = 0, h; (h = b[g]) != null; g++) h && (e ^ (h.className && (" " + h.className + " ").replace(/[\t\n\r]/g, " ").indexOf(a) >= 0) ? c || d.push(h) : c && (b[g] = !1)); return !1 }, ID: function (a) { return a[1].replace(i, "") }, TAG: function (a, b) { return a[1].replace(i, "").toLowerCase() }, CHILD: function (a) { if (a[1] === "nth") { a[2] || k.error(a[0]), a[2] = a[2].replace(/^\+|\s*/g, ""); var b = /(-?)(\d*)(?:n([+\-]?\d*))?/.exec(a[2] === "even" && "2n" || a[2] === "odd" && "2n+1" || !/\D/.test(a[2]) && "0n+" + a[2] || a[2]); a[2] = b[1] + (b[2] || 1) - 0, a[3] = b[3] - 0 } else a[2] && k.error(a[0]); a[0] = e++; return a }, ATTR: function (a, b, c, d, e, f) { var g = a[1] = a[1].replace(i, ""); !f && l.attrMap[g] && (a[1] = l.attrMap[g]), a[4] = (a[4] || a[5] || "").replace(i, ""), a[2] === "~=" && (a[4] = " " + a[4] + " "); return a }, PSEUDO: function (b, c, d, e, f) { if (b[1] === "not") if ((a.exec(b[3]) || "").length > 1 || /^\w/.test(b[3])) b[3] = k(b[3], null, null, c); else { var g = k.filter(b[3], c, d, !0 ^ f); d || e.push.apply(e, g); return !1 } else if (l.match.POS.test(b[0]) || l.match.CHILD.test(b[0])) return !0; return b }, POS: function (a) { a.unshift(!0); return a } }, filters: { enabled: function (a) { return a.disabled === !1 && a.type !== "hidden" }, disabled: function (a) { return a.disabled === !0 }, checked: function (a) { return a.checked === !0 }, selected: function (a) { a.parentNode && a.parentNode.selectedIndex; return a.selected === !0 }, parent: function (a) { return !!a.firstChild }, empty: function (a) { return !a.firstChild }, has: function (a, b, c) { return !!k(c[3], a).length }, header: function (a) { return /h\d/i.test(a.nodeName) }, text: function (a) { return "text" === a.getAttribute("type") }, radio: function (a) { return "radio" === a.type }, checkbox: function (a) { return "checkbox" === a.type }, file: function (a) { return "file" === a.type }, password: function (a) { return "password" === a.type }, submit: function (a) { return "submit" === a.type }, image: function (a) { return "image" === a.type }, reset: function (a) { return "reset" === a.type }, button: function (a) { return "button" === a.type || a.nodeName.toLowerCase() === "button" }, input: function (a) { return /input|select|textarea|button/i.test(a.nodeName) } }, setFilters: { first: function (a, b) { return b === 0 }, last: function (a, b, c, d) { return b === d.length - 1 }, even: function (a, b) { return b % 2 === 0 }, odd: function (a, b) { return b % 2 === 1 }, lt: function (a, b, c) { return b < c[3] - 0 }, gt: function (a, b, c) { return b > c[3] - 0 }, nth: function (a, b, c) { return c[3] - 0 === b }, eq: function (a, b, c) { return c[3] - 0 === b } }, filter: { PSEUDO: function (a, b, c, d) { var e = b[1], f = l.filters[e]; if (f) return f(a, c, b, d); if (e === "contains") return (a.textContent || a.innerText || k.getText([a]) || "").indexOf(b[3]) >= 0; if (e === "not") { var g = b[3]; for (var h = 0, i = g.length; h < i; h++) if (g[h] === a) return !1; return !0 } k.error(e) }, CHILD: function (a, b) { var c = b[1], d = a; switch (c) { case "only": case "first": while (d = d.previousSibling) if (d.nodeType === 1) return !1; if (c === "first") return !0; d = a; case "last": while (d = d.nextSibling) if (d.nodeType === 1) return !1; return !0; case "nth": var e = b[2], f = b[3]; if (e === 1 && f === 0) return !0; var g = b[0], h = a.parentNode; if (h && (h.sizcache !== g || !a.nodeIndex)) { var i = 0; for (d = h.firstChild; d; d = d.nextSibling) d.nodeType === 1 && (d.nodeIndex = ++i); h.sizcache = g } var j = a.nodeIndex - f; return e === 0 ? j === 0 : j % e === 0 && j / e >= 0 } }, ID: function (a, b) { return a.nodeType === 1 && a.getAttribute("id") === b }, TAG: function (a, b) { return b === "*" && a.nodeType === 1 || a.nodeName.toLowerCase() === b }, CLASS: function (a, b) { return (" " + (a.className || a.getAttribute("class")) + " ").indexOf(b) > -1 }, ATTR: function (a, b) { var c = b[1], d = l.attrHandle[c] ? l.attrHandle[c](a) : a[c] != null ? a[c] : a.getAttribute(c), e = d + "", f = b[2], g = b[4]; return d == null ? f === "!=" : f === "=" ? e === g : f === "*=" ? e.indexOf(g) >= 0 : f === "~=" ? (" " + e + " ").indexOf(g) >= 0 : g ? f === "!=" ? e !== g : f === "^=" ? e.indexOf(g) === 0 : f === "$=" ? e.substr(e.length - g.length) === g : f === "|=" ? e === g || e.substr(0, g.length + 1) === g + "-" : !1 : e && d !== !1 }, POS: function (a, b, c, d) { var e = b[2], f = l.setFilters[e]; if (f) return f(a, c, b, d) } } }, m = l.match.POS, n = function (a, b) { return "\\" + (b - 0 + 1) }; for (var o in l.match) l.match[o] = new RegExp(l.match[o].source + /(?![^\[]*\])(?![^\(]*\))/.source), l.leftMatch[o] = new RegExp(/(^(?:.|\r|\n)*?)/.source + l.match[o].source.replace(/\\(\d+)/g, n)); var p = function (a, b) { a = Array.prototype.slice.call(a, 0); if (b) { b.push.apply(b, a); return b } return a }; try { Array.prototype.slice.call(c.documentElement.childNodes, 0)[0].nodeType } catch (q) { p = function (a, b) { var c = 0, d = b || []; if (f.call(a) === "[object Array]") Array.prototype.push.apply(d, a); else if (typeof a.length === "number") for (var e = a.length; c < e; c++) d.push(a[c]); else for (; a[c]; c++) d.push(a[c]); return d } } var r, s; c.documentElement.compareDocumentPosition ? r = function (a, b) { if (a === b) { g = !0; return 0 } if (!a.compareDocumentPosition || !b.compareDocumentPosition) return a.compareDocumentPosition ? -1 : 1; return a.compareDocumentPosition(b) & 4 ? -1 : 1 } : (r = function (a, b) { var c, d, e = [], f = [], h = a.parentNode, i = b.parentNode, j = h; if (a === b) { g = !0; return 0 } if (h === i) return s(a, b); if (!h) return -1; if (!i) return 1; while (j) e.unshift(j), j = j.parentNode; j = i; while (j) f.unshift(j), j = j.parentNode; c = e.length, d = f.length; for (var k = 0; k < c && k < d; k++) if (e[k] !== f[k]) return s(e[k], f[k]); return k === c ? s(a, f[k], -1) : s(e[k], b, 1) }, s = function (a, b, c) { if (a === b) return c; var d = a.nextSibling; while (d) { if (d === b) return -1; d = d.nextSibling } return 1 }), k.getText = function (a) { var b = "", c; for (var d = 0; a[d]; d++) c = a[d], c.nodeType === 3 || c.nodeType === 4 ? b += c.nodeValue : c.nodeType !== 8 && (b += k.getText(c.childNodes)); return b }, function () { var a = c.createElement("div"), d = "script" + (new Date).getTime(), e = c.documentElement; a.innerHTML = "<a name='" + d + "'/>", e.insertBefore(a, e.firstChild), c.getElementById(d) && (l.find.ID = function (a, c, d) { if (typeof c.getElementById !== "undefined" && !d) { var e = c.getElementById(a[1]); return e ? e.id === a[1] || typeof e.getAttributeNode !== "undefined" && e.getAttributeNode("id").nodeValue === a[1] ? [e] : b : [] } }, l.filter.ID = function (a, b) { var c = typeof a.getAttributeNode !== "undefined" && a.getAttributeNode("id"); return a.nodeType === 1 && c && c.nodeValue === b }), e.removeChild(a), e = a = null } (), function () { var a = c.createElement("div"); a.appendChild(c.createComment("")), a.getElementsByTagName("*").length > 0 && (l.find.TAG = function (a, b) { var c = b.getElementsByTagName(a[1]); if (a[1] === "*") { var d = []; for (var e = 0; c[e]; e++) c[e].nodeType === 1 && d.push(c[e]); c = d } return c }), a.innerHTML = "<a href='#'></a>", a.firstChild && typeof a.firstChild.getAttribute !== "undefined" && a.firstChild.getAttribute("href") !== "#" && (l.attrHandle.href = function (a) { return a.getAttribute("href", 2) }), a = null } (), c.querySelectorAll && function () { var a = k, b = c.createElement("div"), d = "__sizzle__"; b.innerHTML = "<p class='TEST'></p>"; if (!b.querySelectorAll || b.querySelectorAll(".TEST").length !== 0) { k = function (b, e, f, g) { e = e || c; if (!g && !k.isXML(e)) { var h = /^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec(b); if (h && (e.nodeType === 1 || e.nodeType === 9)) { if (h[1]) return p(e.getElementsByTagName(b), f); if (h[2] && l.find.CLASS && e.getElementsByClassName) return p(e.getElementsByClassName(h[2]), f) } if (e.nodeType === 9) { if (b === "body" && e.body) return p([e.body], f); if (h && h[3]) { var i = e.getElementById(h[3]); if (!i || !i.parentNode) return p([], f); if (i.id === h[3]) return p([i], f) } try { return p(e.querySelectorAll(b), f) } catch (j) { } } else if (e.nodeType === 1 && e.nodeName.toLowerCase() !== "object") { var m = e, n = e.getAttribute("id"), o = n || d, q = e.parentNode, r = /^\s*[+~]/.test(b); n ? o = o.replace(/'/g, "\\$&") : e.setAttribute("id", o), r && q && (e = e.parentNode); try { if (!r || q) return p(e.querySelectorAll("[id='" + o + "'] " + b), f) } catch (s) { } finally { n || m.removeAttribute("id") } } } return a(b, e, f, g) }; for (var e in a) k[e] = a[e]; b = null } } (), function () { var a = c.documentElement, b = a.matchesSelector || a.mozMatchesSelector || a.webkitMatchesSelector || a.msMatchesSelector, d = !1; try { b.call(c.documentElement, "[test!='']:sizzle") } catch (e) { d = !0 } b && (k.matchesSelector = function (a, c) { c = c.replace(/\=\s*([^'"\]]*)\s*\]/g, "='$1']"); if (!k.isXML(a)) try { if (d || !l.match.PSEUDO.test(c) && !/!=/.test(c)) return b.call(a, c) } catch (e) { } return k(c, null, null, [a]).length > 0 }) } (), function () { var a = c.createElement("div"); a.innerHTML = "<div class='test e'></div><div class='test'></div>"; if (a.getElementsByClassName && a.getElementsByClassName("e").length !== 0) { a.lastChild.className = "e"; if (a.getElementsByClassName("e").length === 1) return; l.order.splice(1, 0, "CLASS"), l.find.CLASS = function (a, b, c) { if (typeof b.getElementsByClassName !== "undefined" && !c) return b.getElementsByClassName(a[1]) }, a = null } } (), c.documentElement.contains ? k.contains = function (a, b) { return a !== b && (a.contains ? a.contains(b) : !0) } : c.documentElement.compareDocumentPosition ? k.contains = function (a, b) { return !!(a.compareDocumentPosition(b) & 16) } : k.contains = function () { return !1 }, k.isXML = function (a) { var b = (a ? a.ownerDocument || a : 0).documentElement; return b ? b.nodeName !== "HTML" : !1 }; var v = function (a, b) { var c, d = [], e = "", f = b.nodeType ? [b] : b; while (c = l.match.PSEUDO.exec(a)) e += c[0], a = a.replace(l.match.PSEUDO, ""); a = l.relative[a] ? a + "*" : a; for (var g = 0, h = f.length; g < h; g++) k(a, f[g], d); return k.filter(e, d) }; d.find = k, d.expr = k.selectors, d.expr[":"] = d.expr.filters, d.unique = k.uniqueSort, d.text = k.getText, d.isXMLDoc = k.isXML, d.contains = k.contains } (); var G = /Until$/, H = /^(?:parents|prevUntil|prevAll)/, I = /,/, J = /^.[^:#\[\.,]*$/, K = Array.prototype.slice, L = d.expr.match.POS, M = { children: !0, contents: !0, next: !0, prev: !0 }; d.fn.extend({ find: function (a) { var b = this.pushStack("", "find", a), c = 0; for (var e = 0, f = this.length; e < f; e++) { c = b.length, d.find(a, this[e], b); if (e > 0) for (var g = c; g < b.length; g++) for (var h = 0; h < c; h++) if (b[h] === b[g]) { b.splice(g--, 1); break } } return b }, has: function (a) { var b = d(a); return this.filter(function () { for (var a = 0, c = b.length; a < c; a++) if (d.contains(this, b[a])) return !0 }) }, not: function (a) { return this.pushStack(O(this, a, !1), "not", a) }, filter: function (a) { return this.pushStack(O(this, a, !0), "filter", a) }, is: function (a) { return !!a && d.filter(a, this).length > 0 }, closest: function (a, b) { var c = [], e, f, g = this[0]; if (d.isArray(a)) { var h, i, j = {}, k = 1; if (g && a.length) { for (e = 0, f = a.length; e < f; e++) i = a[e], j[i] || (j[i] = d.expr.match.POS.test(i) ? d(i, b || this.context) : i); while (g && g.ownerDocument && g !== b) { for (i in j) h = j[i], (h.jquery ? h.index(g) > -1 : d(g).is(h)) && c.push({ selector: i, elem: g, level: k }); g = g.parentNode, k++ } } return c } var l = L.test(a) ? d(a, b || this.context) : null; for (e = 0, f = this.length; e < f; e++) { g = this[e]; while (g) { if (l ? l.index(g) > -1 : d.find.matchesSelector(g, a)) { c.push(g); break } g = g.parentNode; if (!g || !g.ownerDocument || g === b) break } } c = c.length > 1 ? d.unique(c) : c; return this.pushStack(c, "closest", a) }, index: function (a) { if (!a || typeof a === "string") return d.inArray(this[0], a ? d(a) : this.parent().children()); return d.inArray(a.jquery ? a[0] : a, this) }, add: function (a, b) { var c = typeof a === "string" ? d(a, b) : d.makeArray(a), e = d.merge(this.get(), c); return this.pushStack(N(c[0]) || N(e[0]) ? e : d.unique(e)) }, andSelf: function () { return this.add(this.prevObject) } }), d.each({ parent: function (a) { var b = a.parentNode; return b && b.nodeType !== 11 ? b : null }, parents: function (a) { return d.dir(a, "parentNode") }, parentsUntil: function (a, b, c) { return d.dir(a, "parentNode", c) }, next: function (a) { return d.nth(a, 2, "nextSibling") }, prev: function (a) { return d.nth(a, 2, "previousSibling") }, nextAll: function (a) { return d.dir(a, "nextSibling") }, prevAll: function (a) { return d.dir(a, "previousSibling") }, nextUntil: function (a, b, c) { return d.dir(a, "nextSibling", c) }, prevUntil: function (a, b, c) { return d.dir(a, "previousSibling", c) }, siblings: function (a) { return d.sibling(a.parentNode.firstChild, a) }, children: function (a) { return d.sibling(a.firstChild) }, contents: function (a) { return d.nodeName(a, "iframe") ? a.contentDocument || a.contentWindow.document : d.makeArray(a.childNodes) } }, function (a, b) { d.fn[a] = function (c, e) { var f = d.map(this, b, c), g = K.call(arguments); G.test(a) || (e = c), e && typeof e === "string" && (f = d.filter(e, f)), f = this.length > 1 && !M[a] ? d.unique(f) : f, (this.length > 1 || I.test(e)) && H.test(a) && (f = f.reverse()); return this.pushStack(f, a, g.join(",")) } }), d.extend({ filter: function (a, b, c) { c && (a = ":not(" + a + ")"); return b.length === 1 ? d.find.matchesSelector(b[0], a) ? [b[0]] : [] : d.find.matches(a, b) }, dir: function (a, c, e) { var f = [], g = a[c]; while (g && g.nodeType !== 9 && (e === b || g.nodeType !== 1 || !d(g).is(e))) g.nodeType === 1 && f.push(g), g = g[c]; return f }, nth: function (a, b, c, d) { b = b || 1; var e = 0; for (; a; a = a[c]) if (a.nodeType === 1 && ++e === b) break; return a }, sibling: function (a, b) { var c = []; for (; a; a = a.nextSibling) a.nodeType === 1 && a !== b && c.push(a); return c } }); var P = / jQuery\d+="(?:\d+|null)"/g, Q = /^\s+/, R = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/ig, S = /<([\w:]+)/, T = /<tbody/i, U = /<|&#?\w+;/, V = /<(?:script|object|embed|option|style)/i, W = /checked\s*(?:[^=]|=\s*.checked.)/i, X = { option: [1, "<select multiple='multiple'>", "</select>"], legend: [1, "<fieldset>", "</fieldset>"], thead: [1, "<table>", "</table>"], tr: [2, "<table><tbody>", "</tbody></table>"], td: [3, "<table><tbody><tr>", "</tr></tbody></table>"], col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"], area: [1, "<map>", "</map>"], _default: [0, "", ""] }; X.optgroup = X.option, X.tbody = X.tfoot = X.colgroup = X.caption = X.thead, X.th = X.td, d.support.htmlSerialize || (X._default = [1, "div<div>", "</div>"]), d.fn.extend({ text: function (a) { if (d.isFunction(a)) return this.each(function (b) { var c = d(this); c.text(a.call(this, b, c.text())) }); if (typeof a !== "object" && a !== b) return this.empty().append((this[0] && this[0].ownerDocument || c).createTextNode(a)); return d.text(this) }, wrapAll: function (a) { if (d.isFunction(a)) return this.each(function (b) { d(this).wrapAll(a.call(this, b)) }); if (this[0]) { var b = d(a, this[0].ownerDocument).eq(0).clone(!0); this[0].parentNode && b.insertBefore(this[0]), b.map(function () { var a = this; while (a.firstChild && a.firstChild.nodeType === 1) a = a.firstChild; return a }).append(this) } return this }, wrapInner: function (a) { if (d.isFunction(a)) return this.each(function (b) { d(this).wrapInner(a.call(this, b)) }); return this.each(function () { var b = d(this), c = b.contents(); c.length ? c.wrapAll(a) : b.append(a) }) }, wrap: function (a) { return this.each(function () { d(this).wrapAll(a) }) }, unwrap: function () { return this.parent().each(function () { d.nodeName(this, "body") || d(this).replaceWith(this.childNodes) }).end() }, append: function () { return this.domManip(arguments, !0, function (a) { this.nodeType === 1 && this.appendChild(a) }) }, prepend: function () { return this.domManip(arguments, !0, function (a) { this.nodeType === 1 && this.insertBefore(a, this.firstChild) }) }, before: function () { if (this[0] && this[0].parentNode) return this.domManip(arguments, !1, function (a) { this.parentNode.insertBefore(a, this) }); if (arguments.length) { var a = d(arguments[0]); a.push.apply(a, this.toArray()); return this.pushStack(a, "before", arguments) } }, after: function () { if (this[0] && this[0].parentNode) return this.domManip(arguments, !1, function (a) { this.parentNode.insertBefore(a, this.nextSibling) }); if (arguments.length) { var a = this.pushStack(this, "after", arguments); a.push.apply(a, d(arguments[0]).toArray()); return a } }, remove: function (a, b) { for (var c = 0, e; (e = this[c]) != null; c++) if (!a || d.filter(a, [e]).length) !b && e.nodeType === 1 && (d.cleanData(e.getElementsByTagName("*")), d.cleanData([e])), e.parentNode && e.parentNode.removeChild(e); return this }, empty: function () { for (var a = 0, b; (b = this[a]) != null; a++) { b.nodeType === 1 && d.cleanData(b.getElementsByTagName("*")); while (b.firstChild) b.removeChild(b.firstChild) } return this }, clone: function (a, b) { a = a == null ? !1 : a, b = b == null ? a : b; return this.map(function () { return d.clone(this, a, b) }) }, html: function (a) { if (a === b) return this[0] && this[0].nodeType === 1 ? this[0].innerHTML.replace(P, "") : null; if (typeof a !== "string" || V.test(a) || !d.support.leadingWhitespace && Q.test(a) || X[(S.exec(a) || ["", ""])[1].toLowerCase()]) d.isFunction(a) ? this.each(function (b) { var c = d(this); c.html(a.call(this, b, c.html())) }) : this.empty().append(a); else { a = a.replace(R, "<$1></$2>"); try { for (var c = 0, e = this.length; c < e; c++) this[c].nodeType === 1 && (d.cleanData(this[c].getElementsByTagName("*")), this[c].innerHTML = a) } catch (f) { this.empty().append(a) } } return this }, replaceWith: function (a) { if (this[0] && this[0].parentNode) { if (d.isFunction(a)) return this.each(function (b) { var c = d(this), e = c.html(); c.replaceWith(a.call(this, b, e)) }); typeof a !== "string" && (a = d(a).detach()); return this.each(function () { var b = this.nextSibling, c = this.parentNode; d(this).remove(), b ? d(b).before(a) : d(c).append(a) }) } return this.pushStack(d(d.isFunction(a) ? a() : a), "replaceWith", a) }, detach: function (a) { return this.remove(a, !0) }, domManip: function (a, c, e) { var f, g, h, i, j = a[0], k = []; if (!d.support.checkClone && arguments.length === 3 && typeof j === "string" && W.test(j)) return this.each(function () { d(this).domManip(a, c, e, !0) }); if (d.isFunction(j)) return this.each(function (f) { var g = d(this); a[0] = j.call(this, f, c ? g.html() : b), g.domManip(a, c, e) }); if (this[0]) { i = j && j.parentNode, d.support.parentNode && i && i.nodeType === 11 && i.childNodes.length === this.length ? f = { fragment: i} : f = d.buildFragment(a, this, k), h = f.fragment, h.childNodes.length === 1 ? g = h = h.firstChild : g = h.firstChild; if (g) { c = c && d.nodeName(g, "tr"); for (var l = 0, m = this.length, n = m - 1; l < m; l++) e.call(c ? Y(this[l], g) : this[l], f.cacheable || m > 1 && l < n ? d.clone(h, !0, !0) : h) } k.length && d.each(k, ba) } return this } }), d.buildFragment = function (a, b, e) { var f, g, h, i = b && b[0] ? b[0].ownerDocument || b[0] : c; a.length === 1 && typeof a[0] === "string" && a[0].length < 512 && i === c && a[0].charAt(0) === "<" && !V.test(a[0]) && (d.support.checkClone || !W.test(a[0])) && (g = !0, h = d.fragments[a[0]], h && (h !== 1 && (f = h))), f || (f = i.createDocumentFragment(), d.clean(a, i, f, e)), g && (d.fragments[a[0]] = h ? f : 1); return { fragment: f, cacheable: g} }, d.fragments = {}, d.each({ appendTo: "append", prependTo: "prepend", insertBefore: "before", insertAfter: "after", replaceAll: "replaceWith" }, function (a, b) { d.fn[a] = function (c) { var e = [], f = d(c), g = this.length === 1 && this[0].parentNode; if (g && g.nodeType === 11 && g.childNodes.length === 1 && f.length === 1) { f[b](this[0]); return this } for (var h = 0, i = f.length; h < i; h++) { var j = (h > 0 ? this.clone(!0) : this).get(); d(f[h])[b](j), e = e.concat(j) } return this.pushStack(e, a, f.selector) } }), d.extend({ clone: function (a, b, c) { var e = a.cloneNode(!0), f, g, h; if ((!d.support.noCloneEvent || !d.support.noCloneChecked) && (a.nodeType === 1 || a.nodeType === 11) && !d.isXMLDoc(a)) { $(a, e), f = _(a), g = _(e); for (h = 0; f[h]; ++h) $(f[h], g[h]) } if (b) { Z(a, e); if (c) { f = _(a), g = _(e); for (h = 0; f[h]; ++h) Z(f[h], g[h]) } } return e }, clean: function (a, b, e, f) { b = b || c, typeof b.createElement === "undefined" && (b = b.ownerDocument || b[0] && b[0].ownerDocument || c); var g = []; for (var h = 0, i; (i = a[h]) != null; h++) { typeof i === "number" && (i += ""); if (!i) continue; if (typeof i !== "string" || U.test(i)) { if (typeof i === "string") { i = i.replace(R, "<$1></$2>"); var j = (S.exec(i) || ["", ""])[1].toLowerCase(), k = X[j] || X._default, l = k[0], m = b.createElement("div"); m.innerHTML = k[1] + i + k[2]; while (l--) m = m.lastChild; if (!d.support.tbody) { var n = T.test(i), o = j === "table" && !n ? m.firstChild && m.firstChild.childNodes : k[1] === "<table>" && !n ? m.childNodes : []; for (var p = o.length - 1; p >= 0; --p) d.nodeName(o[p], "tbody") && !o[p].childNodes.length && o[p].parentNode.removeChild(o[p]) } !d.support.leadingWhitespace && Q.test(i) && m.insertBefore(b.createTextNode(Q.exec(i)[0]), m.firstChild), i = m.childNodes } } else i = b.createTextNode(i); i.nodeType ? g.push(i) : g = d.merge(g, i) } if (e) for (h = 0; g[h]; h++) !f || !d.nodeName(g[h], "script") || g[h].type && g[h].type.toLowerCase() !== "text/javascript" ? (g[h].nodeType === 1 && g.splice.apply(g, [h + 1, 0].concat(d.makeArray(g[h].getElementsByTagName("script")))), e.appendChild(g[h])) : f.push(g[h].parentNode ? g[h].parentNode.removeChild(g[h]) : g[h]); return g }, cleanData: function (a) { var b, c, e = d.cache, f = d.expando, g = d.event.special, h = d.support.deleteExpando; for (var i = 0, j; (j = a[i]) != null; i++) { if (j.nodeName && d.noData[j.nodeName.toLowerCase()]) continue; c = j[d.expando]; if (c) { b = e[c] && e[c][f]; if (b && b.events) { for (var k in b.events) g[k] ? d.event.remove(j, k) : d.removeEvent(j, k, b.handle); b.handle && (b.handle.elem = null) } h ? delete j[d.expando] : j.removeAttribute && j.removeAttribute(d.expando), delete e[c] } } } }); var bb = /alpha\([^)]*\)/i, bc = /opacity=([^)]*)/, bd = /-([a-z])/ig, be = /([A-Z])/g, bf = /^-?\d+(?:px)?$/i, bg = /^-?\d/, bh = { position: "absolute", visibility: "hidden", display: "block" }, bi = ["Left", "Right"], bj = ["Top", "Bottom"], bk, bl, bm, bn = function (a, b) { return b.toUpperCase() }; d.fn.css = function (a, c) { if (arguments.length === 2 && c === b) return this; return d.access(this, a, c, !0, function (a, c, e) { return e !== b ? d.style(a, c, e) : d.css(a, c) }) }, d.extend({ cssHooks: { opacity: { get: function (a, b) { if (b) { var c = bk(a, "opacity", "opacity"); return c === "" ? "1" : c } return a.style.opacity } } }, cssNumber: { zIndex: !0, fontWeight: !0, opacity: !0, zoom: !0, lineHeight: !0 }, cssProps: { "float": d.support.cssFloat ? "cssFloat" : "styleFloat" }, style: function (a, c, e, f) { if (a && a.nodeType !== 3 && a.nodeType !== 8 && a.style) { var g, h = d.camelCase(c), i = a.style, j = d.cssHooks[h]; c = d.cssProps[h] || h; if (e === b) { if (j && "get" in j && (g = j.get(a, !1, f)) !== b) return g; return i[c] } if (typeof e === "number" && isNaN(e) || e == null) return; typeof e === "number" && !d.cssNumber[h] && (e += "px"); if (!j || !("set" in j) || (e = j.set(a, e)) !== b) try { i[c] = e } catch (k) { } } }, css: function (a, c, e) { var f, g = d.camelCase(c), h = d.cssHooks[g]; c = d.cssProps[g] || g; if (h && "get" in h && (f = h.get(a, !0, e)) !== b) return f; if (bk) return bk(a, c, g) }, swap: function (a, b, c) { var d = {}; for (var e in b) d[e] = a.style[e], a.style[e] = b[e]; c.call(a); for (e in b) a.style[e] = d[e] }, camelCase: function (a) { return a.replace(bd, bn) } }), d.curCSS = d.css, d.each(["height", "width"], function (a, b) { d.cssHooks[b] = { get: function (a, c, e) { var f; if (c) { a.offsetWidth !== 0 ? f = bo(a, b, e) : d.swap(a, bh, function () { f = bo(a, b, e) }); if (f <= 0) { f = bk(a, b, b), f === "0px" && bm && (f = bm(a, b, b)); if (f != null) return f === "" || f === "auto" ? "0px" : f } if (f < 0 || f == null) { f = a.style[b]; return f === "" || f === "auto" ? "0px" : f } return typeof f === "string" ? f : f + "px" } }, set: function (a, b) { if (!bf.test(b)) return b; b = parseFloat(b); if (b >= 0) return b + "px" } } }), d.support.opacity || (d.cssHooks.opacity = { get: function (a, b) { return bc.test((b && a.currentStyle ? a.currentStyle.filter : a.style.filter) || "") ? parseFloat(RegExp.$1) / 100 + "" : b ? "1" : "" }, set: function (a, b) { var c = a.style; c.zoom = 1; var e = d.isNaN(b) ? "" : "alpha(opacity=" + b * 100 + ")", f = c.filter || ""; c.filter = bb.test(f) ? f.replace(bb, e) : c.filter + " " + e } }), c.defaultView && c.defaultView.getComputedStyle && (bl = function (a, c, e) { var f, g, h; e = e.replace(be, "-$1").toLowerCase(); if (!(g = a.ownerDocument.defaultView)) return b; if (h = g.getComputedStyle(a, null)) f = h.getPropertyValue(e), f === "" && !d.contains(a.ownerDocument.documentElement, a) && (f = d.style(a, e)); return f }), c.documentElement.currentStyle && (bm = function (a, b) { var c, d = a.currentStyle && a.currentStyle[b], e = a.runtimeStyle && a.runtimeStyle[b], f = a.style; !bf.test(d) && bg.test(d) && (c = f.left, e && (a.runtimeStyle.left = a.currentStyle.left), f.left = b === "fontSize" ? "1em" : d || 0, d = f.pixelLeft + "px", f.left = c, e && (a.runtimeStyle.left = e)); return d === "" ? "auto" : d }), bk = bl || bm, d.expr && d.expr.filters && (d.expr.filters.hidden = function (a) { var b = a.offsetWidth, c = a.offsetHeight; return b === 0 && c === 0 || !d.support.reliableHiddenOffsets && (a.style.display || d.css(a, "display")) === "none" }, d.expr.filters.visible = function (a) { return !d.expr.filters.hidden(a) }); var bp = /%20/g, bq = /\[\]$/, br = /\r?\n/g, bs = /#.*$/, bt = /^(.*?):[ \t]*([^\r\n]*)\r?$/mg, bu = /^(?:color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i, bv = /(?:^file|^widget|\-extension):$/, bw = /^(?:GET|HEAD)$/, bx = /^\/\//, by = /\?/, bz = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, bA = /^(?:select|textarea)/i, bB = /\s+/, bC = /([?&])_=[^&]*/, bD = /(^|\-)([a-z])/g, bE = function (a, b, c) { return b + c.toUpperCase() }, bF = /^([\w\+\.\-]+:)\/\/([^\/?#:]*)(?::(\d+))?/, bG = d.fn.load, bH = {}, bI = {}, bJ, bK; try { bJ = c.location.href } catch (bL) { bJ = c.createElement("a"), bJ.href = "", bJ = bJ.href } bK = bF.exec(bJ.toLowerCase()), d.fn.extend({ load: function (a, c, e) { if (typeof a !== "string" && bG) return bG.apply(this, arguments); if (!this.length) return this; var f = a.indexOf(" "); if (f >= 0) { var g = a.slice(f, a.length); a = a.slice(0, f) } var h = "GET"; c && (d.isFunction(c) ? (e = c, c = b) : typeof c === "object" && (c = d.param(c, d.ajaxSettings.traditional), h = "POST")); var i = this; d.ajax({ url: a, type: h, dataType: "html", data: c, complete: function (a, b, c) { c = a.responseText, a.isResolved() && (a.done(function (a) { c = a }), i.html(g ? d("<div>").append(c.replace(bz, "")).find(g) : c)), e && i.each(e, [c, b, a]) } }); return this }, serialize: function () { return d.param(this.serializeArray()) }, serializeArray: function () { return this.map(function () { return this.elements ? d.makeArray(this.elements) : this }).filter(function () { return this.name && !this.disabled && (this.checked || bA.test(this.nodeName) || bu.test(this.type)) }).map(function (a, b) { var c = d(this).val(); return c == null ? null : d.isArray(c) ? d.map(c, function (a, c) { return { name: b.name, value: a.replace(br, "\r\n")} }) : { name: b.name, value: c.replace(br, "\r\n")} }).get() } }), d.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "), function (a, b) { d.fn[b] = function (a) { return this.bind(b, a) } }), d.each(["get", "post"], function (a, c) { d[c] = function (a, e, f, g) { d.isFunction(e) && (g = g || f, f = e, e = b); return d.ajax({ type: c, url: a, data: e, success: f, dataType: g }) } }), d.extend({ getScript: function (a, c) { return d.get(a, b, c, "script") }, getJSON: function (a, b, c) { return d.get(a, b, c, "json") }, ajaxSetup: function (a, b) { b ? d.extend(!0, a, d.ajaxSettings, b) : (b = a, a = d.extend(!0, d.ajaxSettings, b)); for (var c in { context: 1, url: 1 }) c in b ? a[c] = b[c] : c in d.ajaxSettings && (a[c] = d.ajaxSettings[c]); return a }, ajaxSettings: { url: bJ, isLocal: bv.test(bK[1]), global: !0, type: "GET", contentType: "application/x-www-form-urlencoded", processData: !0, async: !0, accepts: { xml: "application/xml, text/xml", html: "text/html", text: "text/plain", json: "application/json, text/javascript", "*": "*/*" }, contents: { xml: /xml/, html: /html/, json: /json/ }, responseFields: { xml: "responseXML", text: "responseText" }, converters: { "* text": a.String, "text html": !0, "text json": d.parseJSON, "text xml": d.parseXML} }, ajaxPrefilter: bM(bH), ajaxTransport: bM(bI), ajax: function (a, c) { function v(a, c, l, n) { if (r !== 2) { r = 2, p && clearTimeout(p), o = b, m = n || "", u.readyState = a ? 4 : 0; var q, t, v, w = l ? bP(e, u, l) : b, x, y; if (a >= 200 && a < 300 || a === 304) { if (e.ifModified) { if (x = u.getResponseHeader("Last-Modified")) d.lastModified[k] = x; if (y = u.getResponseHeader("Etag")) d.etag[k] = y } if (a === 304) c = "notmodified", q = !0; else try { t = bQ(e, w), c = "success", q = !0 } catch (z) { c = "parsererror", v = z } } else { v = c; if (!c || a) c = "error", a < 0 && (a = 0) } u.status = a, u.statusText = c, q ? h.resolveWith(f, [t, c, u]) : h.rejectWith(f, [u, c, v]), u.statusCode(j), j = b, s && g.trigger("ajax" + (q ? "Success" : "Error"), [u, e, q ? t : v]), i.resolveWith(f, [u, c]), s && (g.trigger("ajaxComplete", [u, e]), --d.active || d.event.trigger("ajaxStop")) } } typeof a === "object" && (c = a, a = b), c = c || {}; var e = d.ajaxSetup({}, c), f = e.context || e, g = f !== e && (f.nodeType || f instanceof d) ? d(f) : d.event, h = d.Deferred(), i = d._Deferred(), j = e.statusCode || {}, k, l = {}, m, n, o, p, q, r = 0, s, t, u = { readyState: 0, setRequestHeader: function (a, b) { r || (l[a.toLowerCase().replace(bD, bE)] = b); return this }, getAllResponseHeaders: function () { return r === 2 ? m : null }, getResponseHeader: function (a) { var c; if (r === 2) { if (!n) { n = {}; while (c = bt.exec(m)) n[c[1].toLowerCase()] = c[2] } c = n[a.toLowerCase()] } return c === b ? null : c }, overrideMimeType: function (a) { r || (e.mimeType = a); return this }, abort: function (a) { a = a || "abort", o && o.abort(a), v(0, a); return this } }; h.promise(u), u.success = u.done, u.error = u.fail, u.complete = i.done, u.statusCode = function (a) { if (a) { var b; if (r < 2) for (b in a) j[b] = [j[b], a[b]]; else b = a[u.status], u.then(b, b) } return this }, e.url = ((a || e.url) + "").replace(bs, "").replace(bx, bK[1] + "//"), e.dataTypes = d.trim(e.dataType || "*").toLowerCase().split(bB), e.crossDomain || (q = bF.exec(e.url.toLowerCase()), e.crossDomain = q && (q[1] != bK[1] || q[2] != bK[2] || (q[3] || (q[1] === "http:" ? 80 : 443)) != (bK[3] || (bK[1] === "http:" ? 80 : 443)))), e.data && e.processData && typeof e.data !== "string" && (e.data = d.param(e.data, e.traditional)), bN(bH, e, c, u); if (r === 2) return !1; s = e.global, e.type = e.type.toUpperCase(), e.hasContent = !bw.test(e.type), s && d.active++ === 0 && d.event.trigger("ajaxStart"); if (!e.hasContent) { e.data && (e.url += (by.test(e.url) ? "&" : "?") + e.data), k = e.url; if (e.cache === !1) { var w = d.now(), x = e.url.replace(bC, "$1_=" + w); e.url = x + (x === e.url ? (by.test(e.url) ? "&" : "?") + "_=" + w : "") } } if (e.data && e.hasContent && e.contentType !== !1 || c.contentType) l["Content-Type"] = e.contentType; e.ifModified && (k = k || e.url, d.lastModified[k] && (l["If-Modified-Since"] = d.lastModified[k]), d.etag[k] && (l["If-None-Match"] = d.etag[k])), l.Accept = e.dataTypes[0] && e.accepts[e.dataTypes[0]] ? e.accepts[e.dataTypes[0]] + (e.dataTypes[0] !== "*" ? ", */*; q=0.01" : "") : e.accepts["*"]; for (t in e.headers) u.setRequestHeader(t, e.headers[t]); if (e.beforeSend && (e.beforeSend.call(f, u, e) === !1 || r === 2)) { u.abort(); return !1 } for (t in { success: 1, error: 1, complete: 1 }) u[t](e[t]); o = bN(bI, e, c, u); if (o) { u.readyState = 1, s && g.trigger("ajaxSend", [u, e]), e.async && e.timeout > 0 && (p = setTimeout(function () { u.abort("timeout") }, e.timeout)); try { r = 1, o.send(l, v) } catch (y) { status < 2 ? v(-1, y) : d.error(y) } } else v(-1, "No Transport"); return u }, param: function (a, c) { var e = [], f = function (a, b) { b = d.isFunction(b) ? b() : b, e[e.length] = encodeURIComponent(a) + "=" + encodeURIComponent(b) }; c === b && (c = d.ajaxSettings.traditional); if (d.isArray(a) || a.jquery && !d.isPlainObject(a)) d.each(a, function () { f(this.name, this.value) }); else for (var g in a) bO(g, a[g], c, f); return e.join("&").replace(bp, "+") } }), d.extend({ active: 0, lastModified: {}, etag: {} }); var bR = d.now(), bS = /(\=)\?(&|$)|()\?\?()/i; d.ajaxSetup({ jsonp: "callback", jsonpCallback: function () { return d.expando + "_" + bR++ } }), d.ajaxPrefilter("json jsonp", function (b, c, e) { var f = typeof b.data === "string"; if (b.dataTypes[0] === "jsonp" || c.jsonpCallback || c.jsonp != null || b.jsonp !== !1 && (bS.test(b.url) || f && bS.test(b.data))) { var g, h = b.jsonpCallback = d.isFunction(b.jsonpCallback) ? b.jsonpCallback() : b.jsonpCallback, i = a[h], j = b.url, k = b.data, l = "$1" + h + "$2", m = function () { a[h] = i, g && d.isFunction(i) && a[h](g[0]) }; b.jsonp !== !1 && (j = j.replace(bS, l), b.url === j && (f && (k = k.replace(bS, l)), b.data === k && (j += (/\?/.test(j) ? "&" : "?") + b.jsonp + "=" + h))), b.url = j, b.data = k, a[h] = function (a) { g = [a] }, e.then(m, m), b.converters["script json"] = function () { g || d.error(h + " was not called"); return g[0] }, b.dataTypes[0] = "json"; return "script" } }), d.ajaxSetup({ accepts: { script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript" }, contents: { script: /javascript|ecmascript/ }, converters: { "text script": function (a) { d.globalEval(a); return a } } }), d.ajaxPrefilter("script", function (a) { a.cache === b && (a.cache = !1), a.crossDomain && (a.type = "GET", a.global = !1) }), d.ajaxTransport("script", function (a) { if (a.crossDomain) { var d, e = c.head || c.getElementsByTagName("head")[0] || c.documentElement; return { send: function (f, g) { d = c.createElement("script"), d.async = "async", a.scriptCharset && (d.charset = a.scriptCharset), d.src = a.url, d.onload = d.onreadystatechange = function (a, c) { if (!d.readyState || /loaded|complete/.test(d.readyState)) d.onload = d.onreadystatechange = null, e && d.parentNode && e.removeChild(d), d = b, c || g(200, "success") }, e.insertBefore(d, e.firstChild) }, abort: function () { d && d.onload(0, 1) } } } }); var bT = d.now(), bU, bV; d.ajaxSettings.xhr = a.ActiveXObject ? function () { return !this.isLocal && bX() || bY() } : bX, bV = d.ajaxSettings.xhr(), d.support.ajax = !!bV, d.support.cors = bV && "withCredentials" in bV, bV = b, d.support.ajax && d.ajaxTransport(function (a) { if (!a.crossDomain || d.support.cors) { var c; return { send: function (e, f) { var g = a.xhr(), h, i; a.username ? g.open(a.type, a.url, a.async, a.username, a.password) : g.open(a.type, a.url, a.async); if (a.xhrFields) for (i in a.xhrFields) g[i] = a.xhrFields[i]; a.mimeType && g.overrideMimeType && g.overrideMimeType(a.mimeType), (!a.crossDomain || a.hasContent) && !e["X-Requested-With"] && (e["X-Requested-With"] = "XMLHttpRequest"); try { for (i in e) g.setRequestHeader(i, e[i]) } catch (j) { } g.send(a.hasContent && a.data || null), c = function (e, i) { var j, k, l, m, n; try { if (c && (i || g.readyState === 4)) { c = b, h && (g.onreadystatechange = d.noop, delete bU[h]); if (i) g.readyState !== 4 && g.abort(); else { j = g.status, l = g.getAllResponseHeaders(), m = {}, n = g.responseXML, n && n.documentElement && (m.xml = n), m.text = g.responseText; try { k = g.statusText } catch (o) { k = "" } j || !a.isLocal || a.crossDomain ? j === 1223 && (j = 204) : j = m.text ? 200 : 404 } } } catch (p) { i || f(-1, p) } m && f(j, k, m, l) }, a.async && g.readyState !== 4 ? (bU || (bU = {}, bW()), h = bT++, g.onreadystatechange = bU[h] = c) : c() }, abort: function () { c && c(0, 1) } } } }); var bZ = {}, b$ = /^(?:toggle|show|hide)$/, b_ = /^([+\-]=)?([\d+.\-]+)([a-z%]*)$/i, ca, cb = [["height", "marginTop", "marginBottom", "paddingTop", "paddingBottom"], ["width", "marginLeft", "marginRight", "paddingLeft", "paddingRight"], ["opacity"]]; d.fn.extend({ show: function (a, b, c) { var e, f; if (a || a === 0) return this.animate(cc("show", 3), a, b, c); for (var g = 0, h = this.length; g < h; g++) e = this[g], f = e.style.display, !d._data(e, "olddisplay") && f === "none" && (f = e.style.display = ""), f === "" && d.css(e, "display") === "none" && d._data(e, "olddisplay", cd(e.nodeName)); for (g = 0; g < h; g++) { e = this[g], f = e.style.display; if (f === "" || f === "none") e.style.display = d._data(e, "olddisplay") || "" } return this }, hide: function (a, b, c) { if (a || a === 0) return this.animate(cc("hide", 3), a, b, c); for (var e = 0, f = this.length; e < f; e++) { var g = d.css(this[e], "display"); g !== "none" && !d._data(this[e], "olddisplay") && d._data(this[e], "olddisplay", g) } for (e = 0; e < f; e++) this[e].style.display = "none"; return this }, _toggle: d.fn.toggle, toggle: function (a, b, c) { var e = typeof a === "boolean"; d.isFunction(a) && d.isFunction(b) ? this._toggle.apply(this, arguments) : a == null || e ? this.each(function () { var b = e ? a : d(this).is(":hidden"); d(this)[b ? "show" : "hide"]() }) : this.animate(cc("toggle", 3), a, b, c); return this }, fadeTo: function (a, b, c, d) { return this.filter(":hidden").css("opacity", 0).show().end().animate({ opacity: b }, a, c, d) }, animate: function (a, b, c, e) { var f = d.speed(b, c, e); if (d.isEmptyObject(a)) return this.each(f.complete); return this[f.queue === !1 ? "each" : "queue"](function () { var b = d.extend({}, f), c, e = this.nodeType === 1, g = e && d(this).is(":hidden"), h = this; for (c in a) { var i = d.camelCase(c); c !== i && (a[i] = a[c], delete a[c], c = i); if (a[c] === "hide" && g || a[c] === "show" && !g) return b.complete.call(this); if (e && (c === "height" || c === "width")) { b.overflow = [this.style.overflow, this.style.overflowX, this.style.overflowY]; if (d.css(this, "display") === "inline" && d.css(this, "float") === "none") if (d.support.inlineBlockNeedsLayout) { var j = cd(this.nodeName); j === "inline" ? this.style.display = "inline-block" : (this.style.display = "inline", this.style.zoom = 1) } else this.style.display = "inline-block" } d.isArray(a[c]) && ((b.specialEasing = b.specialEasing || {})[c] = a[c][1], a[c] = a[c][0]) } b.overflow != null && (this.style.overflow = "hidden"), b.curAnim = d.extend({}, a), d.each(a, function (c, e) { var f = new d.fx(h, b, c); if (b$.test(e)) f[e === "toggle" ? g ? "show" : "hide" : e](a); else { var i = b_.exec(e), j = f.cur(); if (i) { var k = parseFloat(i[2]), l = i[3] || (d.cssNumber[c] ? "" : "px"); l !== "px" && (d.style(h, c, (k || 1) + l), j = (k || 1) / f.cur() * j, d.style(h, c, j + l)), i[1] && (k = (i[1] === "-=" ? -1 : 1) * k + j), f.custom(j, k, l) } else f.custom(j, e, "") } }); return !0 }) }, stop: function (a, b) { var c = d.timers; a && this.queue([]), this.each(function () { for (var a = c.length - 1; a >= 0; a--) c[a].elem === this && (b && c[a](!0), c.splice(a, 1)) }), b || this.dequeue(); return this } }), d.each({ slideDown: cc("show", 1), slideUp: cc("hide", 1), slideToggle: cc("toggle", 1), fadeIn: { opacity: "show" }, fadeOut: { opacity: "hide" }, fadeToggle: { opacity: "toggle"} }, function (a, b) { d.fn[a] = function (a, c, d) { return this.animate(b, a, c, d) } }), d.extend({ speed: function (a, b, c) { var e = a && typeof a === "object" ? d.extend({}, a) : { complete: c || !c && b || d.isFunction(a) && a, duration: a, easing: c && b || b && !d.isFunction(b) && b }; e.duration = d.fx.off ? 0 : typeof e.duration === "number" ? e.duration : e.duration in d.fx.speeds ? d.fx.speeds[e.duration] : d.fx.speeds._default, e.old = e.complete, e.complete = function () { e.queue !== !1 && d(this).dequeue(), d.isFunction(e.old) && e.old.call(this) }; return e }, easing: { linear: function (a, b, c, d) { return c + d * a }, swing: function (a, b, c, d) { return (-Math.cos(a * Math.PI) / 2 + .5) * d + c } }, timers: [], fx: function (a, b, c) { this.options = b, this.elem = a, this.prop = c, b.orig || (b.orig = {}) } }), d.fx.prototype = { update: function () { this.options.step && this.options.step.call(this.elem, this.now, this), (d.fx.step[this.prop] || d.fx.step._default)(this) }, cur: function () { if (this.elem[this.prop] != null && (!this.elem.style || this.elem.style[this.prop] == null)) return this.elem[this.prop]; var a, b = d.css(this.elem, this.prop); return isNaN(a = parseFloat(b)) ? !b || b === "auto" ? 0 : b : a }, custom: function (a, b, c) { function g(a) { return e.step(a) } var e = this, f = d.fx; this.startTime = d.now(), this.start = a, this.end = b, this.unit = c || this.unit || (d.cssNumber[this.prop] ? "" : "px"), this.now = this.start, this.pos = this.state = 0, g.elem = this.elem, g() && d.timers.push(g) && !ca && (ca = setInterval(f.tick, f.interval)) }, show: function () { this.options.orig[this.prop] = d.style(this.elem, this.prop), this.options.show = !0, this.custom(this.prop === "width" || this.prop === "height" ? 1 : 0, this.cur()), d(this.elem).show() }, hide: function () { this.options.orig[this.prop] = d.style(this.elem, this.prop), this.options.hide = !0, this.custom(this.cur(), 0) }, step: function (a) { var b = d.now(), c = !0; if (a || b >= this.options.duration + this.startTime) { this.now = this.end, this.pos = this.state = 1, this.update(), this.options.curAnim[this.prop] = !0; for (var e in this.options.curAnim) this.options.curAnim[e] !== !0 && (c = !1); if (c) { if (this.options.overflow != null && !d.support.shrinkWrapBlocks) { var f = this.elem, g = this.options; d.each(["", "X", "Y"], function (a, b) { f.style["overflow" + b] = g.overflow[a] }) } this.options.hide && d(this.elem).hide(); if (this.options.hide || this.options.show) for (var h in this.options.curAnim) d.style(this.elem, h, this.options.orig[h]); this.options.complete.call(this.elem) } return !1 } var i = b - this.startTime; this.state = i / this.options.duration; var j = this.options.specialEasing && this.options.specialEasing[this.prop], k = this.options.easing || (d.easing.swing ? "swing" : "linear"); this.pos = d.easing[j || k](this.state, i, 0, 1, this.options.duration), this.now = this.start + (this.end - this.start) * this.pos, this.update(); return !0 } }, d.extend(d.fx, { tick: function () { var a = d.timers; for (var b = 0; b < a.length; b++) a[b]() || a.splice(b--, 1); a.length || d.fx.stop() }, interval: 13, stop: function () { clearInterval(ca), ca = null }, speeds: { slow: 600, fast: 200, _default: 400 }, step: { opacity: function (a) { d.style(a.elem, "opacity", a.now) }, _default: function (a) { a.elem.style && a.elem.style[a.prop] != null ? a.elem.style[a.prop] = (a.prop === "width" || a.prop === "height" ? Math.max(0, a.now) : a.now) + a.unit : a.elem[a.prop] = a.now } } }), d.expr && d.expr.filters && (d.expr.filters.animated = function (a) { return d.grep(d.timers, function (b) { return a === b.elem }).length }); var ce = /^t(?:able|d|h)$/i, cf = /^(?:body|html)$/i; "getBoundingClientRect" in c.documentElement ? d.fn.offset = function (a) { var b = this[0], c; if (a) return this.each(function (b) { d.offset.setOffset(this, a, b) }); if (!b || !b.ownerDocument) return null; if (b === b.ownerDocument.body) return d.offset.bodyOffset(b); try { c = b.getBoundingClientRect() } catch (e) { } var f = b.ownerDocument, g = f.documentElement; if (!c || !d.contains(g, b)) return c ? { top: c.top, left: c.left} : { top: 0, left: 0 }; var h = f.body, i = cg(f), j = g.clientTop || h.clientTop || 0, k = g.clientLeft || h.clientLeft || 0, l = i.pageYOffset || d.support.boxModel && g.scrollTop || h.scrollTop, m = i.pageXOffset || d.support.boxModel && g.scrollLeft || h.scrollLeft, n = c.top + l - j, o = c.left + m - k; return { top: n, left: o} } : d.fn.offset = function (a) { var b = this[0]; if (a) return this.each(function (b) { d.offset.setOffset(this, a, b) }); if (!b || !b.ownerDocument) return null; if (b === b.ownerDocument.body) return d.offset.bodyOffset(b); d.offset.initialize(); var c, e = b.offsetParent, f = b, g = b.ownerDocument, h = g.documentElement, i = g.body, j = g.defaultView, k = j ? j.getComputedStyle(b, null) : b.currentStyle, l = b.offsetTop, m = b.offsetLeft; while ((b = b.parentNode) && b !== i && b !== h) { if (d.offset.supportsFixedPosition && k.position === "fixed") break; c = j ? j.getComputedStyle(b, null) : b.currentStyle, l -= b.scrollTop, m -= b.scrollLeft, b === e && (l += b.offsetTop, m += b.offsetLeft, d.offset.doesNotAddBorder && (!d.offset.doesAddBorderForTableAndCells || !ce.test(b.nodeName)) && (l += parseFloat(c.borderTopWidth) || 0, m += parseFloat(c.borderLeftWidth) || 0), f = e, e = b.offsetParent), d.offset.subtractsBorderForOverflowNotVisible && c.overflow !== "visible" && (l += parseFloat(c.borderTopWidth) || 0, m += parseFloat(c.borderLeftWidth) || 0), k = c } if (k.position === "relative" || k.position === "static") l += i.offsetTop, m += i.offsetLeft; d.offset.supportsFixedPosition && k.position === "fixed" && (l += Math.max(h.scrollTop, i.scrollTop), m += Math.max(h.scrollLeft, i.scrollLeft)); return { top: l, left: m} }, d.offset = { initialize: function () { var a = c.body, b = c.createElement("div"), e, f, g, h, i = parseFloat(d.css(a, "marginTop")) || 0, j = "<div style='position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;'><div></div></div><table style='position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;' cellpadding='0' cellspacing='0'><tr><td></td></tr></table>"; d.extend(b.style, { position: "absolute", top: 0, left: 0, margin: 0, border: 0, width: "1px", height: "1px", visibility: "hidden" }), b.innerHTML = j, a.insertBefore(b, a.firstChild), e = b.firstChild, f = e.firstChild, h = e.nextSibling.firstChild.firstChild, this.doesNotAddBorder = f.offsetTop !== 5, this.doesAddBorderForTableAndCells = h.offsetTop === 5, f.style.position = "fixed", f.style.top = "20px", this.supportsFixedPosition = f.offsetTop === 20 || f.offsetTop === 15, f.style.position = f.style.top = "", e.style.overflow = "hidden", e.style.position = "relative", this.subtractsBorderForOverflowNotVisible = f.offsetTop === -5, this.doesNotIncludeMarginInBodyOffset = a.offsetTop !== i, a.removeChild(b), a = b = e = f = g = h = null, d.offset.initialize = d.noop }, bodyOffset: function (a) { var b = a.offsetTop, c = a.offsetLeft; d.offset.initialize(), d.offset.doesNotIncludeMarginInBodyOffset && (b += parseFloat(d.css(a, "marginTop")) || 0, c += parseFloat(d.css(a, "marginLeft")) || 0); return { top: b, left: c} }, setOffset: function (a, b, c) { var e = d.css(a, "position"); e === "static" && (a.style.position = "relative"); var f = d(a), g = f.offset(), h = d.css(a, "top"), i = d.css(a, "left"), j = e === "absolute" && d.inArray("auto", [h, i]) > -1, k = {}, l = {}, m, n; j && (l = f.position()), m = j ? l.top : parseInt(h, 10) || 0, n = j ? l.left : parseInt(i, 10) || 0, d.isFunction(b) && (b = b.call(a, c, g)), b.top != null && (k.top = b.top - g.top + m), b.left != null && (k.left = b.left - g.left + n), "using" in b ? b.using.call(a, k) : f.css(k) } }, d.fn.extend({ position: function () { if (!this[0]) return null; var a = this[0], b = this.offsetParent(), c = this.offset(), e = cf.test(b[0].nodeName) ? { top: 0, left: 0} : b.offset(); c.top -= parseFloat(d.css(a, "marginTop")) || 0, c.left -= parseFloat(d.css(a, "marginLeft")) || 0, e.top += parseFloat(d.css(b[0], "borderTopWidth")) || 0, e.left += parseFloat(d.css(b[0], "borderLeftWidth")) || 0; return { top: c.top - e.top, left: c.left - e.left} }, offsetParent: function () { return this.map(function () { var a = this.offsetParent || c.body; while (a && (!cf.test(a.nodeName) && d.css(a, "position") === "static")) a = a.offsetParent; return a }) } }), d.each(["Left", "Top"], function (a, c) { var e = "scroll" + c; d.fn[e] = function (c) { var f = this[0], g; if (!f) return null; if (c !== b) return this.each(function () { g = cg(this), g ? g.scrollTo(a ? d(g).scrollLeft() : c, a ? c : d(g).scrollTop()) : this[e] = c }); g = cg(f); return g ? "pageXOffset" in g ? g[a ? "pageYOffset" : "pageXOffset"] : d.support.boxModel && g.document.documentElement[e] || g.document.body[e] : f[e] } }), d.each(["Height", "Width"], function (a, c) { var e = c.toLowerCase(); d.fn["inner" + c] = function () { return this[0] ? parseFloat(d.css(this[0], e, "padding")) : null }, d.fn["outer" + c] = function (a) { return this[0] ? parseFloat(d.css(this[0], e, a ? "margin" : "border")) : null }, d.fn[e] = function (a) { var f = this[0]; if (!f) return a == null ? null : this; if (d.isFunction(a)) return this.each(function (b) { var c = d(this); c[e](a.call(this, b, c[e]())) }); if (d.isWindow(f)) { var g = f.document.documentElement["client" + c]; return f.document.compatMode === "CSS1Compat" && g || f.document.body["client" + c] || g } if (f.nodeType === 9) return Math.max(f.documentElement["client" + c], f.body["scroll" + c], f.documentElement["scroll" + c], f.body["offset" + c], f.documentElement["offset" + c]); if (a === b) { var h = d.css(f, e), i = parseFloat(h); return d.isNaN(i) ? h : i } return this.css(e, typeof a === "string" ? a : a + "px") } }), a.jQuery = a.$ = d })(window);
﻿Array.isSequenceEqual = function (array1, array2)
{
    if (!Array.isArray(array1))
    {
        array1 = [array1];
    }
    if (!Array.isArray(array2))
    {
        array2 = [array2];
    }
    if (array1.length != array2.length)
    {
        return false;
    }

    for (var i = 0; i < array1.length; i++)
    {
        if (array1[i] != array2[i])
        {
            return false;
        }
    }

    return true;
};

String.format = function (format)
{
    /// <summary>
    /// Formats a string.
    /// eg: String.format('The numbers are {0} and {1}', 100, 200);
    /// </summary>    
    ///	<param name="format" type="string">
    /// The string to format using any arguments that follow.
    /// </param>
    /// <returns type="string" />
    var actualArgs = arguments;

    return format.replace(/\{([^}]*)\}/g, function (m, key)
    {
        var keyNum = +key;

        if (isNaN(keyNum))
        {
            throw new Error("Invalid position argument '" + m + "'");
        }
        else if (keyNum < 0)
        {
            throw new Error("Invalid index '" + keyNum + "'");
        }
        else if (keyNum > actualArgs.length - 2)
        {
            throw new Error("Index was outside the bounds of the array");
        }

        var value = actualArgs[keyNum + 1];

        return value;
    });
};

String.isString = function (value)
{
    return value != null && value.constructor == String;
}

String.prototype.ltrim = function ()
{
    return this.replace(/^\s+/, "");
}
String.prototype.rtrim = function ()
{
    return this.replace(/\s+$/, "");
}

$get = function (id)
{
    /// <summary>
    /// Gets the element with the given id.
    /// </summary>
    ///	<param name="id" type="String">
    /// The id of the element to get.
    /// </param>
    /// <returns type="DOMElement" />
    return document.getElementById(id);
}

$log = function (object)
{
    /// <summary>
    /// Logs a message to the browser console.
    /// </summary>
    ///	<param name="object" type="object">
    /// The object to log.  If the value is a string, it is formatted with any parameters that follow.
    /// </param>        
    if (typeof (object) == 'string')
    {
        object = String.format.apply(null, arguments);
    }

    if (window.__debug && window.console && window.console.log)
    {
        window.console.log(object);
    }
}

Utility =
{
    createProperty: function (instance, propertyName, getter, setter)
    {
        if (instance.__defineGetter__)
        {
            if (getter)
            {
                instance.__defineGetter__(propertyName, getter);
            }
            if (setter)
            {
                instance.__defineSetter__(propertyName, setter);
            }
        }
        else
        {
            var propData = {};

            if (getter)
            {
                propData.get = getter;
            }
            if (setter)
            {
                propData.set = setter;
            }

            Object.defineProperty(instance, propertyName, propData);
        }
    },

    createDelegate: function (func, context)
    {
        var del;

        // Use the native bind if available
        if (func.bind)
        {
            del = func.bind(context);
        }
        else
        {
            // No native bind, so return a wrapped function
            del = function ()
            {
                return func.apply(context, arguments);
            };
        }

        return del;
    },

    validateNonNullParameters: function (names, values)
    {
        jQuery.each(names, function (index, item)
        {
            if (values[index] == null)
            {
                throw new Error(String.format("Parameter '{0}' cannot be null", item));
            }
        });
    },

    base64Encode: function (string)
    {
        if (window.btoa)
        {
            // Use native function if available
            return window.btoa(string);
        }

        if (arguments.callee._base64Chars == null)
        {
            arguments.callee._base64Chars = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'];
        }

        var base64Chars = arguments.callee._base64Chars;

        var index = 0;
        var current = 0;
        var numBits = 0;

        var paddedLength = (string.length + 2 - ((string.length + 2) % 3)) / 3 * 4;

        var MASK = (1 << 6) - 1;

        var output = [];

        while (index < paddedLength)
        {
            if (numBits < 6)
            {
                if (index < string.length)
                {
                    current = current << 8 | string.charCodeAt(index);
                    numBits += 8;
                }
                else if (numBits > 0)
                {
                    current = current << (6 - numBits);
                    var c = base64Chars[current & MASK];
                    output.push(c);
                    numBits = 0;
                }

                if (numBits == 0)
                {
                    while (output.length < paddedLength)
                    {
                        output.push('=');
                    }

                    break;
                }

                index++;
            }

            if (numBits >= 0)
            {
                var value = (current >> (numBits - 6)) & MASK;
                value = base64Chars[value];
                output.push(value);

                numBits -= 6;
            }
        }

        return output.join('');
    },

    parseISO8601Date: function (dateString)
    {
        if (dateString == null || dateString.length == 0)
        {
            return;
        }

        var ticks = Date.parse(dateString);
        var date;

        if (isNaN(ticks) == false)
        {
            date = new Date(ticks);
        }
        else
        {
            var arr = dateString.split('-');

            if (arr.length < 3)
            {
                return null;
            }

            var year = parseInt(arr[0], 10);
            var month = parseInt(arr[1], 10) - 1;
            var day = parseInt(arr[2], 10);

            date = new Date(year, month, day);

            if (isNaN(date.getTime()) == true)
            {
                date = null;
            }
        }

        return date;
    },

    applyTemplate: function (templateName, model, targetElement)
    {
        var template = $.template[templateName];

        if (template == null)
        {
            var templateElement = $get(templateName);
            template = jQuery.template(templateName, templateElement);
        }

        $.tmpl(template, model).appendTo(targetElement);
    },

    setLocalStorageValue: function (key, value)
    {
        var localStorage = window.localStorage;

        if (localStorage == null)
        {
            return;
        }

        try
        {
            value = JSON.stringify(value);
            localStorage.setItem(key, value);
        }
        catch (ex)
        {
        }
    },

    getLocalStorageValue: function (key)
    {
        var localStorage = window.localStorage;
        var value = null;

        if (localStorage != null)
        {
            value = localStorage.getItem(key);
            value = JSON.parse(value);
        }

        return value;
    }
};

/*!
 * jQuery Templates Plugin 1.0.0pre
 * http://github.com/jquery/jquery-tmpl
 * Requires jQuery 1.4.2
 *
 * Copyright Software Freedom Conservancy, Inc.
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 */
(function( jQuery, undefined ){
	var oldManip = jQuery.fn.domManip, tmplItmAtt = "_tmplitem", htmlExpr = /^[^<]*(<[\w\W]+>)[^>]*$|\{\{\! /,
		newTmplItems = {}, wrappedItems = {}, appendToTmplItems, topTmplItem = { key: 0, data: {} }, itemKey = 0, cloneIndex = 0, stack = [];

	function newTmplItem( options, parentItem, fn, data ) {
		// Returns a template item data structure for a new rendered instance of a template (a 'template item').
		// The content field is a hierarchical array of strings and nested items (to be
		// removed and replaced by nodes field of dom elements, once inserted in DOM).
		var newItem = {
			data: data || (data === 0 || data === false) ? data : (parentItem ? parentItem.data : {}),
			_wrap: parentItem ? parentItem._wrap : null,
			tmpl: null,
			parent: parentItem || null,
			nodes: [],
			calls: tiCalls,
			nest: tiNest,
			wrap: tiWrap,
			html: tiHtml,
			update: tiUpdate
		};
		if ( options ) {
			jQuery.extend( newItem, options, { nodes: [], parent: parentItem });
		}
		if ( fn ) {
			// Build the hierarchical content to be used during insertion into DOM
			newItem.tmpl = fn;
			newItem._ctnt = newItem._ctnt || newItem.tmpl( jQuery, newItem );
			newItem.key = ++itemKey;
			// Keep track of new template item, until it is stored as jQuery Data on DOM element
			(stack.length ? wrappedItems : newTmplItems)[itemKey] = newItem;
		}
		return newItem;
	}

	// Override appendTo etc., in order to provide support for targeting multiple elements. (This code would disappear if integrated in jquery core).
	jQuery.each({
		appendTo: "append",
		prependTo: "prepend",
		insertBefore: "before",
		insertAfter: "after",
		replaceAll: "replaceWith"
	}, function( name, original ) {
		jQuery.fn[ name ] = function( selector ) {
			var ret = [], insert = jQuery( selector ), elems, i, l, tmplItems,
				parent = this.length === 1 && this[0].parentNode;

			appendToTmplItems = newTmplItems || {};
			if ( parent && parent.nodeType === 11 && parent.childNodes.length === 1 && insert.length === 1 ) {
				insert[ original ]( this[0] );
				ret = this;
			} else {
				for ( i = 0, l = insert.length; i < l; i++ ) {
					cloneIndex = i;
					elems = (i > 0 ? this.clone(true) : this).get();
					jQuery( insert[i] )[ original ]( elems );
					ret = ret.concat( elems );
				}
				cloneIndex = 0;
				ret = this.pushStack( ret, name, insert.selector );
			}
			tmplItems = appendToTmplItems;
			appendToTmplItems = null;
			jQuery.tmpl.complete( tmplItems );
			return ret;
		};
	});

	jQuery.fn.extend({
		// Use first wrapped element as template markup.
		// Return wrapped set of template items, obtained by rendering template against data.
		tmpl: function( data, options, parentItem ) {
			return jQuery.tmpl( this[0], data, options, parentItem );
		},

		// Find which rendered template item the first wrapped DOM element belongs to
		tmplItem: function() {
			return jQuery.tmplItem( this[0] );
		},

		// Consider the first wrapped element as a template declaration, and get the compiled template or store it as a named template.
		template: function( name ) {
			return jQuery.template( name, this[0] );
		},

		domManip: function( args, table, callback, options ) {
			if ( args[0] && jQuery.isArray( args[0] )) {
				var dmArgs = jQuery.makeArray( arguments ), elems = args[0], elemsLength = elems.length, i = 0, tmplItem;
				while ( i < elemsLength && !(tmplItem = jQuery.data( elems[i++], "tmplItem" ))) {}
				if ( tmplItem && cloneIndex ) {
					dmArgs[2] = function( fragClone ) {
						// Handler called by oldManip when rendered template has been inserted into DOM.
						jQuery.tmpl.afterManip( this, fragClone, callback );
					};
				}
				oldManip.apply( this, dmArgs );
			} else {
				oldManip.apply( this, arguments );
			}
			cloneIndex = 0;
			if ( !appendToTmplItems ) {
				jQuery.tmpl.complete( newTmplItems );
			}
			return this;
		}
	});

	jQuery.extend({
		// Return wrapped set of template items, obtained by rendering template against data.
		tmpl: function( tmpl, data, options, parentItem ) {
			var ret, topLevel = !parentItem;
			if ( topLevel ) {
				// This is a top-level tmpl call (not from a nested template using {{tmpl}})
				parentItem = topTmplItem;
				tmpl = jQuery.template[tmpl] || jQuery.template( null, tmpl );
				wrappedItems = {}; // Any wrapped items will be rebuilt, since this is top level
			} else if ( !tmpl ) {
				// The template item is already associated with DOM - this is a refresh.
				// Re-evaluate rendered template for the parentItem
				tmpl = parentItem.tmpl;
				newTmplItems[parentItem.key] = parentItem;
				parentItem.nodes = [];
				if ( parentItem.wrapped ) {
					updateWrapped( parentItem, parentItem.wrapped );
				}
				// Rebuild, without creating a new template item
				return jQuery( build( parentItem, null, parentItem.tmpl( jQuery, parentItem ) ));
			}
			if ( !tmpl ) {
				return []; // Could throw...
			}
			if ( typeof data === "function" ) {
				data = data.call( parentItem || {} );
			}
			if ( options && options.wrapped ) {
				updateWrapped( options, options.wrapped );
			}
			ret = jQuery.isArray( data ) ?
				jQuery.map( data, function( dataItem ) {
					return dataItem ? newTmplItem( options, parentItem, tmpl, dataItem ) : null;
				}) :
				[ newTmplItem( options, parentItem, tmpl, data ) ];
			return topLevel ? jQuery( build( parentItem, null, ret ) ) : ret;
		},

		// Return rendered template item for an element.
		tmplItem: function( elem ) {
			var tmplItem;
			if ( elem instanceof jQuery ) {
				elem = elem[0];
			}
			while ( elem && elem.nodeType === 1 && !(tmplItem = jQuery.data( elem, "tmplItem" )) && (elem = elem.parentNode) ) {}
			return tmplItem || topTmplItem;
		},

		// Set:
		// Use $.template( name, tmpl ) to cache a named template,
		// where tmpl is a template string, a script element or a jQuery instance wrapping a script element, etc.
		// Use $( "selector" ).template( name ) to provide access by name to a script block template declaration.

		// Get:
		// Use $.template( name ) to access a cached template.
		// Also $( selectorToScriptBlock ).template(), or $.template( null, templateString )
		// will return the compiled template, without adding a name reference.
		// If templateString includes at least one HTML tag, $.template( templateString ) is equivalent
		// to $.template( null, templateString )
		template: function( name, tmpl ) {
			if (tmpl) {
				// Compile template and associate with name
				if ( typeof tmpl === "string" ) {
					// This is an HTML string being passed directly in.
					tmpl = buildTmplFn( tmpl )
				} else if ( tmpl instanceof jQuery ) {
					tmpl = tmpl[0] || {};
				}
				if ( tmpl.nodeType ) {
					// If this is a template block, use cached copy, or generate tmpl function and cache.
					tmpl = jQuery.data( tmpl, "tmpl" ) || jQuery.data( tmpl, "tmpl", buildTmplFn( tmpl.innerHTML ));
					// Issue: In IE, if the container element is not a script block, the innerHTML will remove quotes from attribute values whenever the value does not include white space.
					// This means that foo="${x}" will not work if the value of x includes white space: foo="${x}" -> foo=value of x.
					// To correct this, include space in tag: foo="${ x }" -> foo="value of x"
				}
				return typeof name === "string" ? (jQuery.template[name] = tmpl) : tmpl;
			}
			// Return named compiled template
			return name ? (typeof name !== "string" ? jQuery.template( null, name ):
				(jQuery.template[name] ||
					// If not in map, and not containing at least on HTML tag, treat as a selector.
					// (If integrated with core, use quickExpr.exec)
					jQuery.template( null, htmlExpr.test( name ) ? name : jQuery( name )))) : null;
		},

		encode: function( text ) {
			// Do HTML encoding replacing < > & and ' and " by corresponding entities.
			return ("" + text).split("<").join("&lt;").split(">").join("&gt;").split('"').join("&#34;").split("'").join("&#39;");
		}
	});

	jQuery.extend( jQuery.tmpl, {
		tag: {
			"tmpl": {
				_default: { $2: "null" },
				open: "if($notnull_1){__=__.concat($item.nest($1,$2));}"
				// tmpl target parameter can be of type function, so use $1, not $1a (so not auto detection of functions)
				// This means that {{tmpl foo}} treats foo as a template (which IS a function).
				// Explicit parens can be used if foo is a function that returns a template: {{tmpl foo()}}.
			},
			"wrap": {
				_default: { $2: "null" },
				open: "$item.calls(__,$1,$2);__=[];",
				close: "call=$item.calls();__=call._.concat($item.wrap(call,__));"
			},
			"each": {
				_default: { $2: "$index, $value" },
				open: "if($notnull_1){$.each($1a,function($2){with(this){",
				close: "}});}"
			},
			"if": {
				open: "if(($notnull_1) && $1a){",
				close: "}"
			},
			"else": {
				_default: { $1: "true" },
				open: "}else if(($notnull_1) && $1a){"
			},
			"html": {
				// Unecoded expression evaluation.
				open: "if($notnull_1){__.push($1a);}"
			},
			"=": {
				// Encoded expression evaluation. Abbreviated form is ${}.
				_default: { $1: "$data" },
				open: "if($notnull_1){__.push($.encode($1a));}"
			},
			"!": {
				// Comment tag. Skipped by parser
				open: ""
			}
		},

		// This stub can be overridden, e.g. in jquery.tmplPlus for providing rendered events
		complete: function( items ) {
			newTmplItems = {};
		},

		// Call this from code which overrides domManip, or equivalent
		// Manage cloning/storing template items etc.
		afterManip: function afterManip( elem, fragClone, callback ) {
			// Provides cloned fragment ready for fixup prior to and after insertion into DOM
			var content = fragClone.nodeType === 11 ?
				jQuery.makeArray(fragClone.childNodes) :
				fragClone.nodeType === 1 ? [fragClone] : [];

			// Return fragment to original caller (e.g. append) for DOM insertion
			callback.call( elem, fragClone );

			// Fragment has been inserted:- Add inserted nodes to tmplItem data structure. Replace inserted element annotations by jQuery.data.
			storeTmplItems( content );
			cloneIndex++;
		}
	});

	//========================== Private helper functions, used by code above ==========================

	function build( tmplItem, nested, content ) {
		// Convert hierarchical content into flat string array
		// and finally return array of fragments ready for DOM insertion
		var frag, ret = content ? jQuery.map( content, function( item ) {
			return (typeof item === "string") ?
				// Insert template item annotations, to be converted to jQuery.data( "tmplItem" ) when elems are inserted into DOM.
				(tmplItem.key ? item.replace( /(<\w+)(?=[\s>])(?![^>]*_tmplitem)([^>]*)/g, "$1 " + tmplItmAtt + "=\"" + tmplItem.key + "\" $2" ) : item) :
				// This is a child template item. Build nested template.
				build( item, tmplItem, item._ctnt );
		}) :
		// If content is not defined, insert tmplItem directly. Not a template item. May be a string, or a string array, e.g. from {{html $item.html()}}.
		tmplItem;
		if ( nested ) {
			return ret;
		}

		// top-level template
		ret = ret.join("");

		// Support templates which have initial or final text nodes, or consist only of text
		// Also support HTML entities within the HTML markup.
		ret.replace( /^\s*([^<\s][^<]*)?(<[\w\W]+>)([^>]*[^>\s])?\s*$/, function( all, before, middle, after) {
			frag = jQuery( middle ).get();

			storeTmplItems( frag );
			if ( before ) {
				frag = unencode( before ).concat(frag);
			}
			if ( after ) {
				frag = frag.concat(unencode( after ));
			}
		});
		return frag ? frag : unencode( ret );
	}

	function unencode( text ) {
		// Use createElement, since createTextNode will not render HTML entities correctly
		var el = document.createElement( "div" );
		el.innerHTML = text;
		return jQuery.makeArray(el.childNodes);
	}

	// Generate a reusable function that will serve to render a template against data
	function buildTmplFn( markup ) {
		return new Function("jQuery","$item",
			// Use the variable __ to hold a string array while building the compiled template. (See https://github.com/jquery/jquery-tmpl/issues#issue/10).
			"var $=jQuery,call,__=[],$data=$item.data;" +

			// Introduce the data as local variables using with(){}
			"with($data){__.push('" +

			// Convert the template into pure JavaScript
			jQuery.trim(markup)
				.replace( /([\\'])/g, "\\$1" )
				.replace( /[\r\t\n]/g, " " )
				.replace( /\$\{([^\}]*)\}/g, "{{= $1}}" )
				.replace( /\{\{(\/?)(\w+|.)(?:\(((?:[^\}]|\}(?!\}))*?)?\))?(?:\s+(.*?)?)?(\(((?:[^\}]|\}(?!\}))*?)\))?\s*\}\}/g,
				function( all, slash, type, fnargs, target, parens, args ) {
					var tag = jQuery.tmpl.tag[ type ], def, expr, exprAutoFnDetect;
					if ( !tag ) {
						throw "Unknown template tag: " + type;
					}
					def = tag._default || [];
					if ( parens && !/\w$/.test(target)) {
						target += parens;
						parens = "";
					}
					if ( target ) {
						target = unescape( target );
						args = args ? ("," + unescape( args ) + ")") : (parens ? ")" : "");
						// Support for target being things like a.toLowerCase();
						// In that case don't call with template item as 'this' pointer. Just evaluate...
						expr = parens ? (target.indexOf(".") > -1 ? target + unescape( parens ) : ("(" + target + ").call($item" + args)) : target;
						exprAutoFnDetect = parens ? expr : "(typeof(" + target + ")==='function'?(" + target + ").call($item):(" + target + "))";
					} else {
						exprAutoFnDetect = expr = def.$1 || "null";
					}
					fnargs = unescape( fnargs );
					return "');" +
						tag[ slash ? "close" : "open" ]
							.split( "$notnull_1" ).join( target ? "typeof(" + target + ")!=='undefined' && (" + target + ")!=null" : "true" )
							.split( "$1a" ).join( exprAutoFnDetect )
							.split( "$1" ).join( expr )
							.split( "$2" ).join( fnargs || def.$2 || "" ) +
						"__.push('";
				}) +
			"');}return __;"
		);
	}
	function updateWrapped( options, wrapped ) {
		// Build the wrapped content.
		options._wrap = build( options, true,
			// Suport imperative scenario in which options.wrapped can be set to a selector or an HTML string.
			jQuery.isArray( wrapped ) ? wrapped : [htmlExpr.test( wrapped ) ? wrapped : jQuery( wrapped ).html()]
		).join("");
	}

	function unescape( args ) {
		return args ? args.replace( /\\'/g, "'").replace(/\\\\/g, "\\" ) : null;
	}
	function outerHtml( elem ) {
		var div = document.createElement("div");
		div.appendChild( elem.cloneNode(true) );
		return div.innerHTML;
	}

	// Store template items in jQuery.data(), ensuring a unique tmplItem data data structure for each rendered template instance.
	function storeTmplItems( content ) {
		var keySuffix = "_" + cloneIndex, elem, elems, newClonedItems = {}, i, l, m;
		for ( i = 0, l = content.length; i < l; i++ ) {
			if ( (elem = content[i]).nodeType !== 1 ) {
				continue;
			}
			elems = elem.getElementsByTagName("*");
			for ( m = elems.length - 1; m >= 0; m-- ) {
				processItemKey( elems[m] );
			}
			processItemKey( elem );
		}
		function processItemKey( el ) {
			var pntKey, pntNode = el, pntItem, tmplItem, key;
			// Ensure that each rendered template inserted into the DOM has its own template item,
			if ( (key = el.getAttribute( tmplItmAtt ))) {
				while ( pntNode.parentNode && (pntNode = pntNode.parentNode).nodeType === 1 && !(pntKey = pntNode.getAttribute( tmplItmAtt ))) { }
				if ( pntKey !== key ) {
					// The next ancestor with a _tmplitem expando is on a different key than this one.
					// So this is a top-level element within this template item
					// Set pntNode to the key of the parentNode, or to 0 if pntNode.parentNode is null, or pntNode is a fragment.
					pntNode = pntNode.parentNode ? (pntNode.nodeType === 11 ? 0 : (pntNode.getAttribute( tmplItmAtt ) || 0)) : 0;
					if ( !(tmplItem = newTmplItems[key]) ) {
						// The item is for wrapped content, and was copied from the temporary parent wrappedItem.
						tmplItem = wrappedItems[key];
						tmplItem = newTmplItem( tmplItem, newTmplItems[pntNode]||wrappedItems[pntNode] );
						tmplItem.key = ++itemKey;
						newTmplItems[itemKey] = tmplItem;
					}
					if ( cloneIndex ) {
						cloneTmplItem( key );
					}
				}
				el.removeAttribute( tmplItmAtt );
			} else if ( cloneIndex && (tmplItem = jQuery.data( el, "tmplItem" )) ) {
				// This was a rendered element, cloned during append or appendTo etc.
				// TmplItem stored in jQuery data has already been cloned in cloneCopyEvent. We must replace it with a fresh cloned tmplItem.
				cloneTmplItem( tmplItem.key );
				newTmplItems[tmplItem.key] = tmplItem;
				pntNode = jQuery.data( el.parentNode, "tmplItem" );
				pntNode = pntNode ? pntNode.key : 0;
			}
			if ( tmplItem ) {
				pntItem = tmplItem;
				// Find the template item of the parent element.
				// (Using !=, not !==, since pntItem.key is number, and pntNode may be a string)
				while ( pntItem && pntItem.key != pntNode ) {
					// Add this element as a top-level node for this rendered template item, as well as for any
					// ancestor items between this item and the item of its parent element
					pntItem.nodes.push( el );
					pntItem = pntItem.parent;
				}
				// Delete content built during rendering - reduce API surface area and memory use, and avoid exposing of stale data after rendering...
				delete tmplItem._ctnt;
				delete tmplItem._wrap;
				// Store template item as jQuery data on the element
				jQuery.data( el, "tmplItem", tmplItem );
			}
			function cloneTmplItem( key ) {
				key = key + keySuffix;
				tmplItem = newClonedItems[key] =
					(newClonedItems[key] || newTmplItem( tmplItem, newTmplItems[tmplItem.parent.key + keySuffix] || tmplItem.parent ));
			}
		}
	}

	//---- Helper functions for template item ----

	function tiCalls( content, tmpl, data, options ) {
		if ( !content ) {
			return stack.pop();
		}
		stack.push({ _: content, tmpl: tmpl, item:this, data: data, options: options });
	}

	function tiNest( tmpl, data, options ) {
		// nested template, using {{tmpl}} tag
		return jQuery.tmpl( jQuery.template( tmpl ), data, options, this );
	}

	function tiWrap( call, wrapped ) {
		// nested template, using {{wrap}} tag
		var options = call.options || {};
		options.wrapped = wrapped;
		// Apply the template, which may incorporate wrapped content,
		return jQuery.tmpl( jQuery.template( call.tmpl ), call.data, options, call.item );
	}

	function tiHtml( filter, textOnly ) {
		var wrapped = this._wrap;
		return jQuery.map(
			jQuery( jQuery.isArray( wrapped ) ? wrapped.join("") : wrapped ).filter( filter || "*" ),
			function(e) {
				return textOnly ?
					e.innerText || e.textContent :
					e.outerHTML || outerHtml(e);
			});
	}

	function tiUpdate() {
		var coll = this.nodes;
		jQuery.tmpl( null, null, null, this).insertBefore( coll[0] );
		jQuery( coll ).remove();
	}
})( jQuery );

﻿// Namespace
Dundas = {};
Dundas.Dashboard = {};

Dundas.Dashboard.Utility = window.Utility;
delete window.Utility;

/* Simple JavaScript Inheritance
* By John Resig http://ejohn.org/
* MIT Licensed.
*
http://ejohn.org/blog/simple-javascript-inheritance/
*/

(function ()
{
    var initializing = false, fnTest = /xyz/.test(function () { xyz; }) ? /\b_super\b/ : /.*/;

    // The base Class implementation (does nothing)
    this.Class = function () { };

    // Create a new Class that inherits from this class
    Class.extend = function (prop)
    {
        var _super = this.prototype;

        // Instantiate a base class (but only create the instance,
        // don't run the init constructor)
        initializing = true;
        var prototype = new this();
        initializing = false;

        // Copy the properties over onto the new prototype
        for (var name in prop)
        {
            // Check if we're overwriting an existing function
            if (typeof prop[name] == "function" && typeof _super[name] == "function" && fnTest.test(prop[name]))
            {
                prototype[name] = (function (name, fn)
                {
                    return function ()
                    {
                        var tmp = this._super;

                        // Add a new ._super() method that is the same method
                        // but on the super-class
                        this._super = _super[name];

                        // The method only need to be bound temporarily, so we
                        // remove it when we're done executing
                        var ret = fn.apply(this, arguments);
                        this._super = tmp;

                        return ret;
                    };
                })(name, prop[name]);
            }
            else if (name == '__properties')
            {
                // Create the properties on the prototype                
                var propertyDescriptors = prop[name];

                if (Object.defineProperty)
                {
                    for (var propName in propertyDescriptors)
                    {
                        Object.defineProperty(prototype, propName, propertyDescriptors[propName]);
                    }
                }
                else if (prototype.__defineGetter__)
                {
                    for (var propName in propertyDescriptors)
                    {
                        var propDescriptor = propertyDescriptors[propName];

                        if (propDescriptor.get)
                        {
                            prototype.__defineGetter__(propName, propDescriptor.get);
                        }

                        if (propDescriptor.set)
                        {
                            prototype.__defineSetter__(propName, propDescriptor.set);
                        }
                    }
                }
            }
            else
            {
                // Regular value
                prototype[name] = prop[name];
            }
        }

        // The dummy class constructor
        function Class()
        {
            // All construction is actually done in the init method
            if (!initializing && this.init)
                this.init.apply(this, arguments);
        }

        // Populate our constructed prototype object
        Class.prototype = prototype;

        // Enforce the constructor to be what we expect
        Class.constructor = Class;

        // And make this class extendable
        Class.extend = arguments.callee;

        return Class;
    };
})();
﻿Dundas.Dashboard.Component = Class.extend(
{
    init: function ()
    {
        this._site = null;
        this._uniqueId = null;
    },

    dispose: function ()
    {

    },

    getService: function (serviceType)
    {
        if (this.Site)
        {
            return this.Site.getService(serviceType);
        }
        else
        {
            return null;
        }
    },

    createDelegate: function (func, context)
    {
        // If no context is given, then use this instance
        if (!context)
        {
            context = this;
        }

        return this.ScriptManager.createDelegate(func, context);
    },

    createTimeout: function (func, timeout, context)
    {
        var del = this.createDelegate(func, context);

        var token = {};
        var timeoutId = null;

        token.cancel = function ()
        {
            if (timeout != null)
            {
                window.clearTimeout(timeoutId);
                timeoutId = null;
            }
        }

        timeoutId = window.setTimeout(del, timeout);

        return token;
    },

    dispatch: function (func, context)
    {
        var del = this.createDelegate(func, context);
        window.setTimeout(del, 0);
    },

    bindEvent: function (instance, eventName, handler, raw)
    {
        Dundas.Dashboard.Utility.validateNonNullParameters(['instance', 'eventName', 'handler'], arguments);

        var del = this.createDelegate(handler);

        var ddEventData = {};
        ddEventData.owner = this;
        ddEventData.originalHandler = handler;

        if (!raw && eventName == 'click')
        {
            var bridge = this.ScriptManager.createObject(Dundas.Dashboard.ClickTapBridgeBehavior);
            bridge.TargetElement = instance;
            bridge.Handler = del;

            ddEventData._clickBridge = bridge;
            eventName = '_click_touch_bridge';
        }

        $(instance).bind(eventName, del);

        var eventData = $(instance).data('events');
        eventData = eventData[eventName];
        eventData = eventData[eventData.length - 1];
        eventData.ddEventData = ddEventData;
    },

    unbindEvent: function (instance, eventName, handler, raw)
    {
        var eventData = this._findEventData(instance, eventName, handler);

        if (eventData == null)
        {
            eventData = this._findEventData(instance, '_click_touch_bridge', handler);

            if (eventData != null)
            {
                var ddEventData = eventData.ddEventData;
                var bridge = ddEventData._clickBridge;
                bridge.TargetElement = null;
                bridge.Handler = null;
                this.ScriptManager.destroyComponent(bridge);

                eventName = '_click_touch_bridge';
            }
        }

        if (eventData == null)
        {
            // No handler found for this event
            return;
        }

        $(instance).unbind(eventName, eventData.handler);
    },

    _hasEvent: function (instance, eventName)
    {
        var data = $(instance).data('events');
        return data != null && data[eventName] != null;
    },

    _findEventData: function (instance, eventName, handler)
    {
        var data = $(instance).data('events');

        if (data == null)
        {
            return null;
        }

        data = data[eventName];

        if (data == null)
        {
            return null;
        }

        var found = null;
        var owner = this;

        jQuery.each(data, function (index, value)
        {
            var ddEventData = value.ddEventData;

            if (ddEventData == null)
            {
                return;
            }

            if (ddEventData.owner == owner && ddEventData.originalHandler == handler)
            {
                found = value;
                return false;
            }
        });

        return found;
    },

    _getjQueryEventGuid: function (instance, eventName)
    {
        var data = $(instance).data('events');

        data = data[eventName];

        var found = null;

        jQuery.each(data, function (index, value)
        {

        });
    },

    __properties:
    {
        'Site':
        {
            get: function () { return this._site; },
            set: function (value)
            {
                var oldSite = this._site;

                this._site = value;

                if (oldSite == null && this._site != null && this.onLoaded)
                {
                    this.onLoaded();
                }
            }
        },

        'ScriptManager':
        {
            get: function () { return Dundas.Dashboard.ScriptManager.Instance; }
        },

        'UniqueId':
        {
            get: function () { return this._uniqueId; },
            set: function (value)
            {
                if (this._uniqueId != null)
                {
                    throw new Error("Unique id already set");
                }

                this._uniqueId = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.Control = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        this._targetElementId = null;
        this._targetElement = null;        
    },

    onLoaded: function ()
    {
        if (this._targetElement == undefined && this._targetElementId != null)
        {
            this._targetElement = this._findTargetElement(this._targetElementId);

            if (this._targetElement == null)
            {
                throw new Error(String.format("Target element with id '{0}' was not found", this._targetElementId));
            }

            $(this._targetElement).data('_DdControl', this);            
        }
    },

    _findTargetElement: function (id)
    {
        return $get(id);
    },

    _executeTargetElementInteractions: function (interactionType, eventArgs)
    {
        var interactions = Dundas.Dashboard.Interaction.getElementInteractions(this.TargetElement, interactionType);

        if (interactions == null || Array.isArray(interactions) == false)
        {
            return false;
        }

        interactions.forEach(function (interaction)
        {
            interaction.execute(eventArgs);
        });

        return interactions.length > 0;
    },

    _doControlStateUpdate: function ()
    {
        var sm = this.ScriptManager;
        var updateData = sm.createDashboardUpdateData();

        var data = {};
        data.Name = this.Id;

        this.saveState(data);

        updateData.ControlChange = data;

        sm.updateDashboard(updateData);
    },

    _registerDateFields: function (fieldNames)
    {
        this.__df = fieldNames;
    },

    _isInputTypeSupported: function (type, includeUISupport)
    {
        var input = document.createElement('input');
        input.setAttribute('type', type);

        var supported = input.type !== 'text';

        if (supported && includeUISupport)
        {
            var testValue = ';';
            input.value = testValue;
            supported = supported && input.value !== testValue;
        }

        return supported;
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                return this._targetElement;
            },
            set: function (value)
            {
                this._targetElement = value;
            }
        },

        'Id':
        {
            get: function ()
            {
                return this._targetElement.id;
            }
        }
    }
});

Dundas.Dashboard.Control.fromElement = function (element)
{
    var control = null;

    if (element)
    {
        control = $(element).data('_DdControl');
    }

    return control;
}
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardAnimator = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        this._targets = null;
    },

    onLoaded: function ()
    {
        if (this._targets == null)
        {
            return;
        }

        this.bindEvent(this.ScriptManager, 'UpdateComplete', this._onDashboardUpdateComplete);
        this.bindEvent(this.ScriptManager, 'LoadComplete', this._onDashboardLoaded);
    },

    _onDashboardUpdateComplete: function ()
    {
        this.unbindEvent(this.ScriptManager, 'UpdateComplete', this._onDashboardUpdateComplete);

        window.setTimeout(this.createDelegate(this._animateTargets), 100);
    },

    _onDashboardLoaded: function ()
    {
        this._animateTargets();
    },

    _animateTargets: function ()
    {
        for (var cssClass in this._targets)
        {
            var ids = this._targets[cssClass];

            jQuery.each(ids, function (index, item)
            {
                ids[index] = '#' + item;
            });

            var selector = ids.join(',');

            $(selector).addClass(cssClass);
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ClickAwayBehavior = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        this._super();
        this._targetElement = null;
    },

    _attach: function ()
    {
        this.ScriptManager.registerForMouseEventSetup(this.createDelegate(this._coreAttach));
    },

    _coreAttach: function ()
    {
        var scriptManager = this.ScriptManager;
        var target = this._getEventTarget();

        if (scriptManager.IsTouchBrowser == false)
        {
            this.bindEvent(target, 'mousedown', this._onClick);
        }
        else
        {
            this.bindEvent(target, 'touchstart', this._onClick);
        }
    },

    _detach: function ()
    {
        var target = this._getEventTarget();

        this.unbindEvent(target, 'mousedown', this._onClick);
        this.unbindEvent(target, 'touchstart', this._onClick);
    },

    _getEventTarget: function ()
    {
        return window;
    },

    _onClick: function (e)
    {
        if (jQuery.contains(this.TargetElement, e.target) == true)
        {
            return;
        }

        $(this).trigger('ClickAway', e);
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                return this._targetElement;
            },

            set: function (value)
            {
                if (this._targetElement != null)
                {
                    this._detach();
                }

                this._targetElement = value;

                if (this._targetElement != null)
                {
                    this._attach();
                }
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ClickTapBridgeBehavior = Dundas.Dashboard.Component.extend(
{
    // The most distance a finger is allowed to move for us to still consider it a touch
    _TOUCH_MOVE_THRESHOLD: 5,

    _TOUCH_IGNORE_TIME: 150,

    init: function ()
    {
        this._super();
        this._targetElement = null;
        this._handler = null;
        this._touchStartPos = null;
        this._touchOnly = false;
        this._touchStartTime = null;
        this._pendingInvokeDelegate = null;        
    },

    _attach: function ()
    {
        var scriptManager = this.ScriptManager;

        scriptManager.registerForMouseEventSetup(this.createDelegate(this._coreAttach));        
    },

    _coreAttach: function ()
    {
        var scriptManager = this.ScriptManager;

        if (this.TouchOnly == false && scriptManager.IsTouchBrowser == false)
        {
            this.bindEvent(this.TargetElement, 'click', this._onClick, true);
        }

        this._hookTouchStart(true);
    },

    _detach: function ()
    {
        this.unbindEvent(this.TargetElement, 'click', this._onClick, true);
        this._hookTouchStart(false);
        this._hookTouchEnd(false);
    },

    _hookTouchStart: function (hook)
    {
        if (hook)
        {
            this.bindEvent(this.TargetElement, 'touchstart', this._onTouchStart);
        }
        else
        {
            this.unbindEvent(this.TargetElement, 'touchstart', this._onTouchStart);
        }
    },

    _hookTouchEnd: function (hook)
    {
        if (hook)
        {
            this.bindEvent(this.TargetElement, 'touchend', this._onTouchEnd);
        }
        else
        {
            this.unbindEvent(this.TargetElement, 'touchend', this._onTouchEnd);
        }
    },

    _onClick: function (e)
    {
        // If we get here, then no touch event was fired so we just fire a regular click
        this._invokeHandler(e);
    },

    _onTouchStart: function (e)
    {
        // We got another touch start while we're already waiting to fire the tap event.  This can be caused
        // by the user double-tapping the screen.  Abort the tap firing and let the double tap do the default behavior.
        if (this._pendingInvokeDelegate != null)
        {
            this._pendingInvokeDelegate.cancel();
            this._pendingInvokeDelegate = null;
            return;
        }

        // If we got here, then we're on a touch browser and so we don't need to listen to clicks
        this.unbindEvent(this.TargetElement, 'click', this._onClick, true);

        var touches = e.originalEvent.touches;

        if (touches.length > 1)
        {
            // Multi-touch, cancel behavior
            this._hookTouchEnd(false);
            return;
        }

        // Save the touch start position
        this._touchStartPos = this._getFirstTouchPos(touches);
        this._touchStartTime = Date.now();

        // Listen for touch end
        this._hookTouchEnd(true);
    },

    _getFirstTouchPos: function (touches)
    {
        var touch = touches[0];
        return { x: touch.pageX, y: touch.pageY };
    },

    _onTouchEnd: function (e)
    {
        this._hookTouchEnd(false);

        // Get the end position of the first touch
        var touchEndPos = this._getFirstTouchPos(e.originalEvent.changedTouches);

        var deltaX = this._touchStartPos.x - touchEndPos.x;
        var deltaY = this._touchStartPos.y - touchEndPos.y;

        // If the touch moved less than our threshold, then it's a tap
        var distance = Math.sqrt((deltaX * deltaX) + (deltaY * deltaY));

        if (distance >= this._TOUCH_MOVE_THRESHOLD)
        {
            return;
        }

        e.pageX = touchEndPos.x;
        e.pageY = touchEndPos.y;
        e.touchDuration = Date.now() - this._touchStartTime;

        // Delay fire our event
        this._pendingInvokeDelegate = this.createTimeout(function ()
        {
            // The invoke was cancelled somewhere else
            if (this._pendingInvokeDelegate == null)
            {
                return;
            }

            this._invokeHandler(e);
            this._pendingInvokeDelegate = null;
        }, this._TOUCH_IGNORE_TIME);
    },

    _invokeHandler: function (e)
    {
        if (this.Handler)
        {
            this.Handler(e);
        }

        $(this).trigger('ClickTap', [e]);
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                return this._targetElement;
            },

            set: function (value)
            {
                if (this._targetElement != null)
                {
                    this._detach();
                }

                this._targetElement = value;

                if (this._targetElement != null)
                {
                    this._attach();
                }
            }
        },

        'Handler':
        {
            get: function ()
            {
                return this._handler;
            },

            set: function (value)
            {
                this._handler = value;
            }
        },

        'TouchOnly':
        {
            get: function ()
            {
                return this._touchOnly;
            },

            set: function (value)
            {
                this._touchOnly = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.HoverBehavior = Dundas.Dashboard.Component.extend(
{
    // Amount of time (in seconds) that the mouse must hover before we fire the hover event
    _HOVER_DELAY: 1,

    init: function ()
    {
        this._super();
        this._targetElement = null;
        this._hoverTimeoutToken = null;
        this._lastMouseArgs = null;
        this._touchBehavior = null;
    },

    _attach: function ()
    {
        var scriptManager = this.ScriptManager;

        scriptManager.registerForMouseEventSetup(this.createDelegate(this._coreAttach));
    },

    _coreAttach: function ()
    {
        var scriptManager = this.ScriptManager;

        var element = this.TargetElement;

        if (scriptManager.IsTouchBrowser == false)
        {
            this._attachMouse(true);
        }
        else
        {
            this._touchBehavior = this.ScriptManager.createObject(Dundas.Dashboard.ClickTapBridgeBehavior);
            this._touchBehavior.TouchOnly = true;
            this._touchBehavior.TargetElement = element;
            this.bindEvent(this._touchBehavior, 'ClickTap', this._onTouch);
        }
    },

    _detach: function ()
    {
        var element = this.TargetElement;

        this._attachMouse(false);

        if (this._touchBehavior != null)
        {
            this._touchBehavior.TargetElement = null;
        }
    },

    _onFirstInput: function ()
    {
        this._coreAttach();
    },

    _attachMouse: function (hook)
    {
        var element = this.TargetElement;

        if (hook == true)
        {
            this.bindEvent(element, 'mouseover', this._onMouseEnter);
            this.bindEvent(element, 'mouseout', this._onMouseLeave);
            this.bindEvent(element, 'mousemove', this._onMouseMove);
        }
        else
        {
            this.unbindEvent(element, 'mouseover', this._onMouseEnter);
            this.unbindEvent(element, 'mouseout', this._onMouseLeave);
            this.unbindEvent(element, 'mousemove', this._onMouseMove);
        }
    },

    _onTouch: function (e, touchArgs)
    {
        this._resetHover();
        this._lastMouseArgs = touchArgs;

        this._onHover();
    },

    _onMouseEnter: function (e)
    {
        this._setHoverTimeout();
    },

    _onMouseLeave: function (e)
    {
        this._resetHover();
        this._lastMouseArgs = null;
    },

    _onMouseMove: function (e)
    {
        if (this._lastMouseArgs && e.target == this._lastMouseArgs.target)
        {
            // Ignore if the current mouse move trigger is the same as the last one (ie: mouse is moving over the same element)
            return;
        }

        this._lastMouseArgs = e;
        this._setHoverTimeout();
    },

    _setHoverTimeout: function ()
    {
        this._resetHover();
        this._hoverTimeoutToken = this.createTimeout(this._onHover, this._HOVER_DELAY * 1000);
    },

    _onHover: function ()
    {
        if (this._lastMouseArgs == null)
        {
            return;
        }

        $(this).trigger('Hover', this._lastMouseArgs);
    },

    _resetHover: function ()
    {
        if (this._hoverTimeoutToken != null)
        {
            this._hoverTimeoutToken.cancel();
            this._hoverTimeoutToken = null;
        }
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                return this._targetElement;
            },

            set: function (value)
            {
                if (this._targetElement != null)
                {
                    this._detach();
                }

                this._targetElement = value;

                if (this._targetElement != null)
                {
                    this._attach();
                }
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.TooltipBehavior = Dundas.Dashboard.Component.extend(
{
    _TOUCH_DURATION_THRESHOLD: 200,

    init: function ()
    {
        this._super();
        this._targetElement = null;
        this._touchBehavior = null;
        this._popupContent = null;
    },

    _attach: function ()
    {
        // Also hook any touches since these will fire faster than the mouse events on touch browsers
        this._touchBehavior = this.ScriptManager.createObject(Dundas.Dashboard.ClickTapBridgeBehavior);

        this._touchBehavior.TouchOnly = true;

        this._touchBehavior.TargetElement = this.TargetElement;
        this.bindEvent(this._touchBehavior, 'ClickTap', this._onTouch);

        this._popupContent = document.createElement('div');
        var label = document.createElement('label');

        this._popupContent.appendChild(label);
        $(this._popupContent).addClass('TooltipPopupContent');
    },

    _detach: function ()
    {
        var element = this.TargetElement;
        this._touchBehavior.TargetElement = null;
    },

    _onTouch: function (e, touchArgs)
    {
        if (touchArgs.touchDuration < this._TOUCH_DURATION_THRESHOLD)
        {
            // Show tooltip on 'slow' touches and not quick taps
            return;
        }

        var target = touchArgs.target;
        var text = null;

        if (target instanceof SVGElement)
        {
            text = this._getSvgElementTooltip(target);
        }
        else
        {
            text = this._getHtmlElementTooltip(target);
        }

        if (text == null)
        {
            return;
        }

        $('label', this._popupContent).text(text);

        var scriptServices = this.getService('ScriptServices');
        scriptServices.showPopup(touchArgs.pageX, touchArgs.pageY, target, this._popupContent);
    },

    _getSvgElementTooltip: function (element)
    {
        var text = null;

        while (element instanceof SVGElement)
        {
            var title = element.firstElementChild;

            if (title != null && title.tagName == 'title')
            {
                text = title.textContent;
                break;
            }

            element = element.parentNode;
        }

        return text;
    },

    _getHtmlElementTooltip: function (element)
    {
        var text = null;

        while (element != null)
        {
            text = $(element).attr('title');

            if (text != null)
            {
                break;
            }

            element = element.parentNode;

            if (element == document.body || $(element).hasClass('Dashboard') == true)
            {
                element = null;
            }
        }

        return text;
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                return this._targetElement;
            },

            set: function (value)
            {
                if (this._targetElement != null)
                {
                    this._detach();
                }

                this._targetElement = value;

                if (this._targetElement != null)
                {
                    this._attach();
                }
            }
        }
    }
});
﻿Dundas.Dashboard.Container = Dundas.Dashboard.Component.extend(
{
    init: function (serviceProvider)
    {
        this._services = null;
        this._components = [];
        this._getServiceDelegate = Dundas.Dashboard.Utility.createDelegate(this.getService, this);

        if (serviceProvider)
        {
            this._services = serviceProvider;
        }
    },

    addComponent: function (component)
    {
        this._components.push(component);
        var site = {};
        site.getService = this._getServiceDelegate;
        site.Container = this;
        component.Site = site;
    },

    removeComponent: function (component)
    {
        var index = this._components.indexOf(component);

        if (index == -1)
        {
            return;
        }

        this._components.splice(index, 1);
        component.Site = null;
    },

    findComponentById: function (id)
    {
        var arr = this._components.filter(function (value)
        {
            return value.UniqueId == id;
        });

        return arr[0];
    },

    getService: function (serviceType)
    {
        var instance = null;

        if (this._services)
        {
            instance = this._services.getService(serviceType);
        }

        if (instance == null)
        {
            instance = this._super(serviceType);
        }

        return instance;
    },

    __properties:
    {
        'Count':
        {
            get: function ()
            {
                return this._components.length;
            }
        }
    }
});
﻿Dundas.Dashboard.ServiceContainer = Class.extend(
{
    init: function ()
    {
        this._services = {};
    },

    addService: function (serviceType, serviceInstance)
    {
        if (this._services[serviceType])
        {
            throw new Error(String.format('Service "{0}" is already registered', serviceType));
        }

        this._services[serviceType] = serviceInstance;
    },

    removeService: function (serviceType)
    {
        delete this._services[serviceType];
    },

    getService: function (serviceType)
    {
        var instance = this._services[serviceType];

        if (!instance)
        {
            instance = null;
        }

        return instance;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.Parameter = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        this._name = null;
        this._grainLevel = null;
        this._filterValues = [];
        this._needsUpdate = false;
    },

    onLoaded: function ()
    {
        var pm = this.getService('ParameterManager');
        pm.registerParameter(this.Name, this);
    },

    InvalidateFilter: function ()
    {
        $(this).trigger('FilterInvalidated');
    },

    clear: function ()
    {
        this.FilterValues.length = 0;
    },

    serialize: function ()
    {
        var data = {};

        if (this.GrainLevel != null)
        {
            data.GrainLevel = this.GrainLevel;
        }

        data.Name = this.Name;
        data.FilterValues = this.FilterValues;

        return data;
    },

    createMemberValue: function (value, readableValue)
    {
        var memberValue = {};

        if (this.isNamedToken(value) == true)
        {
            memberValue.NamedTokenValue = value.Value;
            return memberValue;
        }

        memberValue.Values = [];
        memberValue.ReadableValues = [];

        if (Array.isArray(value) == true)
        {
            memberValue.Values = value;
        }
        else if (value != null)
        {
            if (String.isString(readableValue) == false)
            {
                throw new Error('Readable value must be specified');
            }

            memberValue.Values.push(value);
            memberValue.ReadableValues.push(readableValue);
        }

        return memberValue;
    },

    createFilterValue: function ()
    {
        var filterValue = {};

        filterValue.MemberValues = [];
        filterValue.NamedTokenValue = 0;

        return filterValue;
    },

    addMemberValue: function (memberValue, filterValueIndex)
    {
        if (filterValueIndex == null)
        {
            filterValueIndex = 0;
        }

        var filterValue = this.FilterValues[filterValueIndex];

        if (filterValue == null)
        {
            filterValue = this.createFilterValue();
            this.FilterValues[filterValueIndex] = filterValue;
        }

        filterValue.MemberValues[0] = memberValue;
    },

    setFilterValue: function (filterValue)
    {
        this.FilterValues.length = 0;
        this.FilterValues.push(filterValue);
    },

    setRangeValues: function (startValue, startValueText, endValue, endValueText, isConsolidatedDateTime, dateTimeGrain)
    {
        this.clear();

        if (isConsolidatedDateTime == null)
        {
            isConsolidatedDateTime = false;
        }

        var filterValue = this.createFilterValue();
        filterValue.IsConsolidatedDateTime = isConsolidatedDateTime;
        filterValue.IsRange = true;

        var memberValueStart = this.createMemberValue(startValue, startValueText);

        if (dateTimeGrain != null)
        {
            memberValueStart.DateTimeGrain = dateTimeGrain;
        }
        memberValueStart.Operator = 3;

        var memberValueEnd = this.createMemberValue(endValue, endValueText);
        if (dateTimeGrain != null)
        {
            memberValueEnd.DateTimeGrain = dateTimeGrain;
        }
        memberValueEnd.Operator = 4;

        filterValue.MemberValues.push(memberValueStart);
        filterValue.MemberValues.push(memberValueEnd);

        this.FilterValues.push(filterValue);
    },

    createNamedToken: function (value)
    {
        var token = new Dundas.Dashboard.NamedToken(value);
        return token;
    },

    isNamedToken: function (value)
    {
        return value instanceof Dundas.Dashboard.NamedToken;
    },

    createTypedValue: function (valueType, value)
    {
        var typedValue = {};
        typedValue.__type = 'Dd_tv';
        typedValue.Type = valueType;
        typedValue.Value = value;

        return typedValue;
    },

    __properties:
    {
        'Name':
        {
            get: function ()
            {
                return this._name;
            }
        },

        'FilterValues':
        {
            get: function ()
            {
                return this._filterValues;
            },
            set: function (value)
            {
                this._filterValues = value;
            }
        },

        'GrainLevel':
        {
            get: function ()
            {
                return this._grainLevel;
            },
            set: function (value)
            {
                this._grainLevel = value;
            }
        },

        'NeedsUpdate':
        {
            get: function ()
            {
                return this._needsUpdate;
            },
            set: function (value)
            {
                this._needsUpdate = value;
            }
        }
    }
});

Dundas.Dashboard.NamedToken = function (value)
{
    this.Value = value;
}
﻿Dundas.Dashboard.Service = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        
    },
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardContent = Dundas.Dashboard.Component.extend(
{
    init: function ()
    {
        this._super();
        this._id = null;
        this._name = null;
        this._dataRefreshInterval = null;
        this._dataRefreshTotalInterval = 0;
        this._isPreview = null;
        this._parentDashboardId = null;
        this._resizeMode = null;
        this._dashboardSize = null;
        this._scaleWrapper = null;
        this._windowSize = null;

        this.ScriptManager.registerCurrentDashboard(this);
    },

    onLoaded: function ()
    {
        if (this.IsPreview == true)
        {
            // Hide toolbar in preview mode
            $('body > .Toolbar').hide();
        }

        this._setupDataRefresh();

        this._setupResizeMode();

        this._setupToolbar();
    },

    updateDashboardControls: function (data)
    {
        var controlData = data.Controls;

        if (controlData == null || controlData.length == null)
        {
            return;
        }

        var sm = this.ScriptManager;
        var removedElements = [];
        var tempDiv = document.createElement('div');

        controlData.forEach(this.createDelegate(function (controlInfo)
        {
            var element = $get(controlInfo.Id);

            // If the element we are about to replace has a component, destroy it
            this._disposeElementComponents(sm, element);

            // Replace the element            
            tempDiv.innerHTML = controlInfo.Content;

            element.parentNode.replaceChild(tempDiv.firstChild, element);

            removedElements.push(element);
        }));

        // Remove the elements using jQuery so it will cleanup any data+event handlers held in its global cache
        $(removedElements).remove();

        // Create the new objects
        sm.createMultipleObjects(data.ObjectsToCreate);
    },

    _disposeElementComponents: function (scriptManager, element)
    {
        var component = scriptManager.findComponent(element.id);

        if (component)
        {
            scriptManager.destroyComponent(component);
        }

        Dundas.Dashboard.Interaction.disposeElementInteractions(element);
    },

    _setupDataRefresh: function ()
    {
        if (this._dataRefreshInterval == null)
        {
            return;
        }

        window.setTimeout(this.createDelegate(this._onDataRefreshTimerTick), this._dataRefreshInterval);
    },

    _onDataRefreshTimerTick: function (e)
    {
        this._dataRefreshTotalInterval += this._dataRefreshInterval;

        var sm = this.ScriptManager;
        var updateData = sm.createDashboardUpdateData();
        updateData.onCompleted = null;

        var data = {};
        data.__type = 'Dd_dr';
        data.totalInterval = this._dataRefreshTotalInterval;

        updateData.DataRefreshUpdate = data;

        sm.updateDashboard(updateData, this.createDelegate(this._onDataRefreshUpdateComplete));
    },

    _onDataRefreshUpdateComplete: function (e)
    {
        if (e.data)
        {
            this._dataRefreshInterval = e.data.DataRefresh.nextUpdateInterval;
        }

        this._setupDataRefresh();
    },

    _setupResizeMode: function ()
    {
        if (this._resizeMode == 1)
        {
            this._setupScaleResizeMode();
        }
    },

    _setupScaleResizeMode: function ()
    {
        $(document.body).addClass('Scale');

        this._scaleWrapper = $('body > div:first-child').get(0);
        $(this._scaleWrapper).addClass('ScaleWrapper');

        this._windowSize = {};
        this._windowSize.width = $(window).width();
        this._windowSize.height = $(window).height();

        this._scaleDashboard();

        window.addEventListener('resize', this.createDelegate(this._onWindowResize), true);
    },

    _onWindowResize: function (e)
    {
        var width = $(window).width();
        var height = $(window).height();

        if (this._windowSize.width == width && this._windowSize.height == height)
        {
            return;
        }

        this._windowSize.width = width;
        this._windowSize.height = height;

        this._scaleDashboard();
    },

    _scaleDashboard: function ()
    {
        var scriptServices = this.getService('ScriptServices');

        var dashboardElement = $('> .Dashboard', this._scaleWrapper).get(0);

        var scaledSize = scriptServices._getScaledContentSize(this._dashboardSize, this._windowSize);
        scriptServices._setTransform(dashboardElement, scaledSize, this._dashboardSize);

        var scaledWidth = scaledSize.width;
        var xScale = scaledWidth / this._dashboardSize.width;

        if (scaledWidth < this._windowSize.width)
        {
            $(this._scaleWrapper).width(scaledWidth);
            this._scaleWrapper.removeAttribute('l');

            if (xScale > 1)
            {
                this._scaleWrapper.setAttribute('l2', 1);
            }
            else
            {
                this._scaleWrapper.removeAttribute('l2');
            }
        }
        else
        {
            $(this._scaleWrapper).width('auto');
            this._scaleWrapper.setAttribute('l', 1);
        }
    },

    getDashboardSize: function ()
    {
        var size = {};
        jQuery.extend(size, this._dashboardSize);
        return size;
    },

    _setupToolbar: function ()
    {
        this._setupToolbarCollapse();
        this._setupToolbarVisibility();
    },

    _setupToolbarCollapse: function ()
    {
        var toolbarToggle = document.querySelector('body > .Toolbar .ToolbarToggle');

        var isToolbarCollapsed = Dundas.Dashboard.Utility.getLocalStorageValue('IsToolbarCollapsed');

        toolbarToggle.checked = isToolbarCollapsed != true;

        $(toolbarToggle).bind('change', this.createDelegate(function (e)
        {
            Dundas.Dashboard.Utility.setLocalStorageValue('IsToolbarCollapsed', e.target.checked == false);
        }));
    },

    _setupToolbarVisibility: function ()
    {
        var parentWindow = window.opener || window.parent;

        if (parentWindow == null || window == parentWindow)
        {
            // We're not a child window
            return;
        }

        var dundasDashboardNs = null;

        try
        {
            dundasDashboardNs = parentWindow.Dundas && parentWindow.Dundas.Dashboard;
        }
        catch (ex)
        {
            // Permission denied to access parent window
        }

        // Don't show the toolbar if we're a child window of the html viewer or explorer
        if (dundasDashboardNs != null && (dundasDashboardNs.ScriptManager || dundasDashboardNs.Explorer))
        {
            $('body > .Toolbar').hide();
        }
    },

    __properties:
    {
        'Id':
        {
            get: function ()
            {
                return this._id;
            }
        },

        'Name':
        {
            get: function ()
            {
                return this._name;
            }
        },

        'IsPreview':
        {
            get: function ()
            {
                return this._isPreview == true;
            }
        },

        'ResizeMode':
        {
            get: function ()
            {
                return this._resizeMode;
            }
        },

        'ParentDashboardId':
        {
            get: function ()
            {
                return this._parentDashboardId;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />

Dundas.Dashboard.Interaction = Dundas.Dashboard.Component.extend(
{
    _MOUSE_MOVE_DELAY: 200,

    init: function ()
    {
        this._targetElementId = null;
        this._type = null;
        this._id = null;
        this._targetElement = null;
        this._hoverBehavior = null;
        this._hash = null;
        this._clientFunctionScript = null;
        this._clientFunction = null;
        this._isSimpleShowDashboardPopup = null;
        this._actualBoundEvent = null;
        this._mouseMoveTimeoutDelegate = null;
    },

    onLoaded: function ()
    {
        this._bindToTarget();

        if (this._clientFunctionScript != null)
        {
            this._clientFunction = new Function(this._clientFunctionScript);
        }
    },

    dispose: function ()
    {
        if (this._hoverBehavior != null)
        {
            this._hoverBehavior.TargetElement = null;
            this.ScriptManager.destroyComponent(this._hoverBehavior);
        }

        if (this._actualBoundEvent != null)
        {
            this.unbindEvent(this.TargetElement, this._actualBoundEvent, this._onEventFired);
        }
    },

    _bindToTarget: function ()
    {
        var eventName = null;
        var targetElement = this.TargetElement;

        switch (this._type)
        {
            case 'Click':
                eventName = 'click';

                if ($(targetElement).hasClass('DashboardCheckBox') == true)
                {
                    // The checkbox click event fires before its checked status is changed.  What we
                    // really want is the change event.
                    eventName = 'change';
                }
                break;
            case 'Hover':
                this._bindHoverEvent(targetElement);
                break;
            case 'MouseEnter':
            case 'MouseLeave':
                eventName = this._type.toLowerCase();
                break;
            case 'MouseMove':
                this._bindMouseMoveEvent(targetElement);
                break;
        }

        if (eventName != null)
        {
            this.bindEvent(targetElement, eventName, this._onEventFired);
            this._actualBoundEvent = eventName;
        }

        var data = $(targetElement).data('Dd_Interaction');

        if (data == null)
        {
            data = [];
            $(targetElement).data('Dd_Interaction', data);
        }

        data.push(this);
    },

    _bindHoverEvent: function (targetElement)
    {
        this._hoverBehavior = this.ScriptManager.createObject(Dundas.Dashboard.HoverBehavior);
        this._hoverBehavior.TargetElement = targetElement;
        this.bindEvent(this._hoverBehavior, 'Hover', this._onHover);
    },

    _onHover: function (e, hoverEventArgs)
    {
        this.execute(hoverEventArgs);
    },

    _bindMouseMoveEvent: function (targetElement)
    {
        this.bindEvent(targetElement, 'mousemove', this._onMouseMove);
        this.bindEvent(targetElement, 'mouseleave', this._onMouseLeave);
    },

    _onMouseLeave: function (e)
    {
        this._cancelMouseMoveTimeout();
    },

    _onMouseMove: function (e)
    {
        this._cancelMouseMoveTimeout();

        this._mouseMoveTimeoutDelegate = this.createTimeout(this._onMouseMoveCore, this._MOUSE_MOVE_DELAY);
        this._mouseMoveTimeoutDelegate.args = e;
    },

    _cancelMouseMoveTimeout: function ()
    {
        if (this._mouseMoveTimeoutDelegate != null)
        {
            this._mouseMoveTimeoutDelegate.cancel();
            this._mouseMoveTimeoutDelegate = null;
        }
    },

    _onMouseMoveCore: function ()
    {
        var e = this._mouseMoveTimeoutDelegate.args;
        this._mouseMoveTimeoutDelegate = null;

        this._onEventFired(e);
    },

    _onEventFired: function (e)
    {
        this.execute(e);
    },

    execute: function (e)
    {
        if (this._canExecute(e) == false)
        {
            return;
        }

        if (this._clientFunction != null)
        {
            this._executeClient();
            return;
        }

        var sm = this.ScriptManager;
        var updateData = sm.createDashboardUpdateData();

        this._triggerEventArgs = e;

        var eventData = this._setupEventData(e);

        var interactionExecuteData = {};
        interactionExecuteData.Id = this.Id;
        interactionExecuteData.__type = 'Dd_ie';
        interactionExecuteData.EventData = eventData;

        updateData.InteractionExecute = interactionExecuteData;

        var callback = this.createDelegate(function ()
        {
            if (this._isSimpleShowDashboardPopup == true)
            {
                // If the interaction just shows a popup, start showing the popup now
                var scriptServices = this.getService('ScriptServices');
                scriptServices.ShowDashboardPopup(null, null, e);
            }
        });

        sm.executeInteraction(this, updateData, callback);
    },

    _setupEventData: function (e)
    {
        var eventData = {};
        eventData.__type = 'Dd_cei';
        eventData.customData = {};

        if (e.pageX)
        {
            eventData.pageX = e.pageX;
            eventData.pageY = e.pageY;

            var pos = $(this.TargetElement).offset();
            eventData.clientXPct = (e.pageX - pos.left) / $(this.TargetElement).width();
            eventData.clientYPct = (e.pageY - pos.top) / $(this.TargetElement).height();
        }

        var control = Dundas.Dashboard.Control.fromElement(this.TargetElement);

        if (control != null && control.prepareEventData != null)
        {
            control.prepareEventData(eventData, e);
        }

        return eventData;
    },

    _canExecute: function (executeEventArgs)
    {
        var e = jQuery.Event('BeforeExecute');
        e.cancel = false;
        e.interactionTarget = executeEventArgs.target;
        $(this).trigger(e);

        return e.cancel == false;
    },

    _executeClient: function ()
    {
        var interactionThis = {};
        interactionThis['services'] = this.getService('ScriptServices');

        this._clientFunction.apply(interactionThis);
    },

    isEqual: function (otherInteraction)
    {
        return this._hash == otherInteraction._hash;
    },

    __properties:
    {
        'TargetElement':
        {
            get: function ()
            {
                if (this._targetElement == undefined)
                {
                    this._targetElement = $get(this._targetElementId);
                }

                return this._targetElement;
            }
        },

        'Id':
        {
            get: function ()
            {
                return this._id;
            }
        },

        'EventArgs':
        {
            get: function ()
            {
                return this._triggerEventArgs;
            }
        },

        'Type':
        {
            get: function ()
            {
                return this._type;
            }
        }
    }
});

Dundas.Dashboard.Interaction.disposeElementInteractions = function (element)
{
    var interactions = Dundas.Dashboard.Interaction.getElementInteractions(element);

    if (interactions == null)
    {
        return;
    }

    interactions.forEach(function (e)
    {
        e.ScriptManager.destroyComponent(e);        
    });
};

Dundas.Dashboard.Interaction.getElementInteractions = function (element, type)
{
    var interactions = null;

    if (element)
    {
        interactions = $(element).data('Dd_Interaction');
    }

    if (type != null && Array.isArray(interactions) == true)
    {
        interactions = interactions.filter(function (e) { return e.Type == type; });
    }

    return interactions;
}

﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardPopup = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._element = null;
        this._content = null;
        this._clickAway = null;
        this._trigger = null;
        this._closeOnTriggerMouseLeave = false;
        this._mouseInPopup = false;
        this._layoutValid = false;
        this._actualContent = null;
        this._showClass = null;
    },

    onLoaded: function ()
    {
        this._super();
        this._element = document.createElement('div');
        document.body.appendChild(this._element);
        $(this._element).addClass('DashboardPopup');

        this._content = document.createElement('div');
        $(this._content).addClass('Content');
        this._element.appendChild(this._content);

        this._clickAway = this.ScriptManager.createObject(Dundas.Dashboard.ClickAwayBehavior);
        this.bindEvent(this._clickAway, 'ClickAway', this._onClickAway);

        this._isOpen = false;
        this._height = NaN;
        this._width = NaN;
        this._left = NaN;
        this._top = NaN;
    },

    _computePosition: function (newSize)
    {
        var windowRect = {};
        windowRect.width = Math.min(window.innerWidth, $(window).width());
        windowRect.height = Math.min(window.innerHeight, $(window).height());
        windowRect.left = window.pageXOffset;
        windowRect.top = window.pageYOffset;
        windowRect.right = windowRect.left + windowRect.width;
        windowRect.bottom = windowRect.top + windowRect.height;

        var pos = {};
        var nudge = 10;

        var width = $(this._content).width();
        var height = $(this._content).height();

        if (newSize != null)
        {
            width = newSize.width;
            height = newSize.height;
        }

        if (isNaN(width) && isNaN(height))
        {
            width = 200;
            height = 200;
        }

        pos.left = this.Left + nudge;

        var overflow = (pos.left + width) - windowRect.right;

        if (overflow > 0)
        {
            pos.left = pos.left - overflow - nudge;
        }

        pos.top = this.Top + nudge;

        overflow = (pos.top + height) - windowRect.bottom;

        if (overflow > 0)
        {
            pos.top = pos.top - overflow - nudge;
        }

        return pos;
    },

    _onClickAway: function (e, clickAwayEventArgs)
    {
        if (this.Trigger == clickAwayEventArgs.target || jQuery.contains(this.Trigger, clickAwayEventArgs.target) == true)
        {
            return;
        }

        this.IsOpen = false;
    },

    _onTriggerMouseLeave: function (e)
    {
        if (this.CloseOnTriggerMouseLeave == false)
        {
            return;
        }

        window.setTimeout(this.createDelegate(function ()
        {
            if (this._mouseInPopup == false)
            {
                this.IsOpen = false;
            }
        }), 0);
    },

    _onElementMouseEnter: function (e)
    {
        this._mouseInPopup = true;
    },

    _onElementMouseLeave: function (e)
    {
        this._mouseInPopup = false;

        if (this.CloseOnTriggerMouseLeave == true)
        {
            this.IsOpen = false;
        }
    },

    _loadContent: function ()
    {
        this._clearContent();
        this._content.appendChild(this._actualContent);
    },

    _show: function ()
    {
        if (this._layoutValid == false)
        {
            this.updateLayout();
        }

        this._hookMouseEvents(true);
        $(this._element).addClass('Open');

        $(this._element).addClass(this._showClass);

        this._clickAway.TargetElement = this._element;
    },

    _hide: function ()
    {
        this._clickAway.TargetElement = null;

        this._clearContent();
        this._actualContent = null;
        $(this._element).removeClass('Open');

        $(this._element).removeClass(this._showClass);
        this._showClass = null;

        $(this._element).css({ left: '', top: '' });

        this._hookMouseEvents(false);

        $(this).trigger('Closed');

        this._layoutValid = false;
    },

    _clearContent: function ()
    {
        while (this._content.firstChild != null)
        {
            this._content.removeChild(this._content.firstChild);
        }
    },

    findElement: function (selector)
    {
        return $(selector, this._content).get(0);
    },

    updateLayout: function (newSize)
    {
        var pos = this._computePosition(newSize);

        if (pos != null)
        {
            $(this._element).css({ left: pos.left, top: pos.top });
        }

        this._layoutValid = true;
    },

    _hookMouseEvents: function (hook)
    {
        var scriptManager = this.ScriptManager;

        if (scriptManager.IsTouchBrowser == true)
        {
            return;
        }

        if (hook)
        {
            this.bindEvent(this.Trigger, 'mouseleave', this._onTriggerMouseLeave);
            this.bindEvent(this._element, 'mouseenter', this._onElementMouseEnter);
            this.bindEvent(this._element, 'mouseleave', this._onElementMouseLeave);
        }
        else
        {
            this.unbindEvent(this.Trigger, 'mouseleave', this._onTriggerMouseLeave);
            this.unbindEvent(this._element, 'mouseenter', this._onElementMouseEnter);
            this.unbindEvent(this._element, 'mouseleave', this._onElementMouseLeave);
        }
    },

    __properties:
    {
        'Content':
        {
            get: function ()
            {
                return this._actualContent;
            },

            set: function (value)
            {
                if (this._actualContent == value)
                {
                    return;
                }

                this._actualContent = value;
                this._loadContent();
            }
        },

        'IsOpen':
        {
            get: function ()
            {
                return this._isOpen;
            },

            set: function (value)
            {
                this._isOpen = value;

                if (value === true)
                {
                    this._show();
                }
                else if (value === false)
                {
                    this._hide();
                }
            }
        },

        'Left':
        {
            get: function ()
            {
                return this._left;
            },

            set: function (value)
            {
                this._left = value;
            }
        },

        'Top':
        {
            get: function ()
            {
                return this._top;
            },

            set: function (value)
            {
                this._top = value;
            }
        },

        'Trigger':
        {
            get: function ()
            {
                return this._trigger;
            },

            set: function (value)
            {
                this._trigger = value;
            }
        },

        'CloseOnTriggerMouseLeave':
        {
            get: function ()
            {
                return this._closeOnTriggerMouseLeave;
            },

            set: function (value)
            {
                this._closeOnTriggerMouseLeave = value;
            }
        },

        'ShowClass':
        {
            get: function ()
            {
                return this._showClass;
            },

            set: function (value)
            {
                this._showClass = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardTimer = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._interval = null;
        this._intervalId = null;
        this._isStarted = null;
    },

    onLoaded: function ()
    {
        this._super();

        if (this._isStarted == true)
        {
            this.StartTimer();
        }
    },

    dispose: function ()
    {
        this._clearInterval();

        this._super();
    },

    _onTimerTick: function ()
    {
        var e = {};
        e.target = this;

        this._executeTargetElementInteractions('TimerTick', e);
    },

    StartTimer: function ()
    {
        this._setInterval(this.Interval);
    },

    StopTimer: function ()
    {
        this._setInterval(null);
    },

    _setInterval: function (interval)
    {
        this._clearInterval();

        if (!interval)
        {
            return;
        }

        this._intervalId = window.setInterval(this.createDelegate(this._onTimerTick), interval);
    },

    _clearInterval: function ()
    {
        if (this._intervalId != null)
        {
            window.clearInterval(this._intervalId);
            this._intervalId = null;
        }
    },

    __properties:
    {
        'Interval':
        {
            get: function ()
            {
                return this._interval;
            },

            set: function (value)
            {
                this._interval = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.PanelView = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._element = null;
        this._content = null;
        this._state = null;
    },

    onLoaded: function ()
    {
        this._super();

        this._element = document.createElement('div');
        $(this._element).addClass('PanelView');

        document.body.appendChild(this._element);

        var root = $('body > .Dashboard').get(0);
        this.bindEvent(root, 'webkitTransitionEnd', this._onTransitionEnd);
        this.bindEvent(root, 'transitionend', this._onTransitionEnd);
    },

    show: function ()
    {
        if (this.IsOpen == true)
        {
            return;
        }

        this._state = 'opening';
        this._setRootClass('PanelViewOpening');

        $(this._element).empty().append(this.Content);
    },

    hide: function ()
    {
        if (this.IsOpen == false)
        {
            return;
        }

        this._state = 'closing';
        this._setRootClass('PanelViewClosing');
    },

    _setRootClass: function (className, remove)
    {
        var root = $('body');

        if (!remove)
        {
            root.addClass(className);
        }
        else
        {
            root.removeClass(className);
        }
    },

    _scrollToContent: function ()
    {
        var centerX = ($(window).width() / 2) - window.innerWidth / 2;
        window.scrollTo(centerX, 0);
    },

    _onTransitionEnd: function ()
    {
        if (this._state == 'opening')
        {
            this._onOpened();
        }
        else if (this._state == 'closing')
        {
            this._onClosed();
        }
    },

    _onOpened: function ()
    {
        this._state = 'opened';
        this._setRootClass('PanelViewOpening', true);
        this._setRootClass('PanelViewOpened');

        this._scrollToContent();
        $(this).trigger('Opened');
    },

    _onClosed: function ()
    {
        this._state = 'closed';
        $(this._element).empty();

        this._setRootClass('PanelViewClosing', true);
        this._setRootClass('PanelViewOpened', true);

        $(this).trigger('Closed');
    },

    findElement: function (selector)
    {
        return $(selector, this._element);
    },

    __properties:
    {
        'Content':
        {
            get: function ()
            {
                return this._content;
            },

            set: function (value)
            {
                this._content = value;
            }
        },

        'IsOpen':
        {
            get: function ()
            {
                return this._state == 'opened' || this._state == 'opening';
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DatePicker = Dundas.Dashboard.Control.extend(
{
    Grains:
    {
        NotSet: 0,
        Year: 3,
        Month: 5,
        Day: 7
    },

    init: function ()
    {
        this._super();
        this._selectedDate = null;
        this._trigger = null;
        this._target = null;
        this._element = null;
        this._yearInput = null;
        this._grain = null;
        this._monthCells = null;
        this._dayCells = null;
        this._dayValuesElement = null;
    },

    onLoaded: function ()
    {
        this._super();
    },

    _onTriggerClick: function (e)
    {
        var scriptServices = this.getService('ScriptServices');

        var offset = $(this.Target).offset();
        offset.top += $(this.Target).height();

        if (this._element == null)
        {
            this._initialize();
        }

        this._smartRender();

        scriptServices.showPopup(offset.left, offset.top, this.Trigger, this._element);
    },

    _initialize: function ()
    {
        this._createElement();
        this.SelectedDate = this._makeLocal(this.SelectedDate);
    },

    _smartRender: function ()
    {
        var uiDate = this._getUISelectedDate();
        var selectedDate = this.SelectedDate;

        if (uiDate == null)
        {
            this._render(selectedDate);
            return;
        }

        var isYearChanged = selectedDate.getUTCFullYear() != uiDate.getUTCFullYear();

        if (this.IsYearGrain == true && isYearChanged == true)
        {
            this._renderYear(selectedDate);
        }

        var isMonthChanged = selectedDate.getUTCMonth() != uiDate.getUTCMonth();

        if (this.IsMonthGrain == true && isMonthChanged == true)
        {
            this._renderMonths(selectedDate);
        }

        var isDayChanged = selectedDate.getUTCDate() != uiDate.getUTCDate();

        if (this.IsDayGrain == true && (isYearChanged == true || isMonthChanged == true || isDayChanged == true))
        {
            if (isYearChanged == true || isMonthChanged == true)
            {
                this._renderDays(selectedDate);
            }
            else
            {
                this._setUISelectedDay(selectedDate);
            }
        }
    },

    _createElement: function ()
    {
        this._element = document.createElement('div');

        var model = {};
        model.months = this.ScriptManager.ApplicationConfiguration.MonthShortNames;
        model.days = this.ScriptManager.ApplicationConfiguration.DayShortNames;
        model.getMonth = function (index)
        {
            return this.data.months[index];
        }

        model.getDay = function (index)
        {
            return this.data.days[index];
        }

        Dundas.Dashboard.Utility.applyTemplate('DatePickerTemplate', model, this._element);

        var arr = jQuery.makeArray(this._element.querySelectorAll('[class]'));
        var dict = {};

        arr.forEach(function (e)
        {
            dict[e.className] = e;
        });

        this._yearInput = dict.YearTextbox;
        this.bindEvent(dict.YearTextbox, 'change', this._onYearInputChanged);
        this.bindEvent(dict.YearBack, 'click', this._onYearBack);
        this.bindEvent(dict.YearForward, 'click', this._onYearForward);
        this.bindEvent(dict.Months, 'click', this._onMonthSelected);
        this.bindEvent(dict.DayValues, 'click', this._onDaySelected);

        this._dayValuesElement = dict.DayValues;

        this._setupGrain();
    },

    _setupGrain: function ()
    {
        var grain = this.Grain;

        if (grain == null || grain == this.Grains.NotSet)
        {
            return;
        }

        var grainName;

        for (var name in this.Grains)
        {
            if (this.Grains[name] == grain)
            {
                grainName = name;
                break;
            }
        }

        var datePicker = this._element.querySelector('.DatePicker');
        $(datePicker).addClass(grainName + '_Grain');
    },

    _onYearBack: function ()
    {
        this._onYearIncremented(-1);
    },

    _onYearForward: function ()
    {
        this._onYearIncremented(1);
    },

    _onYearInputChanged: function ()
    {
        var year = +this._yearInput.value;

        if (this._yearInput.value.length == 0 || isNaN(year) == true)
        {
            var date = this.SelectedDate;
            this._setUISelectedYear(date);
        }
        else
        {
            this._onYearSelected(year);
        }
    },

    _onYearIncremented: function (yearOffset)
    {
        var date = this.SelectedDate;
        var year = date.getFullYear() + yearOffset;
        this._onYearSelected(year);
    },

    _onYearSelected: function (year)
    {
        this._setUISelectedYear(year);
        
        var date = new Date(year, this._getUISelectedMonth(), 1);
        this._renderDays(date);

        this._onDateSelected(this.Grains.Year);        
    },

    _onMonthSelected: function (e)
    {
        if ($(e.target).is('label') == true)
        {
            var dayCell = e.target.parentNode;
            var cells = this._getMonthCells();
            var index = cells.indexOf(dayCell);

            this._setUISelectedMonth(index);
            var date = new Date(this._getUISelectedYear(), index, 1);
            this._renderDays(date);

            this._onDateSelected(this.Grains.Month);
        }
    },

    _onDaySelected: function (e)
    {
        if ($(e.target).is('label') == true)
        {
            var monthCell = e.target;
            var day = +monthCell.textContent - 1;

            if (isNaN(day) == true)
            {
                return;
            }

            this._setUISelectedDay(day);
            this._onDateSelected(this.Grains.Day);
        }
    },

    _render: function (date)
    {
        this._renderYear(date);
        this._renderMonths(date);
        this._renderDays(date);
    },

    _renderYear: function (date)
    {
        var year = date.getFullYear();
        this._yearInput.value = year;
    },

    _renderMonths: function (date)
    {
        if (this.IsMonthGrain == false)
        {
            return;
        }

        var month = date.getMonth();

        this._setUISelectedMonth(month);
    },

    _getMonthCells: function ()
    {
        if (this._monthCells == null)
        {
            this._monthCells = jQuery.makeArray(this._element.querySelectorAll('.Months > div > div'));
        }

        return this._monthCells;
    },

    _getSelectedMonthCell: function ()
    {
        return this._element.querySelector('.Months .Selected');
    },

    _getDayCells: function ()
    {
        if (this._dayCells == null)
        {
            this._dayCells = jQuery.makeArray(this._element.querySelectorAll('.DayValues > div > div'));
        }

        return this._dayCells;
    },

    _renderDays: function (date)
    {
        if (this.IsDayGrain == false)
        {
            return;
        }

        var cells = jQuery.makeArray(this._dayValuesElement.getElementsByTagName('label'));

        var index = 0;

        var renderDate = this._cloneDate(date);
        renderDate.setDate(1);

        // Reset the existing cells
        this._clearSelectedDay();

        // Render the days before the 1st of the month
        while (index < renderDate.getDay())
        {
            var cell = cells[index++];
            cell.textContent = '';
        }

        var daysInMonth = this._getDaysInMonth(renderDate);

        // Render the days of the month
        for (var day = 1; day <= daysInMonth; day++)
        {
            renderDate.setDate(day);
            var cell = cells[index++];
            cell.textContent = day.toString();
        }

        // Render the days after the end of the month
        while (index < cells.length)
        {
            cells[index++].textContent = '';
        }

        // Highlight the selected day
        this._setUISelectedDay(date);
    },

    _getUISelectedMonth: function ()
    {
        if (this.IsMonthGrain == false)
        {
            return 0;
        }

        var monthCells = this._getMonthCells();
        var selectedCell = this._getSelectedMonthCell();

        if (selectedCell == null)
        {
            return NaN;
        }

        return monthCells.indexOf(selectedCell);
    },

    _setUISelectedMonth: function (month)
    {
        var monthCells = this._getMonthCells();

        var selectedCell = this._getSelectedMonthCell();
        $(selectedCell).removeClass('Selected');

        $(monthCells[month]).addClass('Selected');
    },

    _setUISelectedDay: function (day)
    {
        var date;

        if (day instanceof Date)
        {
            date = day;
            day = day.getDate() - 1;
        }
        else
        {
            date = this.SelectedDate;
        }

        var date = this._cloneDate(date);
        date.setDate(1);

        day = day + date.getDay();

        this._clearSelectedDay();

        var cells = this._getDayCells();
        $(cells[day]).addClass('Selected');
    },

    _getSelectedDayCell: function ()
    {
        return this._dayValuesElement.querySelector('.Selected');
    },

    _clearSelectedDay: function ()
    {
        var selected = this._getSelectedDayCell();
        $(selected).removeClass('Selected');
    },

    _getUISelectedDay: function ()
    {
        if (this.IsDayGrain == false)
        {
            return 1;
        }

        var cell = this._getSelectedDayCell();

        if (cell == null)
        {
            return NaN;
        }
        else
        {
            cell = cell.querySelector('label');
            return +cell.textContent;
        }
    },

    _getUISelectedYear: function ()
    {
        return parseInt(this._yearInput.value);
    },

    _setUISelectedYear: function (year)
    {
        if (year instanceof Date)
        {
            year = year.getFullYear();
        }

        this._yearInput.value = year;
    },

    _getUISelectedDate: function ()
    {
        var year = this._getUISelectedYear();

        var month = this._getUISelectedMonth();

        var day = this._getUISelectedDay();

        if (isNaN(year) || isNaN(month) || isNaN(day))
        {
            return null;
        }

        return new Date(year, month, day);
    },

    _cloneDate: function (date)
    {
        return new Date(date.getTime());
    },

    _getUTCDate: function (date)
    {
        return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
    },

    _makeLocal: function (date)
    {
        return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate());
    },

    _getDaysInMonth: function (date)
    {
        var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        return d.getDate();
    },

    _onDateSelected: function (selectedGrain)
    {
        var date = this._getUISelectedDate();
        this.SelectedDate = date;

        var e = jQuery.Event('SelectedDateChanged');
        e.selectedDate = this._getUTCDate(date);

        if (selectedGrain == this.Grain)
        {
            var scriptServices = this.getService('ScriptServices');
            scriptServices.hidePopup();
            $(this).trigger(e);
        }
    },

    __properties:
    {
        'Trigger':
        {
            get: function ()
            {
                return this._trigger;
            },

            set: function (value)
            {
                if (this._trigger != null)
                {
                    this.unbindEvent(this._trigger, 'click', this._onTriggerClick);
                }

                this._trigger = value;

                if (this._trigger != null)
                {
                    this.bindEvent(this._trigger, 'click', this._onTriggerClick);
                }
            }
        },

        'Target':
        {
            get: function ()
            {
                return this._target;
            },

            set: function (value)
            {
                this._target = value;
            }
        },

        'SelectedDate':
        {
            get: function ()
            {
                return this._selectedDate;
            },

            set: function (value)
            {
                this._selectedDate = value;
            }
        },

        'Grain':
        {
            get: function ()
            {
                return this._grain;
            },

            set: function (value)
            {
                this._grain = value;
            }
        },

        'IsDayGrain':
        {
            get: function () { return this.Grain >= this.Grains.Day; }
        },

        'IsMonthGrain':
        {
            get: function () { return this.Grain >= this.Grains.Month; }
        },

        'IsYearGrain':
        {
            get: function () { return this.Grain >= this.Grains.Year; }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.HierarchyPicker = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._element = null;
        this._trigger = null;
        this._target = null;
        this._root = null;
        this._rootMembers = null;
        this._selectedNode = null;
        this._selectedNodes = null;
        this._selectedValue = null;
        this._selectedValues = null;
        this._isMultiSelect = false;
        this._firstSelectableLevel = null;
        this._isHidingUnselectableLevels = false;
        this._lastSelectableLevel = null;
        this._lastVisibleLevel = null;
        this._hasAllMember = null;
        this._allIsLevel = null;
    },

    onLoaded: function ()
    {
        this._super();
    },

    _createElement: function ()
    {
        this._element = document.createElement('div');
        $(this._element).addClass('HierarchyPicker');

        this._root = document.createElement('ul');
        this._element.appendChild(this._root);

        if (this.IsMultiSelect == true)
        {
            var closeCommand = document.createElement('button');
            closeCommand.textContent = 'OK';
            closeCommand.className = 'CloseCommand';
            this.bindEvent(closeCommand, 'click', this._onCloseCommandClick);
            this._element.appendChild(closeCommand);
        }

        this.bindEvent(this._root, 'click', this._onNodeClick);

        var startLevel = 0;

        if (this._hasAllMember == false && this._allIsLevel == true)
        {
            startLevel++;
        }
        else if (this._hasAllMember == true && this._allIsLevel == false)
        {
            startLevel--;
        }

        this._renderLevel(this._root, this.RootMembers, startLevel);
        this._expandCollapseNode(this._getRootNode(), true);
    },

    _renderLevel: function (parent, data, levelNumber)
    {
        if (data == null)
        {
            return;
        }

        for (var i = 0; i < data.length; i++)
        {
            var member = data[i];
            this._renderNode(parent, member, levelNumber);
        }
    },

    _canDisplayLevel: function (levelNumber)
    {
        var firstOrdinal = 0;
        var lastOrdinal = this.LastVisibleLevel;
        var allOrdinal = 0;

        if (this.IsHidingUnselectableLevels == true)
        {
            firstOrdinal = this.FirstSelectableLevel;
        }

        if (this._hasAllMember == false)
        {
            allOrdinal = firstOrdinal - 1;
        }
        else if (this._allIsLevel == false)
        {
            allOrdinal--;
        }

        return levelNumber == allOrdinal || (levelNumber >= firstOrdinal && levelNumber <= lastOrdinal);
    },

    _canSelectLevel: function (levelNumber)
    {
        var firstOrdinal = this.FirstSelectableLevel;
        var lastOrdinal = this.LastSelectableLevel;
        var allOrdinal = 0;

        if (this._hasAllMember == false)
        {
            allOrdinal = firstOrdinal - 1;
        }
        else if (this._allIsLevel == false)
        {
            allOrdinal--;
        }

        return levelNumber == allOrdinal || (levelNumber >= firstOrdinal && levelNumber <= lastOrdinal);
    },

    _renderNode: function (parent, data, levelNumber)
    {
        state = {};
        state.isExpanded = false;
        state.level = levelNumber;
        state.loadAsync = data.a != null;
        state.token = data.t;
        state.value = data.v

        if (this._canDisplayLevel(levelNumber) == false && data.c != null)
        {
            this._renderLevel(parent, data.c, levelNumber + 1);

            return;
        }

        var isLeaf = this._canDisplayLevel(levelNumber + 1) == false || (data.c == null && state.loadAsync == false);
        var canSelect = this._canSelectLevel(levelNumber);
        var isSelected = false;
        $(this._selectedValues).each(function ()
        {
            isSelected |= (levelNumber == this.HierarchyLevel && Array.isSequenceEqual(state.value, this.Value)) || (data.t == 3 && this.NamedTokenValue == 3);
        });

        var html = [];

        html.push('<span/>');

        if (this.IsMultiSelect == true && canSelect == true)
        {
            if (isSelected == true)
            {
                html.push('<input type="checkbox" checked="true"/>');
            }
            else
            {
                html.push('<input type="checkbox"/>');
            }
        }

        html.push('<label/>');

        if (isLeaf == false)
        {
            html.push('<ul/>');
        }

        var li = document.createElement('li');
        li.innerHTML = html.join('');

        li.querySelector('label').textContent = data.n;

        if (parent.tagName == 'li')
        {
            parent = parent.querySelector('ul');
        }

        parent.appendChild(li);

        $(li).data('Dd_TreeState', state);

        if (canSelect == false)
        {
            this._disableNode(li);
        }

        if (isSelected)
        {
            if (this.IsMultiSelect == false)
            {
                this._selectNode(li);
            }
            else
            {
                this._onNodeChecked(li);
            }
            this._expandPath(li);
        }

        if (isLeaf == true)
        {
            li.setAttribute('l', '');
        }
        else if (data.c != null)
        {
            this._renderLevel(li, data.c, levelNumber + 1);
        }
    },

    _onCloseCommandClick: function (e)
    {
        var e = jQuery.Event('SelectionChanged');
        var checkBoxes = this._getCheckedCheckboxes();

        if (this.HasAllMember == true)
        {
            var root = this._getRootNode();
            var cb = this._getNodeCheckbox(root);

            if (cb.indeterminate == false)
            {
                this._changeSelectedNode(root);

                this.getService('ScriptServices').hidePopup();

                return;
            }
        }

        if (checkBoxes.length == 0)
        {
            checkBoxes = $('input[checked="true"]', this._root).last().get();
        }
        if (checkBoxes.length == 0)
        {
            return;
        }

        var nodes = [];

        checkBoxes.forEach(function (item)
        {
            nodes.push(item.parentNode);
        });

        e.selectedNodes = nodes;
        this._selectedNodes = nodes;
        this._selectedNode = null;

        $(this).trigger(e);
    },

    _getCheckedCheckboxes: function ()
    {
        var checkboxes = jQuery.makeArray(this._root.querySelectorAll('input:checked'));
        checkboxes = checkboxes.filter(function (item)
        {
            return item.indeterminate == false;
        });

        return checkboxes;
    },

    _onNodeClick: function (e)
    {
        var target = e.target;

        if (target.tagName == 'span')
        {
            this._expandCollapseNode(target.parentNode);
        }
        else if (target.tagName == 'label')
        {
            this._onNodeClicked(target.parentNode);
        }
        else if (target.tagName == 'input')
        {
            this._onNodeChecked(target.parentNode);
        }
    },

    _getNodeCheckbox: function (node)
    {
        return node.childNodes[1];
    },

    _onNodeChecked: function (node)
    {
        var originalNode = node;

        while ((node = this.getParentNode(node)) != null)
        {
            var checkbox = this._getNodeCheckbox(node);
            checkbox.indeterminate = true;
        }

        var isAllCheckbox = this.HasAllMember == true && this._isRootNode(originalNode) == true;
        var childChecked = false;

        var childCheckboxes = $('input', originalNode).get();

        if (childCheckboxes.length == 0)
        {
            return;
        }

        if (isAllCheckbox == true)
        {
            childChecked = childCheckboxes[0].checked;
        }

        childCheckboxes = childCheckboxes.slice(1);

        childCheckboxes.forEach(function (cb)
        {
            cb.checked = childChecked;
            cb.indeterminate = false;
        });
    },

    _onNodeClicked: function (node)
    {
        if (this._isDisabled(node) == true)
        {
            return;
        }
        else if (this.IsMultiSelect == true)
        {
            var checkbox = this._getNodeCheckbox(node);
            checkbox.checked = !checkbox.checked;
            checkbox.indeterminate = false;

            this._onNodeChecked(node);
            return;
        }

        this._changeSelectedNode(node);
    },

    _changeSelectedNode: function (node)
    {
        if (node == this._selectedNode)
        {
            return;
        }

        this._selectedNodes = null;

        var state = this._getNodeState(node);

        var e = jQuery.Event('SelectionChanged');
        e.selectedValue = state.value;
        e.selectedNode = node;

        this._selectNode(node);

        $(this).trigger(e);
    },

    _selectNode: function (node)
    {
        if (this._selectedNode != null)
        {
            $(this._selectedNode).removeClass('Selected');
        }

        if (this.IsMultiSelect == true)
        {
            var checkbox = this._getNodeCheckbox(node);
            checkbox.checked = true;
        }

        this._selectedNode = node;
        $(this._selectedNode).addClass('Selected');
    },

    _disableNode: function (node)
    {
        $(node).addClass('Disabled');
    },

    _isDisabled: function (node)
    {
        return $(node).hasClass('Disabled');
    },

    _expandPath: function (node)
    {
        while ((node = this.getParentNode(node)) != null)
        {
            this._expandCollapseNode(node, true);
        }
    },

    _getNodeState: function (node)
    {
        return $(node).data('Dd_TreeState');
    },

    getNodeValue: function (node)
    {
        var state = this._getNodeState(node);

        var value = null;

        if (state != null)
        {
            value = state.value;
        }

        return value;
    },

    getNodeText: function (node)
    {
        return $('> label', node).text();
    },

    getNodeLevel: function (node)
    {
        var state = this._getNodeState(node);

        var level = 0;

        if (state != null)
        {
            level = state.level;
        }

        return level;
    },

    getParentNode: function (node)
    {
        var parent = node.parentNode;

        if (this._hasAllMember == false && parent == this._root)
        {
            return null;
        }

        if (parent != null && parent.tagName == 'ul')
        {
            parent = parent.parentNode;

            if (parent.tagName != 'li')
            {
                parent = null;
            }
        }

        return parent;
    },

    getNodeToken: function (node)
    {
        return this._getNodeState(node).token;
    },

    _isRootNode: function (node)
    {
        return node == this._getRootNode();
    },

    _getRootNode: function ()
    {
        return this._root.firstChild;
    },

    _expandCollapseNode: function (node, expanded)
    {
        if (node == null || node.hasAttribute('l') == true)
        {
            return;
        }

        var state = this._getNodeState(node);

        if (expanded == null)
        {
            state.isExpanded = !state.isExpanded;
        }
        else
        {
            state.isExpanded = expanded;
        }

        $(node).removeClass('Expanded Collapsed');

        if (state.isExpanded == true)
        {
            $(node).addClass('Expanded');
        }
        else
        {
            $(node).addClass('Collapsed');
        }

        if (state.isExpanded == true && state.loadAsync)
        {
            this._fetchAsyncChildren(node, state);
        }
    },

    _fetchAsyncChildren: function (node, state)
    {
        var e = new jQuery.Event('LoadChildren');
        e.node = node;

        var self = this;

        e.complete = function (error)
        {
            self._onAsyncChildrenFetched(node, e.data, e.level, error);
        }

        state.loadAsync = false;
        $(node).toggleClass('NodeLoading');
        $(this).trigger(e);
    },

    _onAsyncChildrenFetched: function (node, data, level, error)
    {
        $(node).toggleClass('NodeLoading');

        if (error != null)
        {
            return;
        }

        this._renderLevel(node, data, level);
    },

    _onTriggerClick: function (e)
    {
        if (this.Trigger.disabled == true)
        {
            // iPad
            return;
        }

        var scriptServices = this.getService('ScriptServices');

        var offset = $(this.Target).offset();
        offset.top += $(this.Target).height();

        this.ensureRendered();

        scriptServices.showPopup(offset.left, offset.top, this.Trigger, this._element);
    },

    ensureRendered: function ()
    {
        if (this._element == null)
        {
            this._createElement();
        }
    },

    __properties:
    {
        'Trigger':
        {
            get: function ()
            {
                return this._trigger;
            },

            set: function (value)
            {
                if (this._trigger != null)
                {
                    this.unbindEvent(this._trigger, 'click', this._onTriggerClick);
                }

                this._trigger = value;

                if (this._trigger != null)
                {
                    this.bindEvent(this._trigger, 'click', this._onTriggerClick);
                }
            }
        },

        'Target':
        {
            get: function ()
            {
                return this._target;
            },

            set: function (value)
            {
                this._target = value;
            }
        },

        'RootMembers':
        {
            get: function ()
            {
                return this._rootMembers;
            },

            set: function (value)
            {
                this._rootMembers = value;
            }
        },

        'SelectedValue':
        {
            get: function ()
            {
                return this._selectedValue;
            },

            set: function (value)
            {
                this._selectedValue = value;
            }
        },

        'SelectedValues':
        {
            get: function ()
            {
                return this._selectedValues;
            },

            set: function (value)
            {
                this._selectedValues = value;
            }
        },

        'IsMultiSelect':
        {
            get: function ()
            {
                return this._isMultiSelect;
            },

            set: function (value)
            {
                this._isMultiSelect = value;
            }
        },

        'SelectedNode':
        {
            get: function ()
            {
                this.ensureRendered();

                return this._selectedNode;
            }
        },

        'SelectedNodes':
        {
            get: function ()
            {
                this.ensureRendered();

                return this._selectedNodes;
            }
        },

        'FirstSelectableLevel':
        {
            get: function ()
            {
                return this._firstSelectableLevel;
            },

            set: function (value)
            {
                this._firstSelectableLevel = value;
            }
        },

        'IsHidingUnselectableLevels':
        {
            get: function ()
            {
                return this._isHidingUnselectableLevels;
            },

            set: function (value)
            {
                this._isHidingUnselectableLevels = value;
            }
        },

        'LastSelectableLevel':
        {
            get: function ()
            {
                return this._lastSelectableLevel;
            },

            set: function (value)
            {
                this._lastSelectableLevel = value;
            }
        },

        'LastVisibleLevel':
        {
            get: function ()
            {
                return this._lastVisibleLevel;
            },

            set: function (value)
            {
                this._lastVisibleLevel = value;
            }
        },

        'HasAllMember':
        {
            get: function ()
            {
                return this._hasAllMember;
            },

            set: function (value)
            {
                this._hasAllMember = value;
            }
        },

        'AllIsLevel':
        {
            get: function ()
            {
                return this._allIsLevel;
            },

            set: function (value)
            {
                this._allIsLevel = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardDashblockViewer = Dundas.Dashboard.Control.extend(
{
    onLoaded: function ()
    {
        this._super();

        this._iframeElement = $('> iframe', this.TargetElement).get(0);

        if (this._iframeElement == null)
        {
            return;
        }

        this.bindEvent(this._iframeElement, 'load', this._onIframeLoaded);

        this._onIframeLoaded();
    },

    _onIframeLoaded: function ()
    {
        var iframe = this._iframeElement;

        var contentDoc = iframe.contentDocument;

        if (contentDoc == null || contentDoc.body == null || contentDoc.body.hasChildNodes() == false)
        {
            return;
        }

        $(iframe).removeClass('Loading');

        if (contentDoc.querySelector('.Dashboard') == null)
        {
            $(iframe).addClass('Error');
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardDropDownList = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        
        this._ns = null;
    },

    onLoaded: function ()
    {
        this._super();
        this._dropDown = $('> select', this.TargetElement).get(0);

        if (this._ns == true)
        {
            this._dropDown.selectedIndex = -1;
        }

        this.bindEvent(this._dropDown, 'change', this._onDropDownChange);
    },

    _onDropDownChange: function (e)
    {
        this._doControlStateUpdate();
    },

    saveState: function (data)
    {
        data.SelectedIndex = this._dropDown.selectedIndex;
    },

    __properties:
    {
        'SelectedIndex':
        {
            get: function ()
            {
                return this._dropDown.selectedIndex;
            },
            set: function (value)
            {
                this._dropDown.selectedIndex = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardCheckBox = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._control = null;
        this._indeterminate = null;
    },

    onLoaded: function ()
    {
        this._super();
        this._control = $('input', this.TargetElement).get(0);

        if (this._indeterminate != null)
        {
            this._control.indeterminate = true;
        }

        this.bindEvent(this._control, 'change', this._onControlChanged);
    },

    _onControlChanged: function (e)
    {
        var evt = jQuery.Event('Change');
        evt.handled = false;

        $(this).trigger(evt);

        if (evt.handled == true)
        {
            return;
        }

        this._doControlStateUpdate();
    },

    saveState: function (data)
    {
        data.Checked = this._control.checked;
    },

    __properties:
    {
        'SelectedValue':
        {
            get: function ()
            {
                if (this._control.indeterminate == true)
                {
                    return "indeterminate";
                }
                else
                {
                    return this._control.checked;
                }
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardSlider = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._sliderButton = null;
        this._sliderTrack = null;
        this._value = null;
        this._min = null;
        this._max = null;
        this._largeChange = null;
        this._smallChange = null;
        this._snap = null;
        this._isVertical = null;
        this._isTouchBased = false;
        this._disabled = null;
        this._isReversed = null;
        this._browserPicker = null;
    },

    onLoaded: function ()
    {
        this._super();

        this._range = this._max - this._min;

        var useBrowserUI = this._isInputTypeSupported('range', true);

        // Hack to exclude iOS < 5 which has the range input but without a slider control
        useBrowserUI = useBrowserUI && window.Worker != null;

        if (useBrowserUI == true)
        {
            this._setupBrowserPicker();
        }
        else
        {
            this._sliderButton = $('> button', this.TargetElement).get(0);
            this._sliderTrack = $('> .Track', this.TargetElement).get(0);
        }

        this.ScriptManager.registerForMouseEventSetup(this.createDelegate(this._onInitializeMouseEvents));

        this._showValue(this._value);
    },

    _setupBrowserPicker: function ()
    {
        var input = document.createElement('input');
        input.type = 'range';
        input.disabled = this._disabled;
        input.min = this._min;
        input.max = this._max;
        input.step = 'any';
        
        if (this._snap == true)
        {
            input.step = this._smallChange;
        }
        
        input.valueAsNumber = this._value;

        $(this.TargetElement).html(input);

        this._browserPicker = input;
    },

    _onInitializeMouseEvents: function ()
    {
        if (this._disabled == true)
        {
            return;
        }

        var scriptManager = this.ScriptManager;

        this._isTouchBased = scriptManager.IsTouchBrowser;

        if (scriptManager.IsTouchBrowser == false)
        {
            if (this._browserPicker == null)
            {
                this.bindEvent(this._sliderButton, 'mousedown', this._onButtonMouseDown);
            }
            else
            {
                this.bindEvent(this._browserPicker, 'mouseup', this._onInputValueChanged);
                this.bindEvent(this._browserPicker, 'keyup', this._onInputValueChanged);
            }
        }
        else
        {
            if (this._browserPicker == null)
            {
                this.bindEvent(this._sliderButton, 'touchstart', this._onButtonMouseDown);
                this.bindEvent(this._sliderButton, 'touchend', this._onButtonMouseUp);
            }
            else
            {
                this.bindEvent(this._browserPicker, 'touchend', this._onInputValueChanged);
            }
        }

        if (this._browserPicker == null)
        {
            this.bindEvent(this.TargetElement, 'click', this._onTrackClick);
            this.bindEvent(this.TargetElement, 'keyup', this._onKeyUp);
        }
    },

    _onButtonMouseDown: function (e)
    {
        if (e.type == 'mousedown' && e.which != 1)
        {
            return;
        }
        else if (e.type == 'touchstart')
        {
            this._isTouchBased = true;
            e.preventDefault();
        }

        this._hookTempMouseEvents(true);
    },

    _onMouseMove: function (e)
    {
        var pageX = this._getPageXFromEvent(e);

        var value = this._pos2Value(pageX, this._smallChange, this._snap);
        this._showValue(value);
    },

    _onMouseOut: function (e)
    {
        this._onButtonReleased(e);
    },

    _onButtonMouseUp: function (e)
    {
        if (e.type == 'mouseup' && e.which != 1)
        {
            return;
        }

        this._onButtonReleased(e);
    },

    _onButtonReleased: function (e)
    {
        this._hookTempMouseEvents(false);

        var pageX = this._getPageXFromEvent(e);
        var value = this._pos2Value(pageX, this._smallChange, this._snap);
        this._updateValue(value);
    },

    _onTrackClick: function (e)
    {
        if (e.target == this._sliderButton)
        {
            return;
        }

        // Prevent further mouse events from firing on the button
        e.preventDefault();

        var pageX = this._getPageXFromEvent(e);
        var value = this._pos2Value(pageX, this._largeChange, true);

        this._updateValue(value);

        this._sliderButton.focus();
    },

    _onKeyUp: function (e)
    {
        var key = e.which;

        var increment = null;

        switch (key)
        {
            case 33:    // PGUP
                increment = -this._largeChange;
                break;
            case 34:    // PGDOWN
                increment = this._largeChange;
                break;
            case 40:    // DOWN
            case 37:    // LEFT
                increment = -this._smallChange;
                break;
            case 38:    // UP
            case 39:    // RIGHT
                increment = this._smallChange;
                break;
        }

        if (increment == null)
        {
            return;
        }

        var value = this._value + increment;
        value = this._snapValue(value, increment, true);

        this._updateValue(value);
    },

    _onInputValueChanged: function (e)
    {
        var value = this._browserPicker.valueAsNumber;

        value = this._snapValue(value, this._smallChange, this._snap);

        this._updateValue(value);
    },

    _getPageXFromEvent: function (e)
    {
        var touches = e.originalEvent.touches;

        var propName = 'pageX';

        if (this._isVertical == true)
        {
            propName = 'pageY';
        }

        var obj;

        if (touches != null)
        {
            if (touches.length > 0)
            {
                obj = touches[0];
            }
            else
            {
                obj = e.originalEvent.changedTouches[0];
            }
        }
        else
        {
            obj = e;
        }

        return obj[propName];
    },

    _hookTempMouseEvents: function (hook)
    {
        if (hook)
        {
            if (this._isTouchBased == false)
            {
                this.bindEvent(document.body, 'mousemove', this._onMouseMove);
                this.bindEvent(document.body, 'mouseleave', this._onMouseOut);
                this.bindEvent(document.body, 'mouseup', this._onButtonMouseUp);
            }

            this.bindEvent(this.TargetElement, 'touchmove', this._onMouseMove);
        }
        else
        {
            if (this._isTouchBased == false)
            {
                this.unbindEvent(document.body, 'mousemove', this._onMouseMove);
                this.unbindEvent(document.body, 'mouseleave', this._onMouseOut);
                this.unbindEvent(document.body, 'mouseup', this._onButtonMouseUp);
            }

            this.unbindEvent(this.TargetElement, 'touchmove', this._onMouseMove);
        }
    },

    _pos2Value: function (pageX, step, snap)
    {
        var pct = this._getTrackPercentage(pageX);

        pct = Math.max(pct, 0);
        pct = Math.min(pct, 1);

        var value = (pct * this._range) + this._min;

        value = this._snapValue(value, step, snap);

        return value;
    },

    _getTrackPercentage: function (pageX)
    {
        var propName = 'left';

        if (this._isVertical == true)
        {
            propName = 'top';
        }

        var offset = $(this._sliderTrack).offset();
        var clientX = pageX - offset[propName];

        var trackSize = this._getTrackWidth();

        var pct = clientX / trackSize;

        pct = this._adjustTrackPercentage(pct);

        return pct;
    },

    _adjustTrackPercentage: function (pct)
    {
        if (this._isReversed == false)
        {
            if (this._isVertical == true)
            {
                pct = 1 - pct;
            }
        }
        else
        {
            if (this._isVertical == false)
            {
                pct = 1 - pct;
            }
        }

        return pct;
    },

    _getTrackWidth: function ()
    {
        var trackSize;

        if (this._isVertical == true)
        {
            trackSize = $(this._sliderTrack).height();
        }
        else
        {
            trackSize = $(this._sliderTrack).width();
        }

        return trackSize;
    },

    _snapValue: function (value, step, snap)
    {
        if (snap == true && value % step != 0)
        {
            var rem = value % step;

            if (rem < step / 2)
            {
                value = value - rem;
            }
            else
            {
                value = value + (step - rem);
            }
        }

        return value;
    },

    _updateValue: function (value)
    {
        if (value > this._max)
        {
            value = this._max;
        }
        else if (value < this._min)
        {
            value = this._min;
        }

        if (value == this._value)
        {
            return;
        }

        this._showValue(value);
        this._value = value;
        this._onValueChanged();
    },

    _onValueChanged: function ()
    {
        this._doControlStateUpdate();
    },

    _showValue: function (value)
    {
        if (this._browserPicker != null)
        {
            this._browserPicker.valueAsNumber = value;
            return;
        }

        var pct = (value - this._min) / this._range;

        pct = this._adjustTrackPercentage(pct);

        var trackWidth = this._getTrackWidth();
        var pos = trackWidth * pct;

        var propName = 'left';

        if (this._isVertical == true)
        {
            propName = 'top';
        }

        $(this._sliderButton).css(propName, pos);
    },

    saveState: function (data)
    {
        data.Value = this._value;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardTextBox = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
    },

    onLoaded: function ()
    {
        this._super();

        this._textbox = $('> input', this.TargetElement).get(0);

        if (this._textbox == null)
        {
            this._textbox = $('> textarea', this.TargetElement).get(0);
        }

        this.bindEvent(this._textbox, 'change', this._onTextBoxChange);
    },

    _onTextBoxChange: function (e)
    {
        this._doControlStateUpdate();
    },

    saveState: function (data)
    {
        data.Text = this._textbox.value;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardLegend = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();

        this._cb = null;
        this._orientation = null;
    },

    onLoaded: function ()
    {
        this._super();

        if (this._cb == true)
        {
            this.bindEvent(this.TargetElement, 'change', this._onItemChecked);
        }

        var del = this.createDelegate(this._onItemClicked);
        $('.LegendItem', this.TargetElement).click(del);

        this._setupOrientation();
    },

    saveState: function (data)
    {
        var checkboxes = this._getCheckboxes();

        data.LegendItems = checkboxes.map(function (e) { return { IsCheckBoxChecked: e.checked }; });
    },

    prepareEventData: function (data, e)
    {
        var target = e.currentTarget;

        var legendItems = $('.LegendItem', this.TargetElement).get();
        var index = legendItems.indexOf(target);

        data.customData.legendItemIndex = index;
    },

    _setupOrientation: function ()
    {
        switch (this._orientation)
        {
            case 1:
                this._setupVerticalOrientation();
                break;
        }
    },

    _setupVerticalOrientation: function ()
    {
        var legendBody = this.TargetElement.querySelector('.LegendBody');
        var legendBodyInner = this.TargetElement.querySelector('.LegendBodyInner');
        var columnCount = $(legendBodyInner).height() / $(legendBody).height();
        columnCount = Math.ceil(columnCount);

        if (columnCount == 1)
        {
            return;
        }

        var items = legendBody.querySelectorAll('.LegendItem, .Title');
        items = jQuery.makeArray(items);

        var contentWidth = this._getContentWidth(items);

        if (contentWidth < $(legendBody).width())
        {
            this._makeHorizontal();
            return;
        }

        var style = legendBody.style;
        style.MozColumnCount = columnCount;
        style.WebkitColumnCount = columnCount;
        style.columnCount = columnCount;
    },

    _getContentWidth: function (items)
    {
        var widths = items.map(function (e) { return $(e).width(); });

        var total = widths.reduce(function (previousValue, currentValue)
        {
            return previousValue + currentValue;
        });

        return total;
    },

    _makeHorizontal: function ()
    {
        $(this.TargetElement).removeClass('Vertical').addClass('Horizontal');
    },

    _onItemClicked: function (e)
    {
        var target = e.target;

        if (this._cb == true && target.tagName == 'input')
        {
            // Item checkbox doesn't count as an item click
            return;
        }

        var executed = this._executeTargetElementInteractions('LegendItemClick', e);

        if (this._cb == true && executed == true)
        {
            // Prevent the click from going to the checkbox
            e.preventDefault();
        }
    },

    _onItemChecked: function (e)
    {
        var index = this._getCheckedItemIndex(e);

        if (index == -1)
        {
            return;
        }

        this._doControlStateUpdate();
    },

    _getCheckboxes: function ()
    {
        var checkboxes = $('input[type=checkbox]', this.TargetElement).get();
        return checkboxes;
    },

    _getCheckedItemIndex: function (e)
    {
        var checkboxes = this._getCheckboxes();
        var index = checkboxes.indexOf(e.target);

        return index;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardDataGrid = Dundas.Dashboard.Control.extend(
{
    onLoaded: function ()
    {
        this._super();
        this._headers = null;
        this._rowsNumbered = false;
        this._stripNonDigitsRegex = /[^\d-]/g;

        var rowGroup = this.TargetElement.querySelector('table > tbody > tr.RowGroup');

        if (rowGroup == null)
        {
            this._setupSorting();
        }

        this._setupInteractions();

        if (rowGroup != null)
        {
            this.bindEvent(this.TargetElement, 'click', this._onRowGroupToggleClick);
        }
    },

    _setupInteractions: function ()
    {
        var interactions = Dundas.Dashboard.Interaction.getElementInteractions(this.TargetElement);

        if (interactions == null)
        {
            return;
        }

        interactions.forEach(this.createDelegate(function (interaction)
        {
            this.bindEvent(interaction, 'BeforeExecute', this._onBeforeInteractionExecute);
        }));
    },

    prepareEventData: function (eventData, e)
    {
        this._numberRows();

        var table = $('> table', this.TargetElement);
        var td = e.target;

        if ($(td).is('td') == false)
        {
            td = $(td).parents('td').get(0);
        }

        var row = td.parentNode;
        var cells = $('td', row).get();

        eventData.tableCellRow = row.o;
        eventData.tableCellColumn = cells.indexOf(td);
    },

    _onBeforeInteractionExecute: function (e)
    {
        var target = e.interactionTarget;
        e.cancel = true;

        // Cancel the hover interaction if the trigger is a header cell or a row group
        while (target != this.TargetElement)
        {
            if (target.tagName == 'tr')
            {
                e.cancel = target.parentNode.tagName == 'thead' || $(target).hasClass('RowGroup') == true;
                break;
            }

            target = target.parentNode;
        }
    },

    _setupSorting: function ()
    {
        var table = this.TargetElement;
        this._headers = $('thead th', table).get();

        var thead = $('thead', table).get(0);

        if (thead != null)
        {
            this.bindEvent(thead, 'click', this._onHeaderClick);
        }
    },

    _numberRows: function ()
    {
        if (this._rowsNumbered == true)
        {
            return;
        }

        var rows = $('> table > tbody > tr', this.TargetElement).get();
        var index = 0;

        rows.forEach(function (row)
        {
            row.o = index++;
        });

        this._rowsNumbered = true;
    },

    _onHeaderClick: function (e)
    {
        var th = e.target;

        if (th.getAttribute('ns') != null)
        {
            return;
        }

        this._numberRows();

        this._sort(th);
    },

    _sort: function (th)
    {
        var index = this._headers.indexOf(th);

        var sortFunc = this._getSortFunction(th);

        if (sortFunc == null)
        {
            return;
        }

        var sortDirection = $(th).data('SortDir');

        if (sortDirection == null)
        {
            sortDirection = -1;
        }

        // Flip the sort direction
        sortDirection = -sortDirection;

        var tbody = $('> table > tbody', this.TargetElement).get(0);

        // Get the cells for the target column
        var columnCells = tbody.querySelectorAll(String.format('tr > td:nth-child({0})', index + 1));
        // Convert to a real array
        columnCells = Array.prototype.slice.call(columnCells);

        // Sort
        columnCells.sort(sortFunc);

        if (sortDirection < 0)
        {
            columnCells.reverse();
        }

        var frag = document.createDocumentFragment();
        $(tbody).hide();

        // Re-insert the rows
        columnCells.forEach(function (cell)
        {
            frag.appendChild(cell.parentNode);
        });

        tbody.appendChild(frag);
        $(tbody).show();

        // Save the sort direction
        $(th).data('SortDir', sortDirection);

        // Show the sort direction
        this._setSortDirectionClass(th, sortDirection);
    },

    _getSortFunction: function (th)
    {
        var columnType = th.getAttribute('t');

        var func = null;

        switch (columnType)
        {
            case 's':
                func = this._sortStringValue;
                break;
            case 'n':
                func = this._sortNumericValue;
                break;
            case 'd':
                func = this._sortDateValue;
                break;
        }

        if (func != null)
        {
            func = this.createDelegate(func);
        }

        return func;
    },

    _setSortDirectionClass: function (th, sortDirection)
    {
        $(this._headers).removeClass('SortDesc').removeClass('SortAsc');

        if (sortDirection > 0)
        {
            $(th).addClass('SortAsc');
        }
        else
        {
            $(th).addClass('SortDesc');
        }
    },

    _sortStringValue: function (x, y)
    {
        return x.textContent.localeCompare(y.textContent);
    },

    _sortDateValue: function (x, y)
    {
        var valX = x.r;
        var valY = y.r;

        if (valX == null)
        {
            valX = Date.parse(x.textContent);
            x.r = valX;
        }

        if (valY == null)
        {
            valY = Date.parse(y.textContent);
            y.r = valY;
        }

        return valX - valY;
    },

    _sortNumericValue: function (x, y)
    {
        var valX = x.r;
        var valY = y.r;

        if (valX == null)
        {
            valX = parseFloat(x.textContent.replace(this._stripNonDigitsRegex, ''));
            x.r = valX;
        }

        if (valY == null)
        {
            valY = parseFloat(y.textContent.replace(this._stripNonDigitsRegex, ''));
            y.r = valY;
        }

        return valX - valY;
    },

    _onRowGroupToggleClick: function (e)
    {
        var target = e.target;

        if (target.tagName != 'tr')
        {
            target = $(target).parents('tr.RowGroup').get(0);
        }

        if ($(target).is('tr.RowGroup') == false)
        {
            return;
        }

        $(target).toggleClass('Collapsed');

        var table = this.TargetElement.querySelector('table');
        var isTableCollapsed = +table.hasAttribute('c');

        var isCollapsed = +$(target).hasClass('Collapsed');

        var children = this._getRowChildren(target);

        this._setRowsVisibility(children, isCollapsed, isTableCollapsed);
    },

    _setRowsVisibility: function (rows, isCollapsed, isTableCollapsed)
    {
        if (rows == null)
        {
            return;
        }

        for (var i = 0; i < rows.length; i++)
        {
            var row = rows[i];
            var currentCollapsed = row.getAttribute('c');

            if (currentCollapsed == null)
            {
                currentCollapsed = isTableCollapsed;
            }
            else
            {
                currentCollapsed = +currentCollapsed;
            }

            if (currentCollapsed != isCollapsed)
            {
                row.setAttribute('c', isCollapsed);
            }

            var children = this._getRowChildren(row);

            if (children != null)
            {
                var childIsCollapsed = isCollapsed;

                if (isCollapsed == false)
                {
                    childIsCollapsed = +$(row).hasClass('Collapsed');
                }

                this._setRowsVisibility(children, childIsCollapsed, isTableCollapsed);
            }
        }
    },

    _getRowChildren: function (row)
    {
        var children;
        var depth = this._getRowDepth(row) + 1;

        while ((row = row.nextElementSibling) != null)
        {
            var siblingDepth = this._getRowDepth(row);

            if (siblingDepth < depth)
            {
                break;
            }
            else if (siblingDepth > depth)
            {
                continue;
            }

            if (children == null)
            {
                children = [];
            }

            children.push(row);
        }

        return children;
    },

    _getRowDepth: function (row)
    {
        return +row.getAttribute('d');
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.DashboardMap = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();

        this._currentZoom = 1;
        this._contentRootElement = null;
        this._zoomOutButton = null;
        this._zoomInButton = null;
        this._lastMousePoint = null;
        this._offset = { x: 0, y: 0 };
        this._isDragging = false;
        this._mousePanEnabled = null;
        this._mouseWheelZoomEnabled = null;
        this._mouseWheelZoomPercent = null;
        this._contentSize = null;
    },

    onLoaded: function ()
    {
        this._super();

        var zoomButtons = $('> .ZoomPanel > button', this.TargetElement).get();

        this._zoomOutButton = zoomButtons[0];

        if (this._zoomOutButton != null)
        {
            this.bindEvent(this._zoomOutButton, 'click', this._onZoomOutClick);
        }

        this._zoomInButton = zoomButtons[1];

        if (this._zoomInButton != null)
        {
            this.bindEvent(this._zoomInButton, 'click', this._onZoomInClick);
        }

        var viewportRoot = $('#ViewportRoot', this.TargetElement).get(0);

        if (viewportRoot == null)
        {
            return;
        }

        this._contentRootElement = $('#ContentRootElement', viewportRoot).get(0);
        this._contentSize = $('> #BorderElement > rect', viewportRoot).get(0).getBoundingClientRect();

        this._setupInteractions();

        if (this._mouseWheelZoomEnabled == true)
        {
            this.bindEvent(this.TargetElement, 'DOMMouseScroll', this._onContentMouseWheel);
            this.bindEvent(this.TargetElement, 'mousewheel', this._onContentMouseWheel);
        }

        this.ScriptManager.registerForMouseEventSetup(this.createDelegate(this._onInitializeMouseEvents));
    },

    _onInitializeMouseEvents: function ()
    {
        if (this._mousePanEnabled == false)
        {
            return;
        }

        var scriptManager = this.ScriptManager;

        if (scriptManager.IsTouchBrowser == false)
        {
            this.bindEvent(this.TargetElement, 'mousedown', this._onContentMouseDown);
        }
        else
        {
            this.bindEvent(this.TargetElement, 'touchstart', this._onContentTouchStart);
        }
    },

    _onContentMouseWheel: function (e)
    {
        var delta;

        var originalEvent = e.originalEvent;

        if (e.type == 'DOMMouseScroll')
        {
            delta = -originalEvent.detail / 3;
        }
        else
        {
            delta = originalEvent.wheelDelta / 120;
        }

        if (delta > 0)
        {
            this._doZoom(this._mouseWheelZoomPercent);
        }
        else if (delta < 0)
        {
            this._doZoom(-this._mouseWheelZoomPercent);
        }

        e.preventDefault();
    },

    _onContentTouchStart: function (e)
    {
        if (e.originalEvent.touches.length != 2)
        {
            return;
        }

        this._startDrag(e);

        this.bindEvent(this.TargetElement, 'touchmove', this._onContentTouchMove);
        this.bindEvent(this.TargetElement, 'touchend', this._onContentTouchEnd);

        e.preventDefault();
    },

    _onContentMouseDown: function (e)
    {
        if (e.which != 1)
        {
            return;
        }

        this._startDrag(e);

        this.bindEvent(this.TargetElement, 'mousemove', this._onContentMouseMove);
        this.bindEvent(this.TargetElement, 'mouseup', this._onContentMouseUp);
        this.bindEvent(this.TargetElement, 'mouseleave', this._onContentMouseLeave);
    },

    _onContentMouseMove: function (e)
    {
        this._doDragMove(e);
    },

    _onContentTouchMove: function (e)
    {
        this._doDragMove(e);
    },

    _doDragMove: function (e)
    {
        var pos = this._getPosFromEventArgs(e);

        var delta = { x: pos.x - this._lastMousePoint.x, y: pos.y - this._lastMousePoint.y };
        this._offset.x += delta.x;
        this._offset.y += delta.y;

        this._lastMousePoint = pos;

        this._updateTransform();
    },

    _onContentMouseUp: function (e)
    {
        if (e.which != 1)
        {
            return;
        }

        this._finishDrag();
    },

    _onContentMouseLeave: function (e)
    {
        this._finishDrag();
    },

    _onContentTouchEnd: function (e)
    {
        this._finishDrag();
    },

    _finishDrag: function ()
    {
        this._isDragging = false;

        this.unbindEvent(this.TargetElement, 'mousemove', this._onContentMouseMove);
        this.unbindEvent(this.TargetElement, 'mouseup', this._onContentMouseUp);
        this.unbindEvent(this.TargetElement, 'mouseleave', this._onContentMouseLeave);

        this.unbindEvent(this.TargetElement, 'touchmove', this._onContentTouchMove);
        this.unbindEvent(this.TargetElement, 'touchend', this._onContentTouchEnd);
    },

    _setupInteractions: function ()
    {
        var interactions = Dundas.Dashboard.Interaction.getElementInteractions(this.TargetElement);

        if (interactions == null)
        {
            return;
        }

        interactions.forEach(this.createDelegate(function (interaction)
        {
            this.bindEvent(interaction, 'BeforeExecute', this._onBeforeInteractionExecute);
        }));
    },

    _onBeforeInteractionExecute: function (e)
    {
        if (this._isDragging == true)
        {
            e.cancel = true;
            return;
        }

        // Only execute interaction if it's for a viewport path child
        var viewportRoot = $('#ViewportRoot', this.TargetElement).get(0);
        var target = e.interactionTarget;

        e.cancel = jQuery.contains(viewportRoot, target) == false || target.parentNode.id == 'BorderElement';
    },

    prepareEventData: function (eventData)
    {
        var data = this._computeTransform();

        // Re-adjust the client co-ordinates based on our offset & zoom
        eventData.clientX = (eventData.clientX - data.x) / data.zoom;
        eventData.clientY = (eventData.clientY - data.y) / data.zoom;
    },

    _onZoomInClick: function ()
    {
        this._doZoom(this._mouseWheelZoomPercent);
    },

    _onZoomOutClick: function ()
    {
        this._doZoom(-this._mouseWheelZoomPercent);
    },

    _doZoom: function (percent)
    {
        this._currentZoom *= 1 + (percent / 100);
        this._updateTransform();
    },

    _computeTransform: function ()
    {
        var zoom = this._currentZoom;

        var width = this._contentSize.width;
        var height = this._contentSize.height;

        var x = ((-this._offset.x + width) * zoom) / 2 - width / 2;
        var y = ((-this._offset.y + height) * zoom) / 2 - height / 2;

        x = -x;
        y = -y;

        var data = {};
        data.zoom = zoom;
        data.x = x;
        data.y = y;

        return data;
    },

    _updateTransform: function ()
    {
        var data = this._computeTransform();

        var transform = String.format('translate({1},{2}) scale({0})', data.zoom, data.x, data.y);
        $(this._contentRootElement).attr('transform', transform);
    },

    _startDrag: function (e)
    {
        this._isDragging = true;
        this._lastMousePoint = this._getPosFromEventArgs(e);
    },

    _getPosFromEventArgs: function (e)
    {
        var touches = e.originalEvent.touches;
        var pos = null;

        if (touches != null)
        {
            if (touches.length == 0)
            {
                touches = e.originalEvent.changedTouches;
            }

            var touch = touches[0];
            pos = { x: touch.pageX, y: touch.pageY };
        }
        else
        {
            pos = { x: e.pageX, y: e.pageY };
        }

        return pos;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jQuery.js" />

Dundas.Dashboard.ParameterControl = Dundas.Dashboard.Control.extend(
{
    init: function ()
    {
        this._super();
        this._dashboardParameter = undefined;
        this._dashboardParameterName = null;
        this._supressRegister = null;
        this._updateType = null;
    },

    onLoaded: function ()
    {
        this._super();
    },

    _invalidateParameter: function()
    {
        var param = this.DashboardParameter;

        if(param == null)
        {
            return;
        }

        if(this._updateType == 0)
        {
            param.InvalidateFilter();
        }
        else
        {
            param.NeedsUpdate = true;
        }
    },

    __properties:
    {
        'DashboardParameter':
        {
            get: function ()
            {
                if (this._dashboardParameter === undefined)
                {
                    this._dashboardParameter = this.ParameterManager.findParameter(this.DashboardParameterName);
                }

                return this._dashboardParameter;
            }
        },

        'DashboardParameterName':
        {
            get: function ()
            {
                return this._dashboardParameterName;
            },
            set: function (value)
            {
                this._dashboardParameterName = value;
            }
        },

        'ParameterManager':
        {
            get: function ()
            {
                return this.getService('ParameterManager');
            }
        }
    }
});
﻿/// <reference path="jquery.js" />
/// <reference path="Utility.js" />

Dundas.Dashboard.ScriptManager = {};

Dundas.Dashboard.ScriptManager.Instance = new function ScriptManager()
{
    this._rootServices = new Dundas.Dashboard.ServiceContainer();
    this._rootContainer = new Dundas.Dashboard.Container(this._rootServices);
    this._dashboard = null;
    this._scriptState;
    this._parameterState;
    this._idCounter = 0;
    this._pendingRequest = null;
    this._isTouchBrowser = null;
    this._errorStatusTimeoutId = null;

    // Amount of time (in seconds) to wait when sending an ajax request before we show the spinner
    this.LOADING_OVERLAY_DELAY = 0.5;

    Dundas.Dashboard.Utility.createProperty(this, 'RootServices', function () { return this._rootServices; });
    Dundas.Dashboard.Utility.createProperty(this, 'RootContainer', function () { return this._rootContainer; });
    Dundas.Dashboard.Utility.createProperty(this, 'Dashboard', function () { return this._dashboard; });
    Dundas.Dashboard.Utility.createProperty(this, 'IsTouchBrowser', function () { return this._isTouchBrowser; });

    this._initialize = function ()
    {
        this._loadServices();

        this._coreSetup();

        var scriptData = Dundas.Dashboard._scriptData;

        if (scriptData == null)
        {
            return;
        }

        delete Dundas.Dashboard._scriptData;

        this.createMultipleObjects(scriptData.ObjectsToCreate);

        // Run onLoad client interactions if there was any.
        if (scriptData.ScriptServicesCalls)
        {
            var scriptServices = this.getService('ScriptServices');
            scriptServices.processScriptServicesCalls(scriptData.ScriptServicesCalls, null);
        }

        if (scriptData.Errors)
        {
            var errorInfo = scriptData.Errors[0];

            if (errorInfo)
            {
                this._showError(errorInfo);
            }
        }

        this._scriptState = scriptData.ScriptState;
        this._parameterState = scriptData.ParameterState;

        $(this).trigger('LoadComplete');

        if (this._isHistorySupported() == true)
        {
            $(window).bind('popstate', this.createDelegate(this._onHistoryPop));
        }
    }

    this._loadServices = function ()
    {
        var service = this.createObject(Dundas.Dashboard.ScriptServices);
        this.addService('ScriptServices', service);

        service = this.createObject(Dundas.Dashboard.ParameterManager);
        this.addService('ParameterManager', service);

        service = this.createObject(Dundas.Dashboard.ExportManager);
        this.addService('ExportManager', service);
    }

    this._coreSetup = function ()
    {
        this._setupForPageUnload();
        this._hookBodyTouch();
        this._setupAjaxProgress();
        this._setupMobileTooltip();
    }

    this._setupForPageUnload = function ()
    {
        window.addEventListener('beforeunload', this.createDelegate(this._abortPendingRequest), true);
    },

    this._hookBodyTouch = function ()
    {
        var self = this;

        var handler = function (e)
        {
            self._isTouchBrowser = e.type == 'touchstart';

            document.body.removeEventListener('touchstart', arguments.callee, true);
            document.body.removeEventListener('mousemove', arguments.callee, true);
            document.body.removeEventListener('mousedown', arguments.callee, true);

            document.body.setAttribute('inputMode', self._isTouchBrowser ? 'touch' : 'mouse');

            $(self).trigger('FirstInputEvent');

            // This is a one-time event so kill any other listeners
            $(self).unbind('FirstInputEvent');
        };

        document.body.addEventListener('touchstart', handler, true);
        document.body.addEventListener('mousemove', handler, true);
        document.body.addEventListener('mousedown', handler, true);
    }

    this._setupMobileTooltip = function ()
    {
        var tooltip = this.createObject(Dundas.Dashboard.TooltipBehavior);
        tooltip.TargetElement = window.self.document.body;
    },

    this._setupAjaxProgress = function ()
    {
        var timeoutId = null;
        var delay = this.LOADING_OVERLAY_DELAY;
        var sm = this;

        var loadingOverlay = $('body > .LoadingOverlay').get(0);

        $(document.body).ajaxSend(function (e, jqXHR, options)
        {
            var e = jQuery.Event('BeforeAjaxSend');
            e.suppressAjaxProgress = false;

            if (options.ddOptions.suppressAjaxProgress == true)
            {
                e.suppressAjaxProgress = true;
            }

            $(sm).trigger(e);

            if (e.suppressAjaxProgress == true)
            {
                return;
            }

            // Show the progress display if no one objects

            timeoutId = window.setTimeout(function ()
            {
                // Center overlay in viewport
                var left = window.innerWidth / 2 + window.pageXOffset;
                var top = window.innerHeight / 2 + window.pageYOffset;

                $('> .Spinner', loadingOverlay).css('left', left).css('top', top);
                $(loadingOverlay).show();
            }, delay * 1000);
        });

        var onAjaxComplete = function ()
        {
            this._pendingRequest = null;
            window.clearTimeout(timeoutId);
            $(loadingOverlay).hide();
        }

        $(document.body).ajaxComplete(this.createDelegate(onAjaxComplete));

        $(document.body).ajaxError(function (e, jqxhr, settings, exception)
        {
            onAjaxComplete();
        });
    }

    this.registerCurrentDashboard = function (dashboard)
    {
        this._dashboard = dashboard;
    }

    this.registerForMouseEventSetup = function (handler)
    {
        if (this.IsTouchBrowser != null)
        {
            handler();
        }
        else
        {
            $(this).bind('FirstInputEvent', handler);
        }
    },

    this.createObject = function (objectType, parameters)
    {
        var type = this._resolveType(objectType);

        if (type == null)
        {
            throw new Error(String.format('Cannot create object: unknown type {0}', objectType));
        }

        var instance = new type();
        instance.UniqueId = this._idCounter++;

        if (parameters != null)
        {
            this._loadParameters(instance, parameters);
        }

        this.addComponent(instance);

        return instance;
    }

    this.createMultipleObjects = function (createInfos)
    {
        if (createInfos == null)
        {
            return;
        }

        createInfos.forEach(this.createDelegate(function (createInfo)
        {
            this.createObject(createInfo.Type, createInfo.Parameters);
        }));
    }

    this.destroyComponent = function (instance)
    {
        if (instance.dispose)
        {
            instance.dispose();
        }

        this.removeComponent(instance);
    }

    this._loadParameters = function (instance, parameters)
    {
        var dateFields = instance.__df;

        if (dateFields != null)
        {
            dateFields.forEach(function (key)
            {
                parameters[key] = Dundas.Dashboard.Utility.parseISO8601Date(parameters[key]);
            });
        }

        for (var propName in parameters)
        {
            if (instance[propName] !== undefined)
            {
                var value = parameters[propName];
                instance[propName] = value;
            }
        }
    }

    this._updateClientState = function (updateData)
    {
        if (updateData.ScriptState != null)
        {
            this._scriptState = updateData.ScriptState;
        }

        if (updateData.ParameterState != null)
        {
            this._parameterState = updateData.ParameterState;
        }
    }

    this._resolveType = function (type)
    {
        if (String.isString(type) == false)
        {
            return type;
        }

        var ns = Dundas.Dashboard;

        if (ns[type] != null)
        {
            return ns[type];
        }

        var parts = type.split('.');
        var currentObject = window;

        jQuery.each(parts, function (index, part)
        {
            currentObject = currentObject[part];

            if (!currentObject)
            {
                return false;
            }
        });

        return currentObject || null;
    }

    this.findComponent = function (componentName)
    {
        var element = $get(componentName);

        if (element)
        {
            return Dundas.Dashboard.Control.fromElement(element);
        }

        var pm = this.getService('ParameterManager');

        return pm.findParameter(componentName);
    }

    this.addComponent = function (component)
    {
        this.RootContainer.addComponent(component);
    }

    this.removeComponent = function (component)
    {
        this.RootContainer.removeComponent(component);
    }

    this.addService = function (serviceType, serviceInstance)
    {
        this.RootServices.addService(serviceType, serviceInstance);
    }

    this.getService = function (serviceType)
    {
        return this.RootServices.getService(serviceType);
    }

    this.createAppRelativeUrl = function (path, queryParameters, mergeQueryString)
    {
        /// <summary>
        /// Creates a url to an application resource.        
        /// </summary>    
        ///	<param name="path" type="string">
        /// The name of the resource eg: Page.aspx
        /// </param>
        ///	<param name="queryParameters" type="object">
        /// An object that contains the parameters to be placed in the query string.
        /// </param>
        ///	<param name="mergeQueryString" type="bool">
        /// If true, the queryParameters will be merged with the current query string.  Otherwise, the current query string will be replaced.
        /// </param>
        /// <returns type="string" />

        var location = window.location;

        var query;

        if (mergeQueryString)
        {
            // Parse the current query parameters
            var currentQueryParameters = this._parseQueryString();

            // Serialize and deserialize them (this lets us have the right values if jQuery does deep serialization)
            query = this.serializeQueryParameters(queryParameters);
            queryParameters = this._parseQueryString(query);

            // Merge the two objects
            jQuery.extend(currentQueryParameters, queryParameters);

            // Serialize the parameters to string
            query = this.serializeQueryParameters(currentQueryParameters);
        }
        else
        {
            // Serialize the parameters to string
            query = this.serializeQueryParameters(queryParameters);
        }

        // Figure out the path
        if (path)
        {
            // We were given a path so prepend the app root
            path = String.format("{0}/{1}", this.ApplicationConfiguration.ApplicationRoot, path);
            // Replace multiple '/'s with just one
            path = path.replace(/\/{2,}/, '/');
        }
        else
        {
            // No path so use the current one
            path = location.pathname;
        }

        if (path.length > 0 && path[0] != '/')
        {
            // Prepend slash
            path = '/' + path;
        }

        // Create and return the url
        var sep = query ? '?' : '';
        var url = String.format("{0}//{1}{2}{3}{4}", location.protocol, location.host, path, sep, query);

        return url;
    }

    this._parseQueryString = function (query)
    {
        // Use the current query string if none was given
        query = query || window.location.search;

        if (query[0] == '?')
        {
            // Remove leading '?'
            query = query.substr(1);
        }

        var obj = {};

        if (query.length == 0)
        {
            return obj;
        }

        var parts = query.split('&');

        parts.forEach(function (value)
        {
            // Split to key and value
            var parts2 = value.split('=');

            if (parts2.length != 2)
            {
                return;
            }

            var key = parts2[0];
            key = unescape(key);

            var keyValue = parts2[1];
            keyValue = unescape(keyValue);

            obj[key] = keyValue;
        });

        return obj;
    }

    this.navigateToAppUrl = function (path, queryParameters, mergeQueryString, isHistoryBlocked)
    {
        /// <summary>
        /// Navigates to an application resource.        
        /// </summary>    
        ///	<param name="path" type="string">
        /// The name of the resource eg: Page.aspx
        /// </param>
        ///	<param name="queryParameters" type="object">
        /// An object that contains the parameters to be placed in the query string.
        /// </param>
        ///	<param name="mergeQueryString" type="bool">
        /// If true, the queryParameters will be merged with the current query string.  Otherwise, the current query string will be replaced.
        /// </param>
        ///	<param name="isHistoryBlocked" type="bool">
        /// Informs the navigation event not to put this navigation into the history of the browser.
        /// </param>

        var url = this.createAppRelativeUrl(path, queryParameters, mergeQueryString);
        this.navigateToUrl(url, isHistoryBlocked);
    }

    this.navigateToUrl = function (url, isHistoryBlocked)
    {
        if (isHistoryBlocked == true)
        {
            window.location.replace(url);
        }
        else
        {
            window.location.href = url;
        }
    }

    this.serializeQueryParameters = function (queryParameters, shallowSerialize)
    {
        var s = '';

        if (queryParameters)
        {
            if (String.isString(queryParameters))
            {
                // Value is a string so just return it back
                s = queryParameters;
            }
            else
            {
                s = jQuery.param(queryParameters, shallowSerialize);
            }
        }

        return s;
    }

    this.updateDashboard = function (data, callback)
    {
        var onCompleted = this.createDelegate(this._onDashboardUpdated, this);
        data.onCompleted = callback;

        this.sendDashboardJsonUpdateRequest(data, onCompleted);
    }

    this.logout = function ()
    {
        var completedHandler = this.createDelegate(function (e)
        {
            if (e.error != null)
            {
                return;
            }

            $(document.documentElement).html(e.data.Result);
        });

        var options = this.createJsonUpdateData(null, 2, completedHandler);
        this.sendServiceRequest(null, options);
    }

    this.getStateData = function ()
    {
        var data = {};
        data.DashboardId = this.Dashboard.Id;
        data.ParameterState = this._parameterState;
        data.ScriptState = this._scriptState;
        return data;
    }

    this._onDashboardUpdated = function (e)
    {
        if (e.error == null)
        {
            this._doDashboardUpdate(e);
            var evt = jQuery.Event('UpdateComplete');
            evt.dashboardUpdateData = e.data;
            evt.updateTriggerInteraction = this._updateTriggerInteraction;
            $(this).trigger(evt);
        }

        this._completeDashboardUpdate(e);
    }

    this._doDashboardUpdate = function (e)
    {
        var data = e.data;

        if (data == null)
        {
            return;
        }

        this._processStyles(data);
        this.Dashboard.updateDashboardControls(data);

        var scriptServices = this.getService('ScriptServices');

        this._updateClientState(data);

        if (data.Errors)
        {
            // Response is OK but server sent some non-fatal errors
            var error = data.Errors[0];
            this._showError(error);
        }
    }

    this._processStyles = function (e)
    {
        var styles = e.Styles;

        if (styles == null)
        {
            return;
        }

        var stylesheet = document.styleSheets[document.styleSheets.length - 1];
        var rules = stylesheet.cssRules || stylesheet.rules;

        styles.forEach(this.createDelegate(function (pair)
        {
            var css = pair.Item2;
            var selector = pair.Item1;

            // Add an empty rule so we can get the browser's version of the selector
            this._appendStyleRule(stylesheet, rules, selector, '');
            var rule = rules[rules.length - 1];
            selector = rule.selectorText;

            // Remove the temp rule and any existing rule for the same selector and add the new one
            stylesheet.deleteRule(rules.length - 1);
            this._deleteSelectorRule(stylesheet, rules, selector);
            this._appendStyleRule(stylesheet, rules, selector, css);
        }));
    }

    this._appendStyleRule = function (stylesheet, rules, selector, rule)
    {
        if (stylesheet.insertRule)
        {
            stylesheet.insertRule(selector + '{' + rule + '}', rules.length);
        }
        else
        {
            stylesheet.addRule(selector, rule, -1);
        }
    }

    this._deleteSelectorRule = function (stylesheet, rules, selector)
    {
        var index = -1;

        for (var i = 0; i < rules.length; i++)
        {
            var rule = rules[i];

            if (rule.selectorText == selector)
            {
                index = i;
                break;
            }
        }

        if (index != -1)
        {
            stylesheet.deleteRule(index);
        }
    }

    this._completeDashboardUpdate = function (e)
    {
        if (e.error != null)
        {
            this._updateTriggerInteraction = null;
            return;
        }

        if (this._pendingRequest != null)
        {
            var callback = this._pendingRequest.options.ddOptions.onCompleted;

            if (callback != null)
            {
                callback(e);
            }
        }

        // Clear the trigger interaction on a delay so that we prevent any further events coming in from firing
        window.setTimeout(this.createDelegate(function ()
        {
            this._updateTriggerInteraction = null;
        }), 1000);
    }

    this._showError = function (errorInfo)
    {
        var model = {};
        model.Title = errorInfo.Title || 'An error has occurred';
        model.Message = errorInfo.Message;
        model.Details = errorInfo.Details;

        var target = $('body > .ScriptErrorDialog > div').get(0);
        var container = $(target).parent();

        $(target).empty();
        $(document).unbind('keyup', this._onCloseErrorDialog);

        Dundas.Dashboard.Utility.applyTemplate('ErrorDialogTemplate', model, target);

        $(container).show();

        var okCommand = $('#OkCommand', target);

        $(okCommand).click(this._onCloseErrorDialog);
        $(document).keyup(this._onCloseErrorDialog);
    }

    this._showErrorStatus = function (errorInfo)
    {
        var model = {};
        model.Title = errorInfo.Title || 'An error has occurred';
        model.Message = errorInfo.Message;
        model.Details = errorInfo.Details;

        var target = $('body > .ScriptErrorStatus > div').get(0);
        var container = $(target).parent();

        $(target).empty();

        Dundas.Dashboard.Utility.applyTemplate('ErrorStatusTemplate', model, target);

        $(container).show();

        var okCommand = $('#OkCommand', target);
        $(okCommand).click(this._onCloseErrorStatus);

        var detailsCommand = $('#DetailsCommand', target);
        $(detailsCommand).click({ info: errorInfo }, this.createDelegate(this._onErrorStatusDetails));

        if (this._errorStatusTimeoutId != null)
        {
            window.clearTimeout(this._errorStatusTimeoutId);
        }

        this._errorStatusTimeoutId = window.setTimeout(this.createDelegate(this._onCloseErrorStatus), 60000);
    }

    this._onCloseErrorDialog = function (e)
    {
        if (e.type == 'keyup' && e.which != 27)
        {
            return;
        }

        var target = $('body > .ScriptErrorDialog > div').get(0);
        var container = $(target).parent();

        $(container).hide();
        $(target).empty();
    }

    this._onCloseErrorStatus = function (e)
    {
        var target = $('body > .ScriptErrorStatus > div').get(0);
        var container = $(target).parent();

        $(container).hide();
        $(target).empty();
    }

    this._onErrorStatusDetails = function (e)
    {
        this._onCloseErrorStatus();
        this._showError(e.data.info);
    }

    this._base64Encode = function (string)
    {
        return Dundas.Dashboard.Utility.base64Encode(string);
    }

    this.sendDashboardJsonUpdateRequest = function (data, onCompleted)
    {
        var options = this.createJsonUpdateData(data, 3, onCompleted);

        this.sendServiceRequest(null, options);
    }

    this.createJsonUpdateData = function (data, ajaxRequestType, onCompleted)
    {
        var options = {};
        options.dataType = 'json';

        if (data != null)
        {
            options.data = JSON.stringify(data);
        }

        options.processData = false;
        options.type = 'POST';
        options.contentType = 'application/json';
        options.completedHandler = onCompleted;

        options.ddOptions = {};
        options.ddOptions.ajaxRequestType = ajaxRequestType;
        options.ddOptions.suppressAjaxProgress = false;
        options.ddOptions.isExclusive = true;

        if (data != null)
        {
            options.ddOptions.onCompleted = data.onCompleted;
        }

        return options;
    }

    this.createGenericOperationData = function (operation, operationData)
    {
        var data = {};
        data.__type = 'Dd_god';
        data.Operation = operation;
        data.Data = operationData;

        return data;
    }

    this.createDashboardUpdateData = function ()
    {
        var data = {};
        data.DashboardId = this.Dashboard.Id;

        if (this.Dashboard.IsPreview == true)
        {
            data.IsPreview = true;
        }

        data.ParentDashboardId = this.Dashboard.ParentDashboardId;

        data.__type = 'Dd_du';
        data.ScriptState = this._scriptState;
        data.ParameterState = this._parameterState;

        return data;
    }

    this.sendServiceRequest = function (serviceHandler, options)
    {
        if (this._pendingRequest != null && options.ddOptions.isExclusive == true)
        {
            // We already have a pending request so ignore.
            return;
        }

        var url = this.createAppRelativeUrl(serviceHandler);
        options.url = url;

        var e = {};
        e.error = null;

        var onError = function (XMLHttpRequest, textStatus, errorThrown)
        {
            if (XMLHttpRequest.status == 0 && textStatus == 'abort')
            {
                // Request was aborted; skip error handling                
                return;
            }

            e.error = { responseText: XMLHttpRequest.responseText, thrownError: errorThrown };
            e.handled = false;

            options.completedHandler(e);
            // Check if it's a realtime refresh
            if (this._getIsRealTimeRefreshPending())
            {
                // Invoke the callback so the refresh is resumed after an unsuccessful one
                options.ddOptions.onCompleted(e);
            }

            if (e.handled == false)
            {
                this._showDashboardUpdateUnhandledError(XMLHttpRequest, textStatus, errorThrown);
            }
        };

        var onSuccess = function (data, textStatus, XMLHttpRequest)
        {
            e.data = data;
            options.completedHandler(e);
        };

        var onBeforeSend = function (jqXHR, settings)
        {
            this._pendingRequest.xhr = jqXHR;
        };

        options.headers = { 'X-Dd-AjaxRequest': options.ddOptions.ajaxRequestType };

        options.error = this.createDelegate(onError);
        options.success = this.createDelegate(onSuccess);
        options.beforeSend = this.createDelegate(onBeforeSend);

        this._pendingRequest = {};
        this._pendingRequest.options = options;

        $.ajax(options);
    }

    this._showDashboardUpdateUnhandledError = function (XMLHttpRequest, textStatus, errorThrown)
    {
        var errorInfo = this._getKnownErrorInfo(XMLHttpRequest, textStatus, errorThrown);

        if (errorInfo == null)
        {
            errorInfo = this._getUnknownErroInfo(XMLHttpRequest, textStatus, errorThrown);
        }

        // Detect real time refresh failure and show a status instead of an error
        if (this._getIsRealTimeRefreshPending())
        {
            this._showErrorStatus(errorInfo);
        }
        else
        {
            this._showError(errorInfo);
        }
    },

    this._getIsRealTimeRefreshPending = function ()
    {
        if (this._pendingRequest != null
            && this._pendingRequest.options
            && this._pendingRequest.options.data
            && this._pendingRequest.options.data.indexOf('Dd_dr') != -1
            && this._pendingRequest.options.data.indexOf('DataRefreshUpdate') != -1)
        {
            return true;
        }
        else
        {
            return false;
        }
    },

    this._getUnknownErroInfo = function (XMLHttpRequest, textStatus, errorThrown)
    {
        var errorInfo = {};
        errorInfo.Message = 'The dashboard update failed';

        var details;

        if (window.navigator.onLine == false)
        {
            details = "The web browser is currently in offline mode or there is no available network connection";
        }
        else if (XMLHttpRequest.status == 0 && textStatus == "error" && errorThrown == '')
        {
            details = "There was no response from the web server";
        }
        else
        {
            details = String.format("Status Code:{0}\nText Status:{1}\nError:{2}", XMLHttpRequest.status, textStatus, errorThrown);
        }

        errorInfo.Details = details;

        return errorInfo;
    },

    this._getKnownErrorInfo = function (XMLHttpRequest, textStatus, errorThrown)
    {
        // Response had a non-OK status code
        var data = XMLHttpRequest.responseText;

        try
        {
            data = JSON.parse(data);
        }
        catch (ex)
        {
            // Some other error we can't handle
            return null;
        }

        var errorInfo = null;

        if (data.Errors && data.Errors.length > 0)
        {
            errorInfo = data.Errors[0];
        }

        return errorInfo;
    },

    this._abortPendingRequest = function ()
    {
        if (this._pendingRequest != null)
        {
            this._pendingRequest.xhr.abort();
        }
    }

    this.createDelegate = function (func, context)
    {
        if (context == null)
        {
            context = this;
        }

        return Dundas.Dashboard.Utility.createDelegate(func, context);
    },

    this.getScriptState = function ()
    {
        return this._scriptState;
    },

    this.executeInteraction = function (interaction, updateData, onExecuted)
    {
        if (this._canExecuteInteraction(interaction) == false)
        {
            return;
        }

        this._updateTriggerInteraction = interaction;

        if (onExecuted != null)
        {
            onExecuted();
        }

        this.updateDashboard(updateData);
    },

    this._canExecuteInteraction = function (interaction)
    {
        return this._updateTriggerInteraction == null || this._updateTriggerInteraction.isEqual(interaction) == false;
    }

    this.getBrowserFeature = function (featureName)
    {
        switch (featureName)
        {
            case 'IsSmallScreenDevice':
                return window.screen.width < 500 && window.screen.height < 500;
            default:
                return null;
        }
    }

    this.pushHistory = function (owner, data, replace)
    {
        if (this._isHistorySupported() == false)
        {
            return;
        }

        var ownerId = owner.UniqueId;

        if (ownerId == null)
        {
            throw new Error("Component must have an id");
        }

        data.ownerId = ownerId;

        if (replace == true)
        {
            window.history.replaceState(data, '', '');
        }
        else
        {
            window.history.pushState(data, '', '');
        }
    }

    this._onHistoryPop = function (e)
    {
        var state = e.originalEvent.state;

        if (state == null || state.ownerId == null)
        {
            return;
        }

        var owner = this.RootContainer.findComponentById(state.ownerId);

        if (owner == null)
        {
            return;
        }

        owner.onHistoryPop(state);
    }

    this._isHistorySupported = function ()
    {
        return window.history != null && window.history.pushState != null;
    }

    $(document).ready(this.createDelegate(this._initialize));
};

﻿Dundas.Dashboard.ScriptServices = Dundas.Dashboard.Service.extend(
{
    init: function ()
    {
        this._super();        
        this._popup = null;
        this._panelView = null;
        this._triggerInteraction = null;
        this._isPopupPendingForInteraction = false;
        this._scriptServicesOperation = null;

        this.bindEvent(this.ScriptManager, 'BeforeAjaxSend', this._onBeforeAjaxSend);
        this.bindEvent(this.ScriptManager, 'UpdateComplete', this._onDashboardUpdateComplete);
    },

    _onBeforeAjaxSend: function (e)
    {
        if (this._isPopupPendingForInteraction == true)
        {
            // We will show progress using the popup so we don't need the global progress display
            e.suppressAjaxProgress = true;
        }
    },

    _onDashboardUpdateComplete: function (e)
    {
        var scriptServicesCalls = null;

        if (e.dashboardUpdateData != null)
        {
            scriptServicesCalls = e.dashboardUpdateData.ScriptServicesCalls;
        }

        var updateTriggerInteraction = e.updateTriggerInteraction;
        this.processScriptServicesCalls(scriptServicesCalls, updateTriggerInteraction);
    },

    processScriptServicesCalls: function (data, triggerInteraction)
    {
        if (data == null)
        {
            // The interaction didn't generate any script services calls to execute            
            if (this._isPopupPendingForInteraction == true)
            {
                this._isPopupPendingForInteraction = false;
                this._handleNoContentPopup();
            }

            return;
        }

        this._triggerInteraction = triggerInteraction;

        try
        {
            this._executeScriptServiceCalls(data);
        }
        finally
        {
            this._triggerInteraction = null;
            this._isPopupPendingForInteraction = false;
        }
    },

    _executeScriptServiceCalls: function (data)
    {
        var self = this;

        data.forEach(function (callInfo)
        {
            var methodName = callInfo.Name;
            var args = callInfo.Arguments;
            var func = self[methodName];

            if (func == null)
            {
                throw new Error(String.format('Unknown script services method: "{0}"', methodName));
            }

            func.apply(self, args);
        });
    },

    NavigateToUrl: function (url, target, features)
    {
        try
        {
            window.open(url, target, features);           
        }
        catch (ex)
        {
            var errorInfo = {};
            errorInfo.Title = "Failed to navigate to url";
            errorInfo.Message = ex.message;
            errorInfo.Details = ex.toString();
            this.ScriptManager._showError(errorInfo);
        }
    },

    _setScriptServicesOperationCallback: function (callback)
    {
        this._scriptServicesOperation = callback;
    },

    NavigateToDashboard: function (dashboardId, parameters, isBrowserPopup)
    {
        var params = { Dd_ContentId: dashboardId };

        if (parameters != null)
        {
            params.Dd_Parameters = parameters;
        }

        var eventArgs = {};
        if (this._scriptServicesOperation != null)
        {
            eventArgs.operation = 'NavigateToDashboard';
            eventArgs.data = { dashboardId: dashboardId, params: params };

            this._scriptServicesOperation(eventArgs);
        }

        this.ScriptManager.navigateToAppUrl(null, params, null, eventArgs.isHistoryBlocked);
    },

    ShowMessage: function (message, caption)
    {
        alert(message);
    },

    ShowDashboardDialog: function (dashboardId, parameters, features, isCentered)
    {
        var queryParams = {};
        queryParams.Dd_ContentId = dashboardId;

        if (parameters != null)
        {
            queryParams.Dd_Parameters = parameters;
        }

        if (isCentered == true)
        {
            var screen = window.screen;
            features.left = screen.availWidth / 2 - features.width / 2;
            features.top = screen.availHeight / 2 - features.height / 2;
        }

        var url = this.ScriptManager.createAppRelativeUrl(null, queryParams);

        var arr = [];

        for (var key in features)
        {
            var value = features[key];
            arr.push(key + '=' + value);
        }

        var featuresStr = arr.join(',');

        this.NavigateToUrl(url, '_blank', featuresStr);
    },

    ShowDashboardPopup: function (dashboardId, element, eventArgs)
    {
        var actualArgs = this._getActualArguments(arguments, eventArgs);

        if (this.ScriptManager.getBrowserFeature('IsSmallScreenDevice') == true)
        {
            // We're on a small screen device so show a small screen friendly popup
            this._showSmallScreenDashboardPopup(dashboardId, actualArgs);
        }
        else
        {
            this._showRegularPopup(dashboardId, actualArgs);
        }

        this._isPopupPendingForInteraction = dashboardId == null;
    },

    LogoutCurrentUser: function ()
    {
        var sm = this.ScriptManager;

        window.setTimeout(function ()
        {
            sm.logout();
        }, 0);
    },

    ShowPrintDialog: function ()
    {
        window.setTimeout(function ()
        {
            window.print();
        }, 0);
    },

    ShowExportWizard: function (dashboard, defaultSelectedDashboardControls, defaultSelectedExportPluginName)
    {
        this.dispatch(function ()
        {
            var exportManager = this.getService('ExportManager');
            exportManager.exportStart(defaultSelectedDashboardControls);
        });
    },

    showPopup: function (left, top, trigger, content)
    {
        this._ensurePopupElement();

        this._popup.Left = left;
        this._popup.Top = top;
        this._popup.Trigger = trigger;
        this._popup.Content = content;
        this._popup.CloseOnTriggerMouseLeave = false;

        if (this._popup.IsOpen == true)
        {
            this._popup.updateLayout();
        }
        else
        {
            this._popup.IsOpen = true;
        }
    },

    _ensurePopupElement: function ()
    {
        if (this._popup == null)
        {
            this._popup = this.ScriptManager.createObject(Dundas.Dashboard.DashboardPopup);
        }
    },

    hidePopup: function ()
    {
        if (this._popup == null)
        {
            return;
        }

        this._popup.IsOpen = false;
    },

    _hidePanelView: function ()
    {
        if (this._panelView == null)
        {
            return;
        }

        this._panelView.hide();
    },

    _createPopupContent: function (dashboardId, actualArgs)
    {
        var content = document.createElement('iframe');

        if (dashboardId != null)
        {
            content.src = this._getPopupIFrameSource(dashboardId, actualArgs);
        }

        var container = document.createElement('div');
        container.appendChild(content);

        this._sizeContent(container, actualArgs.width, actualArgs.height);

        $(container).addClass('Loading');

        return container;
    },

    _sizeContent: function (content, width, height)
    {
        var explicitSize = {};

        // If the popup call specifies an explicit size, pass it on to the content
        if (+width > 0 && isNaN(+width) == false)
        {
            $(content).width(width);
            explicitSize.width = width;
        }

        if (+height > 0 && isNaN(+height) == false)
        {
            $(content).height(height);
            explicitSize.height = height;
        }

        if (explicitSize.height)
        {
            $(content).data('explicitSize', { width: explicitSize.width, height: explicitSize.height });
        }
    },

    _getPopupIFrameSource: function (dashboardId, actualArgs)
    {
        var queryParams = {};
        queryParams.Dd_ContentId = dashboardId;

        if (actualArgs.parameters != null)
        {
            queryParams.Dd_Parameters = actualArgs.parameters;
        }

        var src = null;

        // Set the source after the iframe is in the dom
        src = this.ScriptManager.createAppRelativeUrl(null, queryParams);

        return src;
    },

    _canShowRegularPopup: function ()
    {
        if (this._isPopupPendingForInteraction == true)
        {
            if (this._popup.IsOpen == false)
            {
                // The popup is no longer open; user probably dismissed it
                return false;
            }

            var content = this._getPopupContentElement();

            if (content == null)
            {
                // Popup no longer has our script services popup content; it's probably been re-appropriated by some other component
                return false;
            }
        }

        return true;
    },

    _showRegularPopup: function (dashboardId, actualArgs)
    {
        this._ensurePopupElement();

        if (this._canShowRegularPopup() == false)
        {
            return;
        }

        var eventArgs;

        // Discard the server event args and use the real client-side ones
        if (this._triggerInteraction)
        {
            eventArgs = this._triggerInteraction.EventArgs;
        }
        else
        {
            eventArgs = actualArgs.eventArgs;
        }

        var currentPopupIFrame = this._popup.findElement('iframe');

        if (this._popup.IsOpen == true && this._popup.Trigger === eventArgs.target)
        {
            if (this._isPopupPendingForInteraction == true)
            {
                // We're showing an empty popup from a previous call, just update the iframe source
                this._isPopupPendingForInteraction == false;

                var src = this._getPopupIFrameSource(dashboardId, actualArgs);
                $(currentPopupIFrame).attr('src', src);

                var content = this._getPopupContentElement();

                // If the popup call specifies an explicit size, pass it on to the content
                if (isNaN(actualArgs.width) == false && isNaN(actualArgs.height) == false)
                {
                    $(content).data('explicitSize', { width: actualArgs.width, height: actualArgs.height });
                }
            }

            // Don't do anything since we are showing and being triggered by the same element            
            return;
        }

        this._popup.Left = eventArgs.pageX;
        this._popup.Top = eventArgs.pageY;

        this._popup.Trigger = eventArgs.target;

        // If the popup was triggered by a mouse event, close the popup when the mouse leaves the trigger elememnt
        this._popup.CloseOnTriggerMouseLeave = eventArgs.type == 'mousemove';

        var content = this._createPopupContent(dashboardId, actualArgs);
        var iframe = $('> iframe', content).get(0);

        this.bindEvent(iframe, 'load', this.createDelegate(function ()
        {
            if (iframe.contentDocument.body.hasChildNodes() == false)
            {
                return;
            }

            var iframeDashboard = this._getIFrameDashboard(iframe);
            var content = this._getPopupContentElement();
            var isResizeableDashboard = iframeDashboard.style['width'] == '100%';

            $(content).removeClass('Loading');

            // Has the iframe's content loaded yet?
            if (iframeDashboard != null)
            {
                // Get the specified size of the popup and the actual content size
                var explicitSize = $(content).data('explicitSize');
                var contentSize = this._getPopupDashboardSize(iframe, iframeDashboard, isResizeableDashboard);

                if (explicitSize == null)
                {
                    // If no explicit size was given, then auto size to the content
                    explicitSize = contentSize;
                }
                else if (isResizeableDashboard == false)
                {
                    // If the dashboard is not resizable, uniformly scale the content to match the explicit size
                    var scaledSize = this._getScaledContentSize(contentSize, explicitSize);

                    $(iframe).width(contentSize.width).height(contentSize.height);

                    this._setTransform(iframe, scaledSize, contentSize);

                    explicitSize = scaledSize;
                }

                this._popup.updateLayout(explicitSize);

                $(content).width(explicitSize.width).height(explicitSize.height);
            }
            else
            {
                // Something else loaded
                $(content).addClass('NoDashboard');
            }
        }));

        if (iframe.src == null || iframe.src.length == 0)
        {
            var loadingSize = { width: 200, height: 200 };
            this._popup.updateLayout(loadingSize);
        }

        this._popup.ShowClass = 'ScriptServices';
        this._popup.Content = content;
        this._popup.IsOpen = true;
    },

    _getPopupDashboardSize: function (iframe, dashboard, isResizeableDashboard)
    {
        var win = iframe.contentWindow;
        var dashboard = win.Dundas.Dashboard.ScriptManager.Instance.Dashboard;

        var size = dashboard.getDashboardSize();

        return size;
    },

    _getPopupContentElement: function ()
    {
        return content = this._popup.findElement('> div');
    },

    _getScaledContentSize: function (contentSize, targetSize)
    {
        var aspectRatio = contentSize.width / contentSize.height;
        var targetAspectRatio = targetSize.width / targetSize.height;

        var scaledSize = {};

        if (aspectRatio > targetAspectRatio)
        {
            scaledSize.width = contentSize.width * (targetSize.width / contentSize.width);
            scaledSize.height = scaledSize.width / aspectRatio;
        }
        else
        {
            scaledSize.height = contentSize.height * (targetSize.height / contentSize.height);
            scaledSize.width = scaledSize.height * aspectRatio;
        }

        return scaledSize;
    },

    _setTransform: function (element, scaledSize, contentSize)
    {
        var transform = String.format('scale({0},{1})', scaledSize.width / contentSize.width, scaledSize.height / contentSize.height);

        var css = { 'MozTransform': transform, 'webkitTransform': transform, 'msTransform': transform };
        $(element).css(css);
    },

    _showSmallScreenDashboardPopup: function (dashboardId, actualArgs)
    {
        if (this._panelView == null)
        {
            this._panelView = this.ScriptManager.createObject(Dundas.Dashboard.PanelView);
        }

        if (this._isPopupPendingForInteraction == true)
        {
            var currentPopupIFrame = this._panelView.findElement('iframe');
            // We're showing an empty popup from a previous call, just update the iframe source
            var src = this._getPopupIFrameSource(dashboardId, actualArgs);

            $(currentPopupIFrame).attr('src', src);

            return;
        }

        var content = this._createPopupContent(dashboardId, actualArgs);
        var iframe = $('> iframe', content).get(0);

        this.bindEvent(iframe, 'load', this.createDelegate(function ()
        {
            var iframeDashboard = this._getIFrameDashboard(iframe);

            if (iframeDashboard != null)
            {
                // The iframe loading makes a history entry so we have to replace it with ours
                this._pushPanelViewHistoryState(true);
                $(content).removeClass('Loading');
            }
        }));

        this._setNormalHistoryState();
        this._pushPanelViewHistoryState();

        this._panelView.Content = content;
        this._panelView.show();
    },

    _setNormalHistoryState: function ()
    {
        var state = { state: 'Normal', scrollPos: { x: window.pageXOffset, y: window.pageYOffset} };
        this.ScriptManager.pushHistory(this, state, true);
    },

    _pushPanelViewHistoryState: function (replace)
    {
        var state = {};
        state.state = 'ShowPanelView';

        this.ScriptManager.pushHistory(this, state, replace);
    },

    _handleNoContentPopup: function ()
    {
        if (this.ScriptManager.getBrowserFeature('IsSmallScreenDevice') == true)
        {
            this._hidePanelView();
        }
        else
        {
            this.hidePopup();
        }
    },

    onHistoryPop: function (state)
    {
        if (state.state == 'Normal')
        {
            this._hidePanelView();
        }
    },

    _getIFrameDashboard: function (iFrame)
    {
        var dashboard = null;

        if (iFrame.contentDocument != null)
        {
            var body = iFrame.contentDocument.body;
            dashboard = body.querySelector('.Dashboard');
        }

        return dashboard;
    },

    _getActualArguments: function (originalArguments, eventArgs)
    {
        var args = {};
        args.eventArgs = eventArgs;
        var width, height, parameters;

        switch (originalArguments.length)
        {
            case 3:
                parameters = originalArguments[2];
            case 4:
                parameters = originalArguments[3];
            case 5:
                parameters = originalArguments[2];
            case 7:
                width = originalArguments[3];
                height = originalArguments[4];
                break;
            case 6:
                parameters = originalArguments[3];
            case 8:
                width = originalArguments[4];
                height = originalArguments[5];
                parameters = originalArguments[3];
                break;
            default:
                width = NaN;
                height = NaN;
        }

        args.width = width;
        args.height = height;
        args.parameters = parameters;

        return args;
    },

    FindControl: function (controlName)
    {
        var element = $get(controlName);
        return Dundas.Dashboard.Control.fromElement(element);
    },

    __properties:
    {
        'CurrentDashboard':
        {
            get: function ()
            {
                return this.ScriptManager.Dashboard;
            }
        },

        'Popup':
        {
            get: function ()
            {
                return this._popup;
            }
        }
    }
});

﻿/// <reference path="Utility.js" />
/// <reference path="jQuery.js" />

Dundas.Dashboard.ParameterManager = Dundas.Dashboard.Service.extend(
{
    init: function ()
    {
        this._super();
        this._dashboardParameter = null;
        this._dashboardParameterName = null;
        this._parameters = {};
    },

    registerParameter: function (parameterName, parameterInstance)
    {
        if (!this._parameters[parameterName])
        {
            this._parameters[parameterName] = parameterInstance;
            this.bindEvent(parameterInstance, 'FilterInvalidated', this._onParameterFilterInvalidated);
        }
    },

    findParameter: function (parameterName)
    {
        return this._parameters[parameterName] || null;
    },

    invalidateDirtyParameters: function ()
    {
        var dashboardUpdateData = this.ScriptManager.createDashboardUpdateData();

        var clientParameters = [];
        dashboardUpdateData.ClientParameters = clientParameters;

        var dirtyParameters = this._getDirtyParameters();

        if (dirtyParameters.length == 0)
        {
            return;
        }

        for (var i = 0; i < dirtyParameters.length; i++)
        {
            var parameter = dirtyParameters[i];
            parameter.NeedsUpdate = false;

            this.addParameterState(parameter, clientParameters);
        }

        this.ScriptManager.updateDashboard(dashboardUpdateData);
    },

    _getDirtyParameters: function ()
    {
        var arr = [];

        jQuery.each(this._parameters, function ()
        {
            var parameter = this;

            if (parameter.NeedsUpdate == true)
            {
                arr.push(parameter);
            }
        });

        return arr;
    },

    _onParameterFilterInvalidated: function (e)
    {
        var parameter = e.target;
        
        var dashboardUpdateData = this.ScriptManager.createDashboardUpdateData();

        var clientParameters = [];
        dashboardUpdateData.ClientParameters = clientParameters;

        this.addParameterState(parameter, clientParameters);

        this.ScriptManager.updateDashboard(dashboardUpdateData);
    },

    addParameterState: function (parameter, data)
    {
        var paramData = parameter.serialize();

        if (paramData != null)
        {
            data.push(paramData);
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jQuery.js" />

Dundas.Dashboard.ExportManager = Dundas.Dashboard.Service.extend(
{
    init: function ()
    {
        this._super();
        this._dialog = null;
        this._clickAway = null;
        this._controlsListElement = null;
        this._exportFormatListElement = null;
        this._exportEntireDashboardOption = null;
        this._exportSelectedControlsOption = null;
        this._exportCommand = null;
        this._advancedOptionsCommand = null;
        this._exportToolbarCommand = null;
        this._advancedOptionsElement = null;
        this._includeLegendImageElement = null;
        this._legendImagePositionElement = null;
    },

    onLoaded: function ()
    {
        var toolbar = document.body.querySelector('body > .Toolbar');
        this._exportToolbarCommand = toolbar.querySelector('.Export');
        this.bindEvent(this._exportToolbarCommand, 'click', this._onExport);
    },

    _onExport: function (e)
    {
        this.exportStart();
    },

    // Renamed from export which is reserved and causes errors on iOS v4.3.5 (bz 21840)
    exportStart: function (selectedControlIds)
    {
        this._initialize();

        this._showDialog();

        if (selectedControlIds != null)
        {
            this._clearSelectedDashboardControls();
            this._setSelectedControls(selectedControlIds);
            this._highlightSeletedControls();
            this.IsExportEntireDashboard = false;
        }
    },

    _initialize: function ()
    {
        if (this._dialog != null)
        {
            return;
        }

        this._dialog = document.createElement('div');

        var model = null;
        Dundas.Dashboard.Utility.applyTemplate('ExportDialogTemplate', model, this._dialog);
        this._dialog = this._dialog.firstElementChild;

        this._exportCommand = this._dialog.querySelector('.ExportCommand');
        this.bindEvent(this._exportCommand, 'click', this._onExportCommandInvoked);

        this._controlsListElement = this._getControlsListElement();
        this.bindEvent(this._controlsListElement, 'change', this._onSelectedExportControlsChange);

        this._exportEntireDashboardOption = this._dialog.querySelector('.ExportEntireDashboard');
        this._exportSelectedControlsOption = this._dialog.querySelector('.ExportSelectedControls');
        this.bindEvent(this._exportEntireDashboardOption, 'change', this._onExportTypeChange);
        this.bindEvent(this._exportSelectedControlsOption, 'change', this._onExportTypeChange);

        this._advancedOptionsCommand = this._dialog.querySelector('.AdvancedCommand');
        this.bindEvent(this._advancedOptionsCommand, 'click', this._onAdvancedCommandInvoked);

        this._exportFormatListElement = this._dialog.querySelector('.ExportFormat');

        this._includeLegendImageElement = this._dialog.querySelector('.IncludeLegendImage');
        this._legendImagePositionElement = this._dialog.querySelector('.LegendImagePosition');

        var formattedExportToggle = this._dialog.querySelector('.ExportFormatted');
        this.bindEvent(formattedExportToggle, 'change', this._onFormattedExportChanged);

        var body = document.body;
        $(body).append(this._dialog);
    },

    _showDialog: function ()
    {
        this._updateUIState();

        var trigger = this._exportToolbarCommand;

        var scriptServices = this.getService('ScriptServices');
        var left = $(window).width();
        var top = $(trigger).offset().top + $(trigger).height();
        scriptServices.showPopup(left, top, trigger, this._dialog);

        var popup = scriptServices.Popup;
        this.bindEvent(popup, 'Closed', this._onPopupClosed);
    },

    _hideDialog: function ()
    {
        this._clearHighlightedControls();
        this._clearSelectedDashboardControls();
    },

    _onPopupClosed: function (e)
    {
        var popup = e.target;
        this.unbindEvent(popup, 'Closed', this._onPopupClosed);

        this._hideDialog();
    },

    _onExportTypeChange: function (e)
    {
        if (this.IsExportEntireDashboard == true)
        {
            this._clearSelectedDashboardControls();
        }

        this._updateUIState();
    },

    _onExportCommandInvoked: function ()
    {
        this._performExport();
    },

    _onAdvancedCommandInvoked: function ()
    {
        if (this._advancedOptionsElement == null)
        {
            this._loadAdvancedOptions();
        }

        $(this._dialog).toggleClass('Advanced');

        var scriptServices = this.getService('ScriptServices');
        var popup = scriptServices.Popup;
        popup.updateLayout(null);
    },

    _onFormattedExportChanged: function (e)
    {
        var isFormattedExport = e.target.checked;

        var exportContentElement = this._dialog.querySelector('.ExportContent');

        if (isFormattedExport == true)
        {
            $(exportContentElement).addClass('Formatted');
        }
        else
        {
            $(exportContentElement).removeClass('Formatted');
        }
    },

    _loadAdvancedOptions: function ()
    {
        var data = this.ScriptManager.createGenericOperationData('GetExportAdvancedOptions', {});

        var completedHandler = this.createDelegate(this._onAdvancedOptionsLoaded);
        var options = this.ScriptManager.createJsonUpdateData(data, 7, completedHandler);

        this.ScriptManager.sendServiceRequest(null, options);
    },

    _onAdvancedOptionsLoaded: function (e)
    {
        if (e.error)
        {
            return;
        }

        this._advancedOptionsElement = this._dialog.querySelector('.ExportAdvancedOptions');

        var data = e.data;

        this._setupTemplateData(data.TemplateData);

        jQuery.tmpl(data.View, data).appendTo(this._advancedOptionsElement);
    },

    _setupTemplateData: function (templateData)
    {
        templateData.forEach(function (item)
        {
            var value = item.Value;
            item.TagName = 'input';
            item.TextBefore = item.Text;

            if (typeof (value) == 'boolean')
            {
                item.Checked = value == true;
                item.InputType = 'checkbox';
                item.TextAfter = item.Text;
                delete item.TextBefore;
            }
            else if (Array.isArray(item.ListItems) == true)
            {
                item.TagName = 'select';
                item.Options = item.ListItems;

                jQuery.each(item.Options, function (index, currentItem)
                {
                    if (currentItem.Item2 == value)
                    {
                        currentItem.Selected = true;
                        return false;
                    }
                });
            }
            else if (typeof (value) == 'string')
            {
                item.InputType = 'text';
            }
        });
    },

    _onSelectedExportControlsChange: function (e)
    {
        var select = e.target;

        this._updateUIState();

        this._clearHighlightedControls();

        this._highlightSeletedControls();

        this._updateExportLegendImageUIState();
    },

    _highlightSeletedControls: function ()
    {
        var selectedIds = this.SelectedExportControlIds;

        selectedIds.forEach(function (id)
        {
            var control = $get(id);
            $(control).addClass('ExportHighlight');
        });
    },

    _clearHighlightedControls: function ()
    {
        $('.Dashboard > .ExportHighlight').removeClass('ExportHighlight');
    },

    _updateExportLegendImageUIState: function ()
    {
        var selectedIds = this.SelectedExportControlIds;
        var allHaveLegend = selectedIds.every(function (item)
        {
            var element = $get(item);
            return element.hasAttribute('data-Legend');
        });

        this._enableLegendImageExport(allHaveLegend);
    },

    _performExport: function ()
    {
        var sm = this.ScriptManager;
        var stateData = sm.getStateData();
        var form = document.querySelector('body > .Form > form');
        $('input[name="DashboardId"]', form).val(stateData.DashboardId);
        $('input[name="ParameterState"]', form).val(stateData.ParameterState);
        $('input[name="ScriptState"]', form).val(stateData.ScriptState);

        var exportData = this._getExportData();
        exportData = JSON.stringify(exportData);
        exportData = Dundas.Dashboard.Utility.base64Encode(exportData);

        $('input[name="ExportData"]', form).val(exportData);

        form.submit();
    },

    _getExportData: function ()
    {
        var data = {};
        data.__type = 'Dd_exi';

        data.IsEntireDashboard = this.IsExportEntireDashboard;

        if (data.IsEntireDashboard == false)
        {
            data.ControlIds = this.SelectedExportControlIds;
        }

        data.ExportFormat = this.ExportFormat;
        data.IsExportFormatted = this.IsExportFormatted;
        data.IsIncludeLegendImage = this.IsIncludeLegendImage;
        data.LegendImagePosition = this.LegendImagePosition;

        if (this._advancedOptionsElement != null)
        {
            data.AdvancedOptions = this._getAdvancedOptionsData();
        }

        return data;
    },

    _getAdvancedOptionsData: function ()
    {
        var formElements = this._dialog.querySelector('.ExportAdvancedOptions');
        formElements = formElements.querySelectorAll('input, select');
        formElements = jQuery.makeArray(formElements);

        var data = {};

        formElements.forEach(function (item)
        {
            var name = item.name;
            var value;

            if (item.type == 'checkbox')
            {
                value = item.checked;
            }
            else if (item.tagName == 'select')
            {
                var option = item.options[item.selectedIndex];
                value = option.value;
            }
            else
            {
                value = item.value;
            }

            data[name] = value;
        });

        return data;
    },

    _getControlsListElement: function ()
    {
        return this._dialog.querySelector('.ExportControlsPanel select');
    },

    _updateUIState: function ()
    {
        var hasExportFormat = this.ExportFormat != null;

        if (hasExportFormat == false)
        {
            this._disableAll();
            return;
        }

        var isExportEntireDashboard = this.IsExportEntireDashboard == true;
        var exportEnabled = isExportEntireDashboard || this.HasSelectedExportControl == true;
        exportEnabled = exportEnabled && hasExportFormat;

        this._exportCommand.disabled = exportEnabled == false;
        this._controlsListElement.disabled = isExportEntireDashboard == true;
        this._advancedOptionsCommand.disabled = hasExportFormat == false;

        if (isExportEntireDashboard == true)
        {
            this._clearHighlightedControls();
        }

        this._enableLegendImageExport(false);
    },

    _enableLegendImageExport: function (isEnabled)
    {
        this._includeLegendImageElement.disabled = isEnabled == false;
        this._legendImagePositionElement.disabled = isEnabled == false;
    },

    _disableAll: function ()
    {
        $('input,select,button', this._dialog).attr('disabled', 'disabled');
    },

    _clearSelectedDashboardControls: function ()
    {
        this._controlsListElement.selectedIndex = -1;
    },

    _setSelectedControls: function (selectedControlIds)
    {
        if (selectedControlIds == null || selectedControlIds.length == 0)
        {
            return;
        }

        var options = jQuery.makeArray(this._controlsListElement.options);
        var optionsById = {};

        options.forEach(function (item)
        {
            optionsById[item.value] = item;
        });

        selectedControlIds.forEach(function (item)
        {
            var option = optionsById[item];

            if (option != null)
            {
                option.selected = true;
            }
        });
    },

    __properties:
    {
        'IsExportEntireDashboard':
        {
            get: function ()
            {
                return this._exportEntireDashboardOption.checked;
            },

            set: function (value)
            {
                this._exportEntireDashboardOption.checked = value;
                this._exportSelectedControlsOption.checked = !value;
                this._updateUIState();
            }
        },

        'HasSelectedExportControl':
        {
            get: function ()
            {
                return this._controlsListElement.selectedIndex != -1;
            }
        },

        'SelectedExportControlIds':
        {
            get: function ()
            {
                var options = jQuery.makeArray(this._controlsListElement.options);

                options = options.filter(function (item)
                {
                    return item.selected;
                });

                var ids = options.map(function (item)
                {
                    return item.value;
                });

                return ids;
            }
        },

        'ExportFormat':
        {
            get: function ()
            {
                var value = null;

                var index = this._exportFormatListElement.selectedIndex;

                if (index != -1)
                {
                    value = this._exportFormatListElement.options[index].value;
                }

                return value;
            }
        },

        'IsExportFormatted':
        {
            get: function ()
            {
                var element = this._dialog.querySelector('.ExportFormatted');
                return element.checked;
            }
        },

        'IsIncludeLegendImage':
        {
            get: function ()
            {
                return this._includeLegendImageElement.disabled == false && this._includeLegendImageElement.checked;
            }
        },

        'LegendImagePosition':
        {
            get: function ()
            {
                return this._legendImagePositionElement.value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterDateRangePicker = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._fromParameters = null;
        this._toParameters = null;
        this._grain = null;
    },

    onLoaded: function ()
    {
        this._super();

        this._fromParameters._dashboardParameterName = null;
        this._fromParameters._isRangePicker = true;
        this._toParameters._dashboardParameterName = null;
        this._toParameters._isRangePicker = true;

        this._fromControl = Dundas.Dashboard.ScriptManager.Instance.createObject(Dundas.Dashboard.ParameterDateTimePicker, this._fromParameters);
        this._toControl = Dundas.Dashboard.ScriptManager.Instance.createObject(Dundas.Dashboard.ParameterDateTimePicker, this._toParameters);

        this._grain = this._fromControl.Grain;

        this.bindEvent(this._fromControl, 'QueryMinMaxDate', this._onPickerQueryMinMaxDate);
        this.bindEvent(this._toControl, 'QueryMinMaxDate', this._onPickerQueryMinMaxDate);

        this.bindEvent(this._fromControl, 'SelectedDateChanged', this._onPickerSelectedDateChanged);
        this.bindEvent(this._toControl, 'SelectedDateChanged', this._onPickerSelectedDateChanged);
    },

    _onPickerQueryMinMaxDate: function (e)
    {
        if (e.target == this._fromControl && e.dateType == 'Max')
        {
            var date = this._toControl.SelectedDate;
            e.date = date;
        }
        else if (e.target == this._toControl && e.dateType == 'Min')
        {
            var date = this._fromControl.SelectedDate;
            e.date = date;
        }
    },

    _onPickerSelectedDateChanged: function (e)
    {
        this._startDate = this._fromControl.SelectedDate;
        this._endDate = this._toControl.SelectedDate;

        if (e.target == this._fromControl && this._toControl.IsDisabled == true)
        {
            // Re-enable the to control now that a non-token start value has been selected
            this._toControl.IsDisabled = false;
        }

        var startDateText = this._fromControl._formatDate(this._startDate);
        var endDateText = this._toControl._formatDate(this._endDate);

        var endValue = this._endDate;
        var param = this.DashboardParameter;

        if (this._toControl.NamedTokenValue != null)
        {
            endValue = param.createNamedToken(this._toControl.NamedTokenValue);
        }

        param.setRangeValues(this._startDate, startDateText, endValue, endDateText, true, this._grain);

        this._invalidateParameter();
    },

    _getNextDate: function (date, offset)
    {
        var newDate = new Date(date.getTime());
        var getFunc;
        var setFunc;

        switch (this._grain)
        {
            case 3:
                getFunc = Date.prototype.getUTCFullYear;
                setFunc = Date.prototype.setUTCFullYear;
                break;
            case 5:
                getFunc = Date.prototype.getUTCMonth;
                setFunc = Date.prototype.setUTCMonth;
                break;
            case 7:
                getFunc = Date.prototype.getUTCDate;
                setFunc = Date.prototype.setUTCDate;
                break;
        }

        var value = getFunc.call(date);
        value += offset;
        setFunc.call(newDate, value);

        return newDate;
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterDateTimePicker = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._datePicker = null;
        this._dateInput = null;
        this._grain = null;
        this._minDate = null;
        this._maxDate = null;
        this._selectedDate = null;
        this._isRange = null;
        this._isRangePicker = null;
        this._namedTokenData = null;
        this._isDisabled = null;
        this._shortDatePattern = null;
        this._dateSeparator = null;
        this._isUsingBrowserPicker = null;

        this._registerDateFields(['_selectedDate', '_minDate', '_maxDate', ]);
    },

    onLoaded: function ()
    {
        this._super();
        this._dateInput = this._getInput();

        this._shortDatePattern = this.ScriptManager.ApplicationConfiguration.ShortDatePattern;
        this._dateSeparator = this.ScriptManager.ApplicationConfiguration.DateSeparator;

        this._setupDatePicker();

        this._displayValue();
    },

    _setupDatePicker: function ()
    {
        this._datePicker = this.ScriptManager.createObject(Dundas.Dashboard.DatePicker);
        this._datePicker.Grain = this.Grain;

        this._setupBrowserDatePicker();
        var inputChangeEvent = 'change';

        if (this._isUsingBrowserPicker == false)
        {
            this._datePicker.Target = this._dateInput;
            this.bindEvent(this._datePicker, 'SelectedDateChanged', this._onPickerSelectedDateChanged);

            if (this.IsDisabled == false)
            {
                this._setDatePickerTrigger();
            }
        }
        else
        {
            inputChangeEvent = 'blur';
        }

        this.bindEvent(this._dateInput, inputChangeEvent, this._onInputValueChanged);
    },

    _setupBrowserDatePicker: function ()
    {
        this._isUsingBrowserPicker = false;
        var type;

        if (this._datePicker.IsDayGrain == true)
        {
            type = 'date';
        }
        else if (this._datePicker.IsMonthGrain == true)
        {
            type = 'month';
        }

        if (type == null || this._isInputTypeSupported(type, true) == false)
        {
            return;
        }

        this._dateInput.type = type;
        this._isUsingBrowserPicker = true;
    },

    _setDatePickerTrigger: function ()
    {
        this._datePicker.Trigger = $('.Picker', this.TargetElement).get(0);
    },

    _displayValue: function ()
    {
        if (this._namedTokenData != null && this._namedTokenData.Value != 0)
        {
            this._displayNamedToken();
            this._datePicker.SelectedDate = this.SelectedDate;
        }
        else
        {
            this._displayDate();
        }
    },

    _onPickerSelectedDateChanged: function (e)
    {
        var date = e.selectedDate;

        this._onParameterValueChanged(date);
    },

    _displayNamedToken: function ()
    {
        this._dateInput.value = this._namedTokenData.ValueText;
        $(this._dateInput).addClass('NamedToken');
    },

    _displayDate: function (date)
    {
        $(this._dateInput).removeClass('NamedToken');

        if (date == null)
        {
            date = this.SelectedDate;
        }

        if (this._isUsingBrowserPicker == true)
        {
            this._dateInput.valueAsDate = date;
        }
        else
        {
            var s = this._formatDate(date);
            this._dateInput.value = s;
            this._dateInput.setAttribute('value', s);
        }

        this._datePicker.SelectedDate = date;
    },

    _formatDate: function (date)
    {
        var format = null;
        var args = null;

        var month = date.getUTCMonth();
        var year = date.getUTCFullYear();

        if (this._datePicker.IsDayGrain == true)
        {
            s = this._getShortDateFormattedString(date);
        }
        else if (this._datePicker.IsMonthGrain == true)
        {
            format = '{0}, {1}';
            args = [this._getMonthName(month), year];
            s = String.format.apply(null, [format].concat(args));
        }
        else
        {
            format = '{0}';
            args = [year];
            s = String.format.apply(null, [format].concat(args));
        }


        return s;
    },

    _getMonthName: function (month)
    {
        return this.ScriptManager.ApplicationConfiguration.MonthLongNames[month];
    },

    _onInputValueChanged: function (e)
    {
        var inputDate;

        if (this._isUsingBrowserPicker == true)
        {
            inputDate = this._dateInput.valueAsDate;

            if (inputDate == null)
            {
                // User cleared field; ignore
                this._displayDate();
                return;
            }
        }
        else
        {
            inputDate = this._parseInputValue();
        }

        if (isNaN(inputDate.getTime()) == true)
        {
            //alert('Invalid date value.  Dates must be specified in yyyy-MM-dd format.');
            this._displayDate();
            return;
        }

        this._onParameterValueChanged(inputDate);
    },

    _parseInputValue: function ()
    {
        var value = this._dateInput.value;
        var year, month, day;

        if (this._datePicker.IsDayGrain == true)
        {
            try
            {
                var dateValue = this._parseShortDate(value.trim());
                year = dateValue.getFullYear();
                month = dateValue.getMonth();
                day = dateValue.getDate();
            }
            catch (e) { }
        }
        else if (this._datePicker.IsMonthGrain == true)
        {
            var parseFail = true;

            try
            {
                var dateValue = this._parseShortDate(value.trim());
                year = dateValue.getFullYear();
                month = dateValue.getMonth();
                day = 1;
                parseFail = false;
            }
            catch (e) { }

            if (parseFail)
            {
                try
                {
                    var dateParts = value.split(',');
                    month = parseInt(dateParts[0].trim());
                    if (isNaN(month))
                    {
                        var haveResult = false;

                        for (var i = 0; i < Dundas.Dashboard.ScriptManager.Instance.ApplicationConfiguration.MonthShortNames.length; i++)
                        {
                            if (this.ScriptManager.ApplicationConfiguration.MonthShortNames[i].trim().toLowerCase() == dateParts[0].trim().toLowerCase())
                            {
                                month = i;
                                haveResult = true;
                                break;
                            }
                        }

                        if (!haveResult)
                        {
                            for (var i = 0; i < Dundas.Dashboard.ScriptManager.Instance.ApplicationConfiguration.MonthLongNames.length; i++)
                            {
                                if (this.ScriptManager.ApplicationConfiguration.MonthLongNames[i].trim().toLowerCase() == dateParts[0].trim().toLowerCase())
                                {
                                    month = i;
                                    haveResult = true;
                                    break;
                                }
                            }
                        }
                    }
                    else
                    {
                        if (month < 1 || month > 12)
                        {
                            month = undefined;
                        }
                        else
                        {
                            month--;
                        }
                    }

                    year = parseInt(dateParts[1].trim());

                    day = 1;
                }
                catch (e) { }
            }
        }
        else
        {
            var parseFail = true;
            try
            {
                var dateValue = this._parseShortDate(value.trim());
                year = dateValue.getFullYear();
                month = dateValue.getMonth();
                day = 1;
                parseFail = false;
            }
            catch (e) { }

            if (parseFail)
            {
                year = parseInt(value);
                month = 0;
                day = 1;
            }
        }

        var inputDate = new Date(Date.UTC(year, month, day));

        return inputDate;
    },

    _onParameterValueChanged: function (date)
    {
        date = this._getActualDate(date);

        this._namedTokenData = null;

        this.SelectedDate = date;

        this._displayDate(date);

        this._datePicker.SelectedDate = date;

        this._updateParameter(date);
    },

    _updateParameter: function (date)
    {
        if (this._isRangePicker == true)
        {
            return;
        }

        var param = this.DashboardParameter;
        param.clear();

        var filterValue = param.createFilterValue();
        filterValue.IsConsolidatedDateTime = true;
        filterValue.IsRange = this._isRange;

        var memberValue = param.createMemberValue(date, this._formatDate(date));
        memberValue.DateTimeGrain = this.Grain;

        filterValue.MemberValues.push(memberValue);

        param.setFilterValue(filterValue);

        this._invalidateParameter();
    },

    _cancelDateChange: function ()
    {
        this._displayDate(this.SelectedDate);
        this._datePicker.SelectedDate = this.SelectedDate;
    },

    _getActualDate: function (date)
    {
        var minDate = this._getMinMaxDate('Min', this._minDate);

        if (minDate != null && date < minDate)
        {
            return minDate;
        }

        var maxDate = this._getMinMaxDate('Max', this._maxDate);

        if (maxDate != null && date > maxDate)
        {
            return maxDate;
        }

        return date;
    },

    _getMinMaxDate: function (type, defaultDate)
    {
        var e = jQuery.Event('QueryMinMaxDate');
        e.dateType = type;
        e.date = null;

        $(this).trigger(e);

        if (e.date != null)
        {
            return e.date;
        }
        else
        {
            return defaultDate;
        }
    },

    getCurrentValue: function ()
    {
        return this._dateInput.value;
    },

    _getInput: function ()
    {
        return $('input', this.TargetElement).get(0);
    },

    _onDisabledChanged: function ()
    {
        if (this.IsDisabled == false)
        {
            this._displayValue();
            $(this.TargetElement).removeClass('Disabled');
            this._dateInput.disabled = false;
            this._setDatePickerTrigger();
        }
    },

    _parseShortDate: function (dateString)
    {
        var formatParts = this._shortDatePattern.split(this._dateSeparator);
        var dateParts = dateString.split(this._dateSeparator);
        var dateResult = new Date();

        var date = null;
        var year = null;
        var month = null;

        if (formatParts.length != dateParts.length)
        {
            throw "Error in formatting";
        }

        for (var i = 0; i < formatParts.length; i++)
        {
            if (formatParts[i] == "M" || formatParts[i] == "MM")
            {
                month = parseInt(dateParts[i], 10);
                if (month < 1 || month > 12)
                {
                    throw "Invalid Month";
                }
                else
                {
                    month--;
                }
            }
            else if (formatParts[i] == "MMM")
            {
                var haveResult = false;
                for (var j = 0; j < Dundas.Dashboard.ScriptManager.Instance.ApplicationConfiguration.MonthShortNames.length; j++)
                {
                    if (this.ScriptManager.ApplicationConfiguration.MonthShortNames[j].trim().toLowerCase() == dateParts[i].trim().toLowerCase())
                    {
                        month = j;
                        haveResult = true;
                        break;
                    }
                }

                if (!haveResult)
                {
                    try
                    {
                        month = parseInt(dateParts[i], 10);
                        if (month > 0 && month < 13)
                        {
                            month--;
                            haveResult = true;
                        }
                    }
                    catch (e) { }
                }

                if (!haveResult)
                {
                    throw "Invalid Month";
                }
            }
            else if (formatParts[i] == "MMMM")
            {
                var haveResult = false;
                for (var j = 0; j < Dundas.Dashboard.ScriptManager.Instance.ApplicationConfiguration.MonthLongNames.length; j++)
                {
                    if (this.ScriptManager.ApplicationConfiguration.MonthLongNames[j].trim().toLowerCase() == dateParts[i].trim().toLowerCase())
                    {
                        month = j;
                        haveResult = true;
                        break;
                    }
                }

                if (!haveResult)
                {
                    try
                    {
                        month = parseInt(dateParts[i], 10);
                        if (month > 0 && month < 13)
                        {
                            haveResult = true;
                            month--;
                        }
                    }
                    catch (e) { }
                }

                if (!haveResult)
                {
                    throw "Invalid Month";
                }
            }
            else if (formatParts[i] == "y" || formatParts[i] == "yy" || formatParts[i] == "yyy" || formatParts[i] == "yyyy")
            {
                year = parseInt(dateParts[i], 10);

                if (year > 99 && year < 999)
                {
                    year += 1000;
                }
                else if (year >= 0 && year < 100)
                {
                    if ((year + 2000) > new Date().getUTCFullYear())
                    {
                        year += 1900;
                    }
                    else
                    {
                        year += 2000;
                    }
                }
            }
            else if (formatParts[i] == "d" || formatParts[i] == "dd")
            {
                date = parseInt(dateParts[i], 10);
            }
            else
            {
                throw "Unsupported format";
            }

        }

        if (year == null) { throw "Year not found" }

        if (month == null) { throw "Month not found" }

        if (date == null) { throw "Date not found" }

        dateResult = new Date(year, month, date);

        return dateResult;
    },

    _getShortDateFormattedString: function (dateValue)
    {
        var formatParts = this._shortDatePattern.split(this._dateSeparator);
        var result = '';

        var month = dateValue.getUTCMonth();
        var year = dateValue.getUTCFullYear();
        var UTCDate = dateValue.getUTCDate();
        var day = dateValue.getUTCDay();

        for (var i = 0; i < formatParts.length; i++)
        {
            switch (formatParts[i])
            {
                case "M":
                    result += (month + 1) + this._dateSeparator;
                    break;
                case "MM":
                    if (month < 9)
                    {
                        result += '0' + (month + 1) + this._dateSeparator;
                    }
                    else
                    {
                        result += (month + 1) + this._dateSeparator;
                    }
                    break;
                case "MMM":
                    result += this.ScriptManager.ApplicationConfiguration.MonthShortNames[month] + this._dateSeparator;
                    break;
                case "MMMM":
                    result += this.ScriptManager.ApplicationConfiguration.MonthLongNames[month] + this._dateSeparator;
                    break;
                case "y":
                    result += year.toString().substring(3) + this._dateSeparator;
                    break;
                case "yy":
                    result += year.toString().substring(2) + this._dateSeparator;
                    break;
                case "yyy":
                    result += year.toString().substring(1) + this._dateSeparator;
                    break;
                case "yyyy":
                    result += year.toString() + this._dateSeparator;
                    break;
                case "d":
                    result += UTCDate.toString() + this._dateSeparator;
                    break;
                case "dd":
                    if (UTCDate > 9)
                    {
                        result += UTCDate.toString() + this._dateSeparator;
                    }
                    else
                    {
                        result += '0' + UTCDate.toString() + this._dateSeparator;
                    }
                    break;
                case "ddd":
                    result += this.ScriptManager.ApplicationConfiguration.DayShortNames[day] + this._dateSeparator;
                    break;
                case "dddd":
                    result += this.ScriptManager.ApplicationConfiguration.DayLongNames[day] + this._dateSeparator;
                    break;
                default:
                    throw "Unsupported format";
                    break;
            }
        }

        return result.substring(0, result.length - 1);
    },

    __properties:
    {
        'SelectedDate':
        {
            get: function ()
            {
                return this._selectedDate;
            },

            set: function (value)
            {
                this._selectedDate = value;
                $(this).trigger('SelectedDateChanged');
            }
        },

        'Grain':
        {
            get: function ()
            {
                return this._grain;
            },

            set: function (value)
            {
                this._grain = value;
            }
        },

        'MinDate':
        {
            get: function ()
            {
                return this._minDate;
            },

            set: function (value)
            {
                this._minDate = value;
            }
        },

        'MaxDate':
        {
            get: function ()
            {
                return this._maxDate;
            },

            set: function (value)
            {
                this._maxDate = value;
            }
        },

        'IsRange':
        {
            get: function ()
            {
                return this._isRange;
            }
        },

        'NamedTokenValue':
        {
            get: function ()
            {
                var value = null;

                if (this._namedTokenData != null)
                {
                    value = this._namedTokenData.Value;
                }

                return value;
            }
        },

        'IsDisabled':
        {
            get: function ()
            {
                return this._isDisabled == true;
            },

            set: function (value)
            {
                this._isDisabled = value;
                this._onDisabledChanged();
            }
        }
    }
});

﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterDropDownList = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();

        this._isAutoComplete = null;
        this._labelItems = null;
        this._autoCompleteDropDownList = null;
        this._hasClickedOnAutoCompleteDropDown = null;
        this._isPopupOpen = false;
    },

    onLoaded: function ()
    {
        this._super();

        // Check for autocomplete or not.
        if (this._isAutoComplete == null)
        {
            // No autocomplete.

            var control = this._getSelectElement();

            this.bindEvent(control, 'change', this._onDropDownChanged);
        }
        else if (this._isAutoComplete == true)
        {
            // Autocomplete.

            var control = this._getInputElement();

            this.bindEvent(control, 'keyup', this._onTextBoxKeyUp);
            this.bindEvent(control, 'blur', this._onTextBoxBlur);

            // Create the drop down list button.
            var content = document.createElement('div');
            var dropArrow = $(content);
            dropArrow.addClass('ParameterDropDownListAutoCompleteDropArrow');
            dropArrow.insertBefore(this._getInputElement());

            // Position. We have to use CSS to position because position() and offset() are trying to be too smart.
            // We use a 4px padding to help 'clickability' of the div, so we have to adjust for that too.
            var width = $(this.TargetElement).width();
            var ourWidth = dropArrow.width();
            var ourHeight = dropArrow.height();
            dropArrow.css('left', width + ourWidth - 4 + 'px');
            dropArrow.css('top', (ourHeight / 2) - 4 + 'px');

            // Track the click.
            this.bindEvent(dropArrow, 'click', this._dropArrowClick);
        }
    },

    _getSelectElement: function ()
    {
        // Used for non-autocomplete mode.

        return $('select', this.TargetElement).get(0);
    },

    _getInputElement: function ()
    {
        // Used in autocomplete mode.

        return $('input', this.TargetElement);
    },

    _showPopup: function(textInput)
    {
        var scriptServices = this.getService('ScriptServices');

        // Clear visible on all items.
        this._autoCompleteDropDownList.children('.ParameterDropDownListItemVisible').removeClass('ParameterDropDownListItemVisible');

        // Turn nulls into blanks for all match.
        if (!textInput)
        {
            textInput = '';
        }

        // Escape illegal characters in input.
        var input = textInput.replace(/(^|[^\\])((?:\\{2})*)(\\(?=[^\\/}]|$)|[/}])/g, '$1$2\\$3');

        // Match appropriate.
        var regex = new RegExp(input, 'i');
        this._autoCompleteDropDownList.children().each(function (i)
        {
            if (regex.test($(this).text()))
            {
                $(this).addClass('ParameterDropDownListItemVisible');
            }
        });

        // Show the pop-up if we need to.
        if (!this._isPopupOpen)
        {
            // Get position.
            var offset = this._getInputElement().offset();
            offset.top += this._getInputElement().height();

            // Offset nudge in pop-up.
            offset.left -= 10;
            offset.top -= 5;

            scriptServices.showPopup(offset.left, offset.top, this._getInputElement(), this._autoCompleteDropDownList.get(0));
        }

        this._isPopupOpen = true;
    },

    _closePopup: function()
    {
        // Used in autocomplete mode.

        // Close the pop-up if necessary.
        if (this._isAutoComplete == true
            && this._autoCompleteDropDownList)
        {
            // Clear visible on all items.
            this._autoCompleteDropDownList.children('.ParameterDropDownListItemVisible').removeClass('ParameterDropDownListItemVisible');

            var scriptServices = this.getService('ScriptServices');
            scriptServices.hidePopup();
        }

        this._isPopupOpen = false;
    },

    _checkAutoCompleteDropDownListReady: function()
    {
        // Create the drop-down to provide the list. This is done on-demand to improve start-up time.
        if (this._autoCompleteDropDownList == null)
        {
            // Create the drop down from the items given.
            var content = document.createElement('div');
            this._autoCompleteDropDownList = $(content);
            this._autoCompleteDropDownList.addClass('ParameterDropDownListAutoCompleteDropDown');
            this._autoCompleteDropDownList.html(this._labelItems);
            this._autoCompleteDropDownList.insertAfter(this._getInputElement());
            this._autoCompleteDropDownList.width(this._getInputElement().width());

            // Listen for mousedown to cancel blur.
            this.bindEvent(this._autoCompleteDropDownList, 'mousedown', this._onAutoCompleteDropDownMouseDown);

            // Bind the click event. Framework will deal with touchstart vs. click.
            this.bindEvent(this._autoCompleteDropDownList, 'click', this._onAutoCompleteDropDownClick);

            // Bind hover. The css :hover would have been nicer, but it doesn't work well in IE when the
            // drop-down disappears; it keeps the current item selected for some reason.
            // It seems chrome will fire this eventually, after the popup is closed, but IE will not.

            // NOTE: toggleClass doesn't work here, because if they hover over and then change the selection
            // while the mouse is over, it will toggle it into the wrong state from there-on due to the
            // removal of class below.
            this._autoCompleteDropDownList.children().hover(
            function ()
            {
                $(this).addClass('ParameterDropDownListItemVisibleHover');
            },
            function ()
            {
                $(this).removeClass('ParameterDropDownListItemVisibleHover');
            });
        }

        // Since chrome fires mouseleave after the pop-up closes, and IE leaves the hover on, clear
        // the class everytime.
        this._autoCompleteDropDownList.children().removeClass('ParameterDropDownListItemVisibleHover');
    },

    _onDropDownChanged: function (e)
    {
        // Used for non-autocomplete mode.

        var control = this._getSelectElement();
        var value = control.value;

        var selectedIndex = control.selectedIndex;
        var options = $('> option', control).get();
        var selectedOption = options[selectedIndex];

        var param = this.DashboardParameter;
        var filterValue = param.createFilterValue();

        if ($(selectedOption).hasClass('NamedToken') == true)
        {
            filterValue.NamedTokenValue = +$(selectedOption).attr('value');
        }
        else
        {
            var text = selectedOption.textContent;
            var memberValue = param.createMemberValue(value, text);
            filterValue.MemberValues.push(memberValue);
        }

        // Set the filter and invalidate.
        param.setFilterValue(filterValue);
        this._invalidateParameter();
    },

    _onAutoCompleteValueChanged: function (selectedItem)
    {
        // Used in autocomplete mode.

        var value = selectedItem.attr('value');
        var text = selectedItem.attr('text');

        var param = this.DashboardParameter;
        var filterValue = param.createFilterValue();

        if ($(selectedItem).hasClass('NamedToken') == true)
        {
            filterValue.NamedTokenValue = +$(selectedItem).attr('value');
        }
        else
        {
            // Ignore bad values.
            if (!text)
            {
                return;
            }

            var memberValue = param.createMemberValue(value, text);

            // Ignore bad values.
            if (!memberValue)
            {
                return;
            }

            filterValue.MemberValues.push(memberValue);
        }

        // Set the text in the input box.
        this._getInputElement().val(text);

        // Set the filter and invalidate.
        param.setFilterValue(filterValue);
        this._invalidateParameter();

        // Close the pop-up if necessary.
        this._closePopup();
    },

    _onTextBoxKeyUp: function (e)
    {
        // Used for autocomplete mode.

        // Create the drop-down to provide the list. This is done on-demand to improve start-up time.
        this._checkAutoCompleteDropDownListReady();

        // Check for enter key.
        if (e.keyCode == 13)
        {
            // Grab the first visible one.
            var children = this._autoCompleteDropDownList.children('.ParameterDropDownListItemVisible');
            if (children.length > 0)
            {
                this._onAutoCompleteValueChanged($(children[0]));
            }

            // Execute nothing else.
            return;
        }

        // Show the popup with the filter of the text.
        this._showPopup(this._getInputElement().val());
    },

    _onTextBoxBlur: function (e)
    {
        // Used for autocomplete mode.

        // If they didn't click on the auto complete drop down, then close the pop-up.
        if (this._hasClickedOnAutoCompleteDropDown != true)
        {
            this._closePopup();
        }

        this._hasClickedOnAutoCompleteDropDown = null;
    },

    _onAutoCompleteDropDownMouseDown: function (e)
    {
        // Used for autocomplete mode.

        this._hasClickedOnAutoCompleteDropDown = true;
    },

    _onAutoCompleteDropDownClick: function(e)
    {
        // Used for autocomplete mode.

        // Set this here as well as mousedown (in case we use touchstart, as it will fire first).
        this._hasClickedOnAutoCompleteDropDown = true;

        // Get the clicked item.
        if (e.target)
        {
            var clickedItem = $(e.target);

            // Ensure it's a label and not something else (i.e. surrounding div).
            if (clickedItem.hasClass('ParameterDropDownListItemVisible'))
            {
                // Inform that a click occured.
                this._onAutoCompleteValueChanged(clickedItem);
            }
        }
    },

    _dropArrowClick: function(e)
    {
        if (!this._isPopupOpen)
        {
            this._checkAutoCompleteDropDownListReady();

            // Show the popup with no filter.
            this._showPopup(null);
        }
        else
        {
            this._closePopup();
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterCascadingHierarchyControl = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._horizontalContentAlignment = null;
        this._horizontalSpacing = null;
        this._labelHorizontalAlignment = null;
        this._labelPosition = null;
        this._levelParameters = null;
        this._levelControls = null;
        this._orientation = null;
        this._verticalSpacing = null;
    },

    onLoaded: function ()
    {
        this._super();

        var elements = $('.ParameterHierarchyViewer', this.TargetElement).get();

        this._levelControls = [];
        for (var i = 0; i < elements.length; i++)
        {
            this._levelParameters[i].TargetElement = elements[i];
            if (i > 0)
            {
                this._levelParameters[i].HasAllMember = false;
            }

            this._levelControls[i] = Dundas.Dashboard.ScriptManager.Instance.createObject(Dundas.Dashboard.ParameterHierarchyViewer, this._levelParameters[i]);
        }

        this._layout();
        this._updateLevels();
    },

    _layout: function()
    {
        var outerDivs = $('> div > div', this.TargetElement);
        var labels = $('.DashboardLabel', this.TargetElement);
        var length = Math.min(outerDivs.length, this._levelControls.length);
        var rows;

        if (this._labelPosition == 'Left' || this._labelPosition == 'Right')
        {
            labels.css('display', 'inline-block');
            $(this._levelControls).each(function() { this.TargetElement.style.display = 'inline-block'; });
        }

        if (this._orientation == 'Horizontal')
        {
            var containerWidth = this.TargetElement.clientWidth;
            var levelsPerRow = length + 1;
            var maxRowWidth;

            do
            {
                levelsPerRow--;
                maxRowWidth = 0;
                rows = [];

                for (var colI = 0; colI < levelsPerRow; colI++)
                {
                    var colWidth = 0;

                    for (var i = colI; i < length; i += levelsPerRow)
                    {
                        var rowI = Math.floor(i / levelsPerRow);
                        if (rows[rowI] == null)
                        {
                            rows[rowI] = [];
                        }
                        rows[rowI].push(outerDivs[i]);
                        outerDivs[i].style.display = 'inline-block';
                        colWidth = Math.max(colWidth, outerDivs[i].clientWidth);
                    }
                    
                    maxRowWidth += colWidth + this._horizontalSpacing;
                }
            }
            while (maxRowWidth > containerWidth);
        }
        else
        {
            var containerHeight = this.TargetElement.clientHeight;
            var rowI = 0;
            var columnHeight = 0;
            rows = [];

            for (var i = 0; i < outerDivs.length; i++)
            {
                columnHeight += this._verticalSpacing + outerDivs[i].clientHeight;
                if (columnHeight > containerHeight)
                {
                    rowI = 0;
                    columnHeight = outerDivs[i].clientHeight;
                }

                if (rows[rowI] == null)
                {
                    rows[rowI] = [outerDivs[i]];
                }
                else
                {
                    rows[rowI].push(outerDivs[i]);
                }

                rowI++;
            }
        }

        if (this._horizontalContentAlignment == 'Stretch' && this._labelHorizontalAlignment != 'Left')
        {
            $(labels).css('display', 'block');
            $(outerDivs).wrapAll('<table/>');
            $(rows).wrap('<tr/>');
            if (this._labelPosition == 'Left' || this._labelPosition == 'Right')
            {
                $('> div', outerDivs).unwrap().wrap('<td/>');
            }
            else
            {
                $(outerDivs).wrap('<td/>');
            }
        }
        else
        {
            $(outerDivs).wrapAll('<table/>');
            $(rows).wrap('<tr/>');
            $(outerDivs).wrap('<td/>');
        }

        if (this._horizontalContentAlignment != 'Stretch')
        {
            $(outerDivs).css('width', '100%');
        }
        if (this._verticalContentAlignment != 'Stretch')
        {
            $(outerDivs).css('height', '100%');
        }

        var scrollingDiv = $('> div', this.TargetElement);
        scrollingDiv.css('max-height', '100%');
        scrollingDiv.css('max-width', '100%');

        $('td:not(:first-child)', this.TargetElement).css('paddingLeft', this._horizontalSpacing);
        $('tr:not(:first-child) > td', this.TargetElement).css('paddingTop', this._verticalSpacing);
    },

    _updateLevels: function ()
    {
        for (var i = 1; i < this._levelControls.length; i++)
        {
            var control = this._levelControls[i];
            var level = control.SelectedValue.HierarchyLevel;

            if (level == null || control.FirstSelectableLevel > level + 1 || (control.FirstSelectableLevel == level + 1 && control.SelectedValues.length > 1))
            {
                control.disable();
            }
            if (level >= control.FirstSelectableLevel && level <= control.LastVisibleLevel)
            {
                control.TargetElement.scrollIntoView(false);
            }
        }
    },
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterCheckBoxList = Dundas.Dashboard.ParameterControl.extend(
{
    onLoaded: function ()
    {
        this._super();

        this._checkboxes = null;

        this.bindEvent(this.TargetElement, 'change', this._onControlChanged);
    },

    _onControlChanged: function (e)
    {
        var allCheckbox = this._getAllCheckbox();
        var checkboxes = this._getRegularCheckboxes(allCheckbox);

        this._updateUIState(e.target, checkboxes, allCheckbox);

        var param = this.DashboardParameter;
        param.clear();

        if (e.target == allCheckbox)
        {
            var filterValue = param.createFilterValue();
            var tokenValue = 3;

            if (allCheckbox.checked == false)
            {
                tokenValue = 7;
            }

            filterValue.NamedTokenValue = tokenValue;
            param.setFilterValue(filterValue);
        }
        else
        {
            var checkedItems = checkboxes.filter(function (cb) { return cb.checked; });

            checkedItems.forEach(function (cb)
            {
                var filterValue = param.createFilterValue();
                filterValue.SingleValue = cb.value;
                param.FilterValues.push(filterValue);
            });
        }

        this._invalidateParameter();
    },

    _updateUIState: function (target, checkboxes, allCheckbox)
    {
        if (target == allCheckbox)
        {
            checkboxes.forEach(function (cb)
            {
                cb.checked = allCheckbox.checked;
            });
        }
        else
        {
            allCheckbox.checked = checkboxes.some(function (cb) { return cb.checked == false; }) == false;
        }
    },

    _getCheckboxes: function ()
    {
        if (this._checkboxes == null)
        {
            this._checkboxes = jQuery.makeArray(this.TargetElement.getElementsByTagName('input'));
        }

        return this._checkboxes;
    },

    _getRegularCheckboxes: function (allCheckbox)
    {
        var arr = this._getCheckboxes();
        arr = arr.concat();
        arr.splice(arr.indexOf(allCheckbox), 1);
        return arr;
    },

    _getAllCheckbox: function ()
    {
        var arr = this._getCheckboxes();

        return arr[0];
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterCheckBox = Dundas.Dashboard.ParameterControl.extend(
{
    onLoaded: function ()
    {
        this._super();

        var sm = this.ScriptManager;
        var controlParameters = {};
        controlParameters._targetElement = $('> .DashboardCheckBox', this.TargetElement).get(0);
        this._control = sm.createObject(Dundas.Dashboard.DashboardCheckBox, controlParameters);

        this.bindEvent(this._control, 'Change', this._onControlChanged);
    },

    _onControlChanged: function (e)
    {
        e.handled = true;

        var value = this._control.SelectedValue;

        var param = this.DashboardParameter;
        var filterValue = param.createFilterValue();

        var memberValue = param.createMemberValue(value, value.toString());
        filterValue.MemberValues.push(memberValue);

        param.setFilterValue(filterValue);

        this._invalidateParameter();
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterAxisLevelDropDownList = Dundas.Dashboard.ParameterControl.extend(
{
    onLoaded: function ()
    {
        this._super();
        var control = this._getSelectElement();
        this.bindEvent(control, 'change', this._onDropDownChanged);
    },

    _getSelectElement: function ()
    {
        return $('select', this.TargetElement).get(0);
    },

    _onDropDownChanged: function (e)
    {
        var control = this._getSelectElement();
        var value = +control.value;

        var param = this.DashboardParameter;
        param.GrainLevel = value;

        this._invalidateParameter();        
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterHierarchyViewer = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._trigger = null;
        this._picker = null;
        this._dropDown = null;
        this._members = null;
        this._isMultiSelect = null;
        this._selectedValue = null;
        this._selectedValues = null;
        this._hierarchyId = null;
        this._firstSelectableLevel = null;
        this._isHidingUnselectableLevels = false;
        this._lastSelectableLevel = null;
        this._lastVisibleLevel = null;
        this._hasAllMember = null;
        this._isTime = null;
        this._allIsLevel = null;
        this._maxSelectedItems = null;
        this._maxSelectedItemsMessage = null;
    },

    onLoaded: function ()
    {
        this._super();

        this._trigger = this._getControl('> button');

        if (this._trigger != null)
        {
            this._picker = this.ScriptManager.createObject(Dundas.Dashboard.HierarchyPicker);

            this._picker.Target = this._trigger;
            this._picker.Trigger = this._trigger;
            this._picker.RootMembers = this._members;
            this._picker.IsMultiSelect = this._isMultiSelect;
            this._picker.FirstSelectableLevel = this._firstSelectableLevel;
            this._picker.IsHidingUnselectableLevels = this._isHidingUnselectableLevels;
            this._picker.LastSelectableLevel = this._lastSelectableLevel;
            this._picker.LastVisibleLevel = this._lastVisibleLevel;
            this._picker.HasAllMember = this._hasAllMember;
            this._picker.AllIsLevel = this._allIsLevel;

            this.bindEvent(this._picker, 'SelectionChanged', this._onPickerSelectionChanged);
            this.bindEvent(this._picker, 'LoadChildren', this._onPickerLoadChildren);

            if (this._selectedValue != null)
            {
                this._picker.SelectedValue = this._selectedValue;
                this._picker.SelectedValues = this._selectedValues;

                var text = this._selectedValue.Text;
                this._displaySelectedText(text, this._selectedValues.length > 1);
            }
        }
        else
        {
            this._dropDown = this._getControl('> div > select');

            if (this._dropDown != null)
            {
                this.bindEvent(this._dropDown, 'change', this._onDropDownChanged);
            }

            this._renderDropDownItems();
        }
    },

    _getControl: function (path)
    {
        var control = $(path, this.TargetElement);

        if (control.size() > 0)
        {
            return control.get(0);
        }
        else
        {
            return null;
        }
    },

    _renderDropDownItems: function ()
    {
        var members = this._members;
        var parent = null;
        var levelNumber = 0;

        if (this._hasAllMember == true && this._allIsLevel == false)
        {
            levelNumber--;
        }
        else if (this._hasAllMember == false && this._allIsLevel == true)
        {
            levelNumber++;
        }

        while (members != null && members.length > 0 && members[0].c != null)
        {
            members[0].p = parent;
            members[0].l = levelNumber;

            parent = members[0];
            members = parent.c;

            levelNumber++;
        }

        if (members == null)
        {
            return;
        }

        var firstToken = $('option:first', this._dropDown)[0];
        var selectedToken = null;
        var selectedMemberValues = null;
        var selectedLevel = 0;
        var selectedIndex = -1;

        if (this._selectedValue != null)
        {
            selectedToken = this._selectedValue.NamedTokenValue;
            selectedMemberValues = this._selectedValue.Value;
            selectedLevel = this._selectedValue.HierarchyLevel;
        }

        if (firstToken != null)
        {
            this._setSelectData(firstToken, parent);
        }

        for (var i = 0; i < members.length; i++)
        {
            var member = members[i];
            var option = document.createElement('option');

            member.p = parent;
            member.l = levelNumber;

            option.textContent = member.n;

            if (firstToken != null)
            {
                $(option).insertBefore($(firstToken));
            }
            else
            {
                this._dropDown.options.add(option);
            }

            this._setSelectData(option, member);

            if (levelNumber == selectedLevel && Array.isSequenceEqual(member.v, selectedMemberValues) == true)
            {
                selectedIndex = this._dropDown.options.length - 1;
                if (firstToken != null)
                {
                    selectedIndex--;
                }
            }
        }

        if (selectedIndex >= 0)
        {
            this._dropDown.selectedIndex = selectedIndex;
        }
        else if (selectedToken == 3 || (this._selectedValue != null && this._selectedValue.HierarchyLevel < this.FirstSelectableLevel))
        {
            this._dropDown.selectedIndex = this._dropDown.options.length - 1;
        }
    },

    _onPickerSelectionChanged: function (e)
    {
        var node = e.selectedNode;

        if (e.selectedNodes)
        {
            if (e.selectedNodes.length > this._maxSelectedItems)
            {
                alert(this._maxSelectedItemsMessage);
                return;
            }

            node = e.selectedNodes;
        }

        this._displaySelectedNode(node);

        $(this).trigger('SelectedValueChanged');

        var scriptServices = this.getService('ScriptServices');
        scriptServices.hidePopup();

        this._updateParameterInternal(node);
    },

    _onPickerLoadChildren: function (e)
    {
        var values = {};
        values.__type = 'Dd_eld';
        this._prepareEnumerateData(values, e.node);

        var completedHandler = this.createDelegate(function (e2)
        {
            if (e2.error != null)
            {
                e.complete(e2.error);
                return;
            }

            e.data = e2.data.Members;
            e.level = values.level;

            e.complete();
        });

        var data = this.ScriptManager.createGenericOperationData('EnumerateLevelChildren', values);

        var options = this.ScriptManager.createJsonUpdateData(data, 7, completedHandler);
        options.ddOptions.suppressAjaxProgress = true;
        options.ddOptions.isExclusive = false;

        this.ScriptManager.sendServiceRequest(null, options);
    },

    _onDropDownChanged: function (e)
    {
        $(this).trigger('SelectedValueChanged');

        this._updateParameterInternal();
    },

    _prepareEnumerateData: function (data, node)
    {
        data.hierarchyId = this._hierarchyId;
        data.hierarchyId.__type = 'Dd_hid';

        var memberValue = {};

        data.level = this.getNodeLevel(node) + 1;
        data.memberKey = this.getNodeValue(node);
    },

    updateParameter: function (param, filterValueIndex, treeNode)
    {
        if (this._picker != null)
        {
            this._picker.ensureRendered();
        }

        var filterValue = param.createFilterValue();
        var node = treeNode;

        if (node == null)
        {
            node = this.SelectedNode;
        }

        if (this.getNodeToken(node) == 3)
        {
            filterValue.NamedTokenValue = 3;
        }
        else if (this._isTime == true)
        {
            var key = this.getNodeValue(node);
            var text = this.getNodeText(node);

            var memberValue = param.createMemberValue(key, text);
            this.initializeMemberValue(memberValue, node);

            filterValue.MemberValues.push(memberValue);
        }
        else
        {
            while (node != null && this.getNodeToken(node) != 3)
            {
                var key = this.getNodeValue(node);
                var memberValue = param.createMemberValue();

                memberValue.Values = key;
                this.initializeMemberValue(memberValue, node);

                filterValue.MemberValues.push(memberValue);

                node = this.getParentNode(node);
            }

            filterValue.NamedTokenValue = 0;
        }

        if (filterValueIndex == null)
        {
            filterValueIndex = 0;
        }

        param.FilterValues[filterValueIndex] = filterValue;
    },

    _updateParameterInternal: function (selectedNode)
    {
        var param = this.DashboardParameter;

        if (param == null)
        {
            return;
        }

        param.FilterValues = [];

        if (Array.isArray(selectedNode) == true)
        {
            var selectedNodes = selectedNode;

            for (var i = 0; i < Math.max(1, selectedNodes.length); i++)
            {
                this.updateParameter(param, i, selectedNodes[i]);
            }
        }
        else
        {
            this.updateParameter(param, null, selectedNode);
        }

        this._invalidateParameter();
    },

    _displaySelectedNode: function (node)
    {
        if (Array.isArray(node) == true && node.length > 1)
        {
            this._displaySelectedText(this._picker.getNodeText(node[0]), true);
        }
        else
        {
            this._displaySelectedText(this._picker.getNodeText(node), false);
        }
    },

    _displaySelectedText: function (text, multiple)
    {
        var control = this._getControl('> button');

        if (multiple)
        {
            text += ', ...';
        }

        control.textContent = text;
    },

    disable: function ()
    {
        if (this._trigger != null)
        {
            this._trigger.disabled = true;
        }
        else if (this._dropDown != null)
        {
            this._dropDown.disabled = true;
        }
    },

    initializeMemberValue: function (memberValue, node)
    {
        if (node == null)
        {
            node = this.SelectedNode;
        }

        var values = [];
        var readableValues = [];

        if (node == null)
        {
            memberValue.Values = this._selectedValue.Value;
            memberValue.Text = this._selectedValue.Text;
            memberValue.HierarchyLevel = this._selectedValue.HierarchyLevel;
        }
        else
        {
            memberValue.Text = this.getNodeText(node);
            memberValue.HierarchyLevel = this.getNodeLevel(node);

            if (this._isTime == true)
            {
                memberValue.ReadableValues = memberValue.Values.map(function (e) { return memberValue.Text; });
            }
            else if (Array.isArray(memberValue.Values))
            {
                memberValue.Values.forEach(function ()
                {
                    memberValue.ReadableValues.push(memberValue.Text);
                });
            }
            else
            {
                memberValue.ReadableValues.push(memberValue.text);
            }
        }
    },

    getNodeLevel: function (node)
    {
        if (node == null)
        {
            return;
        }

        if (this._picker != null)
        {
            return this._picker.getNodeLevel(node);
        }
        else
        {
            return this._getSelectData(node).l;
        }
    },

    getParentNode: function (node)
    {
        if (node == null)
        {
            return;
        }

        if (this._picker != null)
        {
            return this._picker.getParentNode(node);
        }
        else
        {
            var parent = null;
            var data = this._getSelectData(node).p;

            if (data != null)
            {
                parent = {};
                parent.textContent = data.n;
                this._setSelectData(parent, data);
            }

            return parent;
        }
    },

    getNodeText: function (node)
    {
        if (node == null)
        {
            return;
        }

        if (this._picker != null)
        {
            return this._picker.getNodeText(node);
        }
        else
        {
            return node.textContent;
        }
    },

    getNodeValue: function (node)
    {
        if (node == null)
        {
            return;
        }

        var value;

        if (this._picker != null)
        {
            value = this._picker.getNodeValue(node);
        }
        else
        {
            value = this._getSelectData(node).v;
        }

        return value;
    },

    getNodeToken: function (node)
    {
        if (node == null)
        {
            return;
        }

        if (this._picker != null)
        {
            return this._picker.getNodeToken(node);
        }
        else
        {
            return this._getSelectData(node).t;
        }
    },

    _getSelectData: function (node)
    {
        if (node == null)
        {
            return;
        }

        return $(node).data('Dd_SelectData') || {};
    },

    _setSelectData: function (node, data)
    {
        if (node == null)
        {
            return;
        }

        $(node).data('Dd_SelectData', data);
    },

    __properties:
    {
        'SelectedNode':
        {
            get: function ()
            {
                if (this._picker != null)
                {
                    return this._picker.SelectedNode;
                }
                else
                {
                    return this._dropDown.options[this._dropDown.selectedIndex];
                }
            }
        },

        'SelectedValue':
        {
            get: function ()
            {
                return this._selectedValue;
            },

            set: function (value)
            {
                this._selectedValue = value;
            }
        },

        'SelectedValues':
        {
            get: function ()
            {
                return this._selectedValues;
            },

            set: function (value)
            {
                this._selectedValues = value;
            }
        },

        'FirstSelectableLevel':
        {
            get: function ()
            {
                return this._firstSelectableLevel;
            },

            set: function (value)
            {
                this._firstSelectableLevel = value;
            }
        },

        'IsHidingUnselectableLevels':
        {
            get: function ()
            {
                return this._isHidingUnselectableLevels;
            },

            set: function (value)
            {
                this._isHidingUnselectableLevels = value;
            }
        },

        'LastSelectableLevel':
        {
            get: function ()
            {
                return this._lastSelectableLevel;
            },

            set: function (value)
            {
                this._lastSelectableLevel = value;
            }
        },

        'LastVisibleLevel':
        {
            get: function ()
            {
                return this._lastVisibleLevel;
            },

            set: function (value)
            {
                this._lastVisibleLevel = value;
            }
        },

        'HasAllMember':
        {
            get: function ()
            {
                return this._hasAllMember;
            },

            set: function (value)
            {
                this._hasAllMember = value;
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterHierarchyRangeViewer = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._fromParameters = null;
        this._toParameters = null;
    },

    onLoaded: function ()
    {
        this._super();

        var elements = $('.ParameterHierarchyViewer', this.TargetElement).get();
        this._fromParameters.TargetElement = elements[0];
        this._toParameters.TargetElement = elements[1];

        this._fromParameters.DashboardParameterName = null;
        this._toParameters.DashboardParameterName = null;

        this._fromControl = Dundas.Dashboard.ScriptManager.Instance.createObject(Dundas.Dashboard.ParameterHierarchyViewer, this._fromParameters);
        this._toControl = Dundas.Dashboard.ScriptManager.Instance.createObject(Dundas.Dashboard.ParameterHierarchyViewer, this._toParameters);

        this.bindEvent(this._fromControl, 'SelectedValueChanged', this._onPickerSelectedValueChanged);
        this.bindEvent(this._toControl, 'SelectedValueChanged', this._onPickerSelectedValueChanged);
    },

    _onPickerSelectedValueChanged: function (e)
    {
        var param = this.DashboardParameter;

        this._fromControl.updateParameter(param, 0);

        if (param.FilterValues.length > 0)
        {
            param.FilterValues[0].IsRange = true;

            if (param.FilterValues[0].NamedTokenValue == 0)
            {
                this._toControl.updateParameter(param, 1);
                if (param.FilterValues.length > 1)
                {
                    var toValue = param.FilterValues.pop();
                    $(toValue.MemberValues).each(function() { param.FilterValues[0].MemberValues.push(this); });
                }
            }
        }

        this._invalidateParameter();
    },
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterNumericUpDown = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._increment = null;
        this._min = null;
        this._max = null;
        this._places = null;
        this._value = null;
        this._namedTokenValue = null;
        this._isRangePicker = false;
        this._numberFormatRegex = /0+$/;
        this._upButton = null;
        this._downButton = null;
        this._browserPicker = null;
    },

    onLoaded: function ()
    {
        this._super();

        var input = this._getInputElement();

        this._setupBrowserPicker(input);

        if (this._browserPicker != null)
        {
            return;
        }

        this._setupControl(input);
    },

    _setupControl: function (input)
    {
        var isEnabled = input.disabled == false;

        this.bindEvent(input, 'change', this._onInputChanged);
        this.bindEvent(input, 'focus', this._onInputFocus);

        var buttonContainer = this._getButtonContainer();

        var buttons = $('> button', buttonContainer).get();
        this._upButton = buttons[0];
        this._downButton = buttons[1];

        if (isEnabled == true)
        {
            this.bindEvent(buttonContainer, 'click', this._onUpDownButtonClick);
            this.bindEvent(this.TargetElement, 'keyup', this._onKeyUp);
        }

        if (this._namedTokenValue != 0)
        {
            $(input).addClass('NamedToken');
        }
    },

    _setupBrowserPicker: function (currentInput)
    {
        if (this._namedTokenValue != 0)
        {
            return;
        }

        var isUISupported = this._isInputTypeSupported('number', true);

        isUISupported = isUISupported && window.orientation == null;

        if (isUISupported == false)
        {
            return;
        }

        var input = document.createElement('input');
        input.type = 'number';
        input.disabled = currentInput.disabled;
        input.min = this._min;
        input.max = this._max;
        input.step = this._increment;

        input.valueAsNumber = this._value;

        this.bindEvent(input, 'change', this._onInputChanged);

        $(this.TargetElement).html(input);

        this._browserPicker = input;
    },

    _onKeyUp: function (e)
    {
        var key = e.which;

        var isUp = null;

        if (key == 40)
        {
            isUp = false;
        }
        else if (key == 38)
        {
            isUp = true;
        }

        if (isUp != null)
        {
            this._incrementValue(isUp);
            e.preventDefault();
        }
    },

    _onInputFocus: function (e)
    {
        var input = e.target;

        input.select();
    },

    _onInputChanged: function (e)
    {
        var value;

        if (this._browserPicker != null)
        {
            value = this._browserPicker.valueAsNumber;
        }
        else
        {
            var input = this._getInputElement();

            var text = input.value;

            value = parseFloat(text);
        }

        this._setValue(value);

        this._displayValue(this._value);
    },

    _getActualValue: function (value)
    {
        if (value < this._min)
        {
            value = this._min;
        }
        else if (value > this._max)
        {
            value = this._max;
        }

        return value;
    },

    _onUpDownButtonClick: function (e)
    {
        var isUp = null;

        if (e.target == this._upButton)
        {
            isUp = true;
        }
        else if (e.target == this._downButton)
        {
            isUp = false;
        }

        if (isUp != null)
        {
            this._incrementValue(isUp);
        }
    },

    _incrementValue: function (isUp)
    {
        var increment = this._increment;

        if (isUp == false)
        {
            increment = -increment;
        }

        var value = this._value + increment;

        this._setValue(value);
    },

    _setValue: function (value)
    {
        if (isNaN(value) == true)
        {
            return;
        }

        value = this._getActualValue(value);

        if (value == this._value)
        {
            return;
        }

        this._value = value;
        this._namedTokenValue = 0;

        this._displayValue(value);

        $(this).trigger('SelectedValueChanged');

        this._updateParameter();
    },

    _updateParameter: function ()
    {
        if (this._isRangePicker == true)
        {
            return;
        }

        var param = this.DashboardParameter;
        var filterValue = param.createFilterValue();

        var value = param.createTypedValue('d', this._value);

        var memberValue = param.createMemberValue(value, this._value.toString());
        filterValue.MemberValues.push(memberValue);

        param.setFilterValue(filterValue);

        this._invalidateParameter();
    },

    _displayValue: function (value)
    {
        var input = this._getInputElement();

        $(input).removeClass('NamedToken');

        input.value = this._formatValue(value);

        this._setButtonState(this._upButton, value, this._max);
        this._setButtonState(this._downButton, value, this._min);
    },

    _setButtonState: function (button, value, target)
    {
        if (value == target)
        {
            $(button).attr('disabled', 'disabled');
        }
        else
        {
            $(button).removeAttr('disabled');
        }
    },

    _formatValue: function (value)
    {
        var s = value.toString();
        var decimalPointIndex = s.indexOf('.');

        if (decimalPointIndex == -1)
        {
            return s;
        }

        var decimalPlaces = s.length - decimalPointIndex - 1;

        while (decimalPlaces > 1)
        {
            s = value.toFixed(decimalPlaces);

            if (this._numberFormatRegex.test(s) == true)
            {
                s = s.replace(this._numberFormatRegex, '');
                return s;
            }

            decimalPlaces--;
        }

        return value.toString();
    },

    _getInputElement: function ()
    {
        return $('input', this.TargetElement).get(0);
    },

    _getButtonContainer: function ()
    {
        return $('.UpDownContainer', this.TargetElement).get(0);
    },

    __properties:
    {
        'SelectedValue':
        {
            get: function ()
            {
                if (this._namedTokenValue != 0)
                {
                    return new Dundas.Dashboard.NamedToken(this._namedTokenValue);
                }
                else
                {
                    return this._value;
                }
            }
        }
    }
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterRangeNumericUpDown = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();
        this._fromParameters = null;
        this._toParameters = null;
    },

    onLoaded: function ()
    {
        this._super();

        var elements = $('.ParameterNumericUpDown', this.TargetElement).get();
        this._fromParameters._targetElement = elements[0];
        this._toParameters._targetElement = elements[1];

        this._fromParameters._dashboardParameterName = null;
        this._fromParameters._isRangePicker = true;
        this._toParameters._dashboardParameterName = null;
        this._toParameters._isRangePicker = true;

        var sm = this.ScriptManager;
        this._fromControl = sm.createObject(Dundas.Dashboard.ParameterNumericUpDown, this._fromParameters);
        this._toControl = sm.createObject(Dundas.Dashboard.ParameterNumericUpDown, this._toParameters);

        this.bindEvent(this._fromControl, 'SelectedValueChanged', this._onPickerSelectedValueChanged);
        this.bindEvent(this._toControl, 'SelectedValueChanged', this._onPickerSelectedValueChanged);
    },

    _onPickerSelectedValueChanged: function (e)
    {
        var startValue = this._fromControl.SelectedValue;
        var endValue = this._toControl.SelectedValue;

        var param = this.DashboardParameter;
        param.setRangeValues(startValue, startValue.toString(), endValue, endValue.toString());
        
        this._invalidateParameter();
    },
});
﻿/// <reference path="Utility.js" />
/// <reference path="jquery.js" />

Dundas.Dashboard.ParameterTextBox = Dundas.Dashboard.ParameterControl.extend(
{
    init: function ()
    {
        this._super();

        this._allToken = null;
        this._nullToken = null;
        this._selectedToken = null;
        this._textbox = null;
    },

    onLoaded: function ()
    {
        this._super();

        this._textbox = $('input', this.TargetElement).get(0);

        this.bindEvent(this._textbox, 'change', this._onControlChanged);

        this._setTokenSelected(this._selectedToken != null);
    },

    _setTokenSelected: function (isTokenSelected)
    {
        if (isTokenSelected == true)
        {
            $(this._textbox).addClass('NamedToken');
        }
        else
        {
            $(this._textbox).removeClass('NamedToken');
        }
    },

    _onControlChanged: function (e)
    {
        var value = this._textbox.value;

        var param = this.DashboardParameter;
        var filterValue = param.createFilterValue();

        if (this._nullToken != null && value.length == 0)
        {
            filterValue.NamedTokenValue = 1;
            this._textbox.value = this._nullToken.ValueText;
        }
        else if ((this._allToken != null && (value == 'All' || value == this._allToken.ValueText)) || (this._nullToken == null && value.length == 0))
        {
            filterValue.NamedTokenValue = 3;
            this._textbox.value = this._allToken.ValueText;
        }
        else
        {
            var memberValue = param.createMemberValue(value, value);
            filterValue.MemberValues.push(memberValue);
        }

        this._setTokenSelected(filterValue.NamedTokenValue != 0);

        param.setFilterValue(filterValue);

        this._invalidateParameter();
    }
});
