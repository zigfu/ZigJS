var goto = (function() {
	var prefix = "/host/"

	paths = {
		home : "index.html",
		music : "musicv3/host.html",
		jsnes : "jsnes/index.html",
		youtube : "youtubev2/index.html",
		slides : "slideviewer/slides.html"
	}

	function goto(page) {
		if (!paths.hasOwnProperty(page)) return;
		var url = prefix + paths[page];
		document.location.pathname = url;
	}

	return goto;
}())