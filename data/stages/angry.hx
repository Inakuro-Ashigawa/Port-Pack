function create() {
	splash.scale.x = 3;
	splash.scale.y = 0.5;
	fire.visible = splash.visible = rain.visible = false;
	camGame.addShader(shader = new CustomShader("bloom"));
	shader.Quality = 100.0;
}

function beatHit(curBeat) {
	if (curBeat == 32 || curBeat == 460) {
		splash.visible = !splash.visible;
		rain.visible = !rain.visible
	}
	if (curBeat == 460) fire.visible = true;
}
