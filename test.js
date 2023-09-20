// parsed settings for mastodon instance
JSON.parse(document.querySelector("#initial-state").innerHTML);

// unsubscribe from all channels (piped video instance)
document.querySelectorAll("div.p-1.rounded-lg.border-gray-500.border.m-2.col > .w-full.mt-2.btn").forEach(a => a.click());

// blocktube advanced blocking
video => {
	if (video.title && video.title.match(/((Huge|Big|Major) (.*) (Drama|Story)|(.*) Is Finished|The (.*) (Drama|Story) Just Got (Worse)|The ([\w\d _-\/]) Of (.*))/g)) return true;
	console.log(video);
	return false;
}