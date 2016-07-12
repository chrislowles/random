// ==UserScript==
// @name         CHF USERSCRIPTS: 1ST EDITION
// @version      1.0
// @description  MAKES EDITS TO ENHANCE CERTAIN PARTS OF THE INTERNET (MADE FOR PERSONAL USE, but you can use it too) :)
// @author       Chris Lowles
// @match        *://*/*
// @grant        none
// @updateURL    https://chrishazfun.github.io/stuff/one.user.js
// ==/UserScript==
/* jshint -W097 */
'use strict';

var _chf, _chf = {
	queryString: function(field, prop) {
		var string = new RegExp("[?&]" + field + "=([^&#]*)", "i").exec(prop);
		return string ? string[1] : (undefined ? undefined : null);
	},
	init: function() {
		if (window.location.href === "chrome-extension://pejkokffkapolfffcgbmdmhdelanoaih/index.html") {
			setInterval(function() {
				document.querySelector('.single-photo__footer, single-photo__overlay, .single-photo__gradient-overlay, .single-photo__header').setAttribute('style', 'display:none');
			}, 100);
		}
		if (window.location.host === 'www.youtube.com') {
			setInterval(function() {
				if (document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]')) {
					document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]').setAttribute('href', '/feed/subscriptions');
				}
				if (document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]')) {
					document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]').setAttribute('href', '/feed/subscriptions');
				}
			}, 100);
		}
		if (window.location.host === "www.bing.com") {
			if (window.location.pathname === "/search") {
				if (_chf.queryString("q", window.location.href)) {
					window.open("//www.google.com/search?q=" + _chf.queryString("q", window.location.href), "_top");
				}
			}
			if (window.location.pathname === '/') {
				location.href = '//www.google.com/';
			}
		}
	}
};

_chf.init();
