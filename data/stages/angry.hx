function create() {
	splash.scale.x = 3;
	splash.scale.y = 0.5;

	fire.visible = false;
	splash.visible = false;
	rain.visible = false;

	camGame.addShader(shader = new CustomShader("bloom"));
	shader.Quality = 100.0;
}

function beatHit(curBeat) {
	switch(curBeat) {
		case 32:
			splash.visible = !splash.visible;
			rain.visible = !rain.visible;
		case 460:
			splash.visible = !splash.visible;
			rain.visible = !rain.visible;
			fire.visible = true;
	}
}
