function load(url, force) {
	var ext = /^.+\.(js|css|less)$/m.exec(url);
	return new Promise(function(yes, no) {
		if (ext === null || ext === "js" || force === "js") {
			var asset = document.createElement("script");
			asset.src = url;
			asset.onload = () => yes(asset);
			asset.onerror = () => no(new Error(`Asset load error for ${url}`));
			document.getElementsByTagName("head").append(asset);
		}
		if (ext === "css" || force === "css") {
			var asset = document.createElement("link");
			asset.rel = "stylesheet";
			asset.type = "type/css";
			asset.href = url;
			asset.onload = () => yes(asset);
			asset.onerror = () => no(new Error(`Asset load error for ${url}`));
			document.getElementsByTagName("head").append(asset);
		}
		if (ext === "less" || force === "less") {
			if (typeof less === "undefined") {
				load("//cdn.jsdelivr.net/npm/less").then(a => {
					window.fetch(url).then(a => {
						return a.text();
					}).then(a => {
						less.render(a).then(a => {
							var asset = document.createElement("style");
							asset.innerHTML = a.css;
							asset.onload = () => yes(asset);
							asset.onerror = () => no(new Error(`Asset load error for ${url}`));
							document.getElementsByTagName("head").append(asset);
						});
					});
				});
			} else {
				window.fetch(url).then(a => {
					return a.text();
				}).then(a => {
					less.render(a).then(a => {
						var asset = document.createElement("style");
						asset.innerHTML = a.css;
						asset.onload = () => yes(asset);
						asset.onerror = () => no(new Error(`Asset load error for ${url}`));
						document.getElementsByTagName("head").append(asset);
					});
				});
			}
		}
	});
}
