var qs_json, qs_json = {
    queryString: function(field, prop) {
        var thing = prop;
        var reg = new RegExp("[?&]" + field + "=([^&#]*)", "i");
        var string = reg.exec(thing);
        return string ? string[1] : undefined;
    },
    json: {
        toqs: function(param1) {
            return '?' + Object.keys(param1).map(function(key) {
                return encodeURIComponent(key) + '=' + encodeURIComponent(param1[key]);
            }).join('&');
        },
        parse: function(param1) {
            return param1.json();
        }
    }
};