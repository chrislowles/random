var s, s = {
    feed: function(param1) {
        window.fetch(param1).then(s.json.parse).then(function(d) {
            console.log(d);
        });
    },
    holder: function(param1) {
        
    }
};