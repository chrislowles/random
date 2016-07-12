var qs_json, qs_json = {
    queryString: function(field, prop) {
		var string = new RegExp("[?&]" + field + "=([^&#]*)", "i").exec(prop);
		return string ? string[1] : (undefined ? undefined : null);
    },
    json: {
        toQS: function(param1) {
            return '?' + Object.keys(param1).map(function(key) {
                return encodeURIComponent(key) + '=' + encodeURIComponent(param1[key]);
            }).join('&');
        },
        parse: function(param1) {
            return param1.json();
        }
    }
};