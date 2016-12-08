// ==UserScript==
// @name         CHF USERSCRIPTS: 1ST EDITION
// @version      1.0
// @description  Makes edits to enhance certain parts of the Internet (MADE FOR PERSONAL USE, but you can use it too :))
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
		if (window.location.host === 'www.youtube.com') {
			setInterval(function() {
				if (document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]')) {
					document.querySelector('#yt-masthead .yt-masthead-logo-container #logo-container[href="/"]').setAttribute('href', '/feed/subscriptions?flow=2');
				}
				if (document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]')) {
					document.querySelector('#yt-masthead div #yt-masthead-logo-fragment #logo-container map area[href="/"]').setAttribute('href', '/feed/subscriptions?flow=2');
				}
			}, 100);
		}
	}
};

_chf.init();
