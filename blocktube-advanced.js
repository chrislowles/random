(a, b) => {
	if (a.title && a.title.match(/((Huge|Big|Major) (.*) (Drama|Story))/g)) return true;
	console.log(a, b);
	return false;
}