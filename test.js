// blocktube blocking regex in title
video => {
	if (video.title && video.title.match(/((Huge|Big|Major) (.*) (Drama|Story)|(.*) Is Finished|The (.*) (Drama|Story) Just Got (Worse)|The ([\w\d _-\/]) Of (.*))/g)) return true;
	console.log(video);
	return false;
}