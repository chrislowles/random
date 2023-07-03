function QS(field, prop) {
	var string = new RegExp(`[?&]${field}=([^&#]*)`, "i").exec(prop);
	return string ? string[1] : (undefined ? undefined : null);
}

function jsonToQS(param) {
	return '?' + Object.keys(param).map(function(key) {
		return `${encodeURIComponent(key)}=${encodeURIComponent(param[key])}`;
	}).join('&');
}