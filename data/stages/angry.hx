var shader:CustomShader = null;
function create() {
	splash.scale.x = 3;
	splash.scale.y = 0.5;
	fire.visible = false;
	splash.visible = false;
	rain.visible = false;
	shader = new CustomShader("bloom");
	camGame.addShader(shader);
	shader.Quality = 100.0;
}

function beatHit(curBeat) {
	if (curBeat == 32) {
		splash.visible = true;
		rain.visible = true;
	}
	if (curBeat == 460) {
		fire.visible = true;
		splash.visible = false;
		rain.visible = false;
	}
}