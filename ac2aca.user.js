// ==UserScript==
// @name         amazon.com to amazon.com.au
// @namespace    https://chrishaz.fun/
// @version      1.1
// @description  basic javascript that redirects amazon.com to amazon.com.au so you don't get your hopes up too quick lol
// @author       chrishazfun
// @match        https://*/*
// @updateURL    https://raw.githubusercontent.com/chrishazfun/stuff/master/ac2aca.user.js
// @downloadURL  https://raw.githubusercontent.com/chrishazfun/stuff/master/ac2aca.user.js
// @grant        none
// ==/UserScript==

(function() {
    // 'use strict';
    switch (window.location.host) {
        case "www.amazon.com":
            window.location.host = "www.amazon.com.au";
        break;
    }
})();
