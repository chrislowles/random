// ==UserScript==
// @name         CHF USERSCRIPTS: 1ST EDITION
// @version      1.0
// @description  MAKES EDITS TO ENHANCE CERTAIN PARTS OF THE INTERNET :)
// @author       Chris Lowles
// @match        *://*/*
// @grant        none
// @updateURL    https://chrishazfun.github.io/userscripts/one/main.user.js
// ==/UserScript==
/* jshint -W097 */
'use strict';

chf_load = (function (doc) {
    var env,
        head,
        pending = {},
        pollCount = 0,
        queue = {css: [], js: []},
        styleSheets = doc.styleSheets;
    function createNode(name, attrs) {
        var node = doc.createElement(name), attr;
        for (attr in attrs) {
            if (attrs.hasOwnProperty(attr)) {
                node.setAttribute(attr, attrs[attr]);
            }
        }
        return node;
    }
    function finish(type) {
        var p = pending[type],
            callback,
            urls;
        if (p) {
            callback = p.callback;
            urls = p.urls;
            urls.shift();
            pollCount = 0;
            if (!urls.length) {
                callback && callback.call(p.context, p.obj);
                pending[type] = null;
                queue[type].length && load(type);
            }
        }
    }
    function getEnv() {
        var ua = navigator.userAgent;
        env = {
            async: doc.createElement('script').async === true
        };
        (env.webkit = /AppleWebKit\//.test(ua))
            || (env.ie = /MSIE|Trident/.test(ua))
            || (env.opera = /Opera/.test(ua))
            || (env.gecko = /Gecko\//.test(ua))
            || (env.unknown = true);
    }
    function load(type, urls, callback, obj, context) {
        var _finish = function () { finish(type); },
            isCSS   = type === 'css',
            nodes   = [],
            i, len, node, p, pendingUrls, url;
        env || getEnv();
        if (urls) {
            urls = typeof urls === 'string' ? [urls] : urls.concat();
            if (isCSS || env.async || env.gecko || env.opera) {
                queue[type].push({
                    urls    : urls,
                    callback: callback,
                    obj     : obj,
                    context : context
                });
            } else {
                for (i = 0, len = urls.length; i < len; ++i) {
                    queue[type].push({
                        urls    : [urls[i]],
                        callback: i === len - 1 ? callback : null, // callback is only added to the last URL
                        obj     : obj,
                        context : context
                    });
                }
            }
        }
        if (pending[type] || !(p = pending[type] = queue[type].shift())) {
            return;
        }
        head || (head = doc.head || doc.getElementsByTagName('head')[0]);
        pendingUrls = p.urls.concat();
        for (i = 0, len = pendingUrls.length; i < len; ++i) {
            url = pendingUrls[i];
            if (isCSS) {
                node = env.gecko ? createNode('style') : createNode('link', {
                    href: url,
                    rel: 'stylesheet'
                });
            } else {
                node = createNode('script', {src: url});
                node.async = false;
            }
            node.className = 'lazyload';
            node.setAttribute('charset', 'utf-8');
            if (env.ie && !isCSS && 'onreadystatechange' in node && !('draggable' in node)) {
                node.onreadystatechange = function () {
                    if (/loaded|complete/.test(node.readyState)) {
                        node.onreadystatechange = null;
                        _finish();
                    }
                };
            } else if (isCSS && (env.gecko || env.webkit)) {
                if (env.webkit) {
                    p.urls[i] = node.href; // resolve relative URLs (or polling won't work)
                    pollWebKit();
                } else {
                    node.innerHTML = '@import "' + url + '";';
                    pollGecko(node);
                }
            } else {
                node.onload = node.onerror = _finish;
            }
            nodes.push(node);
        }
        for (i = 0, len = nodes.length; i < len; ++i) {
            head.appendChild(nodes[i]);
        }
    }
    function pollGecko(node) {
        var hasRules;
        try {
            hasRules = !!node.sheet.cssRules;
        } catch (ex) {
            pollCount += 1;
            if (pollCount < 200) {
                setTimeout(function () { pollGecko(node); }, 50);
            } else {
                hasRules && finish('css');
            }
            return;
        }
        finish('css');
    }
    function pollWebKit() {
        var css = pending.css, i;
        if (css) {
            i = styleSheets.length;
            while (--i >= 0) {
                if (styleSheets[i].href === css.urls[0]) {
                    finish('css');
                    break;
                }
            }
            pollCount += 1;
            if (css) {
                if (pollCount < 200) {
                    setTimeout(pollWebKit, 50);
                } else {
                    finish('css');
                }
            }
        }
    }
    return {
        css: function (urls, callback, obj, context) {
            load('css', urls, callback, obj, context);
        },
        js: function (urls, callback, obj, context) {
            load('js', urls, callback, obj, context);
        }
    };
})(this.document);

var chf_app, chf_app = {
	queryString: function(field, prop) {
		var href = prop;
		var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
		var string = reg.exec(href);
		return string ? string[1] : undefined;
	},
	init: function() {
		if (window.location.host === 'www.youtube.com') {
			chf_load.css('//chrishazfun.github.io/userscripts/one/youtube.css');
			setInterval(function() {
				if (document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]')) {
					document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]').setAttribute('href', '/feed/subscriptions');
				}
				if (document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]')) {
					document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]').setAttribute('href', '/feed/subscriptions');
				}
			}, 100);
		}
		if (window.location.host === 'www.bing.com') {
			if (window.location.pathname === '/search') {
				if (queryString('q', window.location.href)) {
					location.href = '//www.google.com/search?q=' + queryString('q', window.location.href);
				}
			}
			if (window.location.pathname === '/') {
				location.href = '//www.google.com/';
			}
		}
	}
};

chf_app.init();
