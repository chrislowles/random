var qs_json, qs_json = {
  // s.queryString()
  queryString: function(field, prop) {
    var thing = prop;
    var reg = new RegExp("[?&]" + field + "=([^&#]*)", "i");
    var string = reg.exec(thing);
    return string ? string[1] : undefined;
  },
  // s.json()
  json: {
    toqs: function(param1) {
      // JSON to Query String
      return '?' + Object.keys(param1).map(function(key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(param1[key]);
      }).join('&');
    },
    parse: function(param1) {
      // JSON Parsing
      return param1.json();
    }
  }
}
