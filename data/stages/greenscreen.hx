var fade;
var curTarget = 0;
var shader:CustomShader = null;
var charCam:FlxCamera;

var shader:CustomShader = null;
var end = false;

function create() {
	bg = new FlxSprite(0, 0);
	bg.makeGraphic(5000, 5000, 0xFF0F380F);
	insert(members.indexOf(dad), bg);
	fade = new FlxSprite();
	fade.loadGraphic(Paths.image('stages/greenscreen/fade2'), true, 125, 76);
	fade.scale.x = fade.scale.y = 6;
	fade.screenCenter();
	fade.animation.add("idle", [0], 18);
	fade.animation.add("outHold", [4], 18, true);
	fade.animation.add("fade", [0,1,2,3,4,3,2,1,0], 18, false);
	fade.animation.add("fadeIn", [0,1,2,3,4], 18, false);
	fade.animation.add("fadeOut", [4,3,2,1,0], 18, false);
	add(fade);
	fade.camera = camGame;
	dad.screenCenter();
	boyfriend.screenCenter();
	fade.animation.play("outHold");

	shader = new CustomShader("yoshiShaders/cyclesd");
	shader.amount = 0;
	shader.pixel = 1;

	camGame.addShader(shader);
}

function postUpdate() {
	//trace(fade.animation.name + " & " + fade.animation.finished);
	if (fade.animation.name == "fadeOut" && fade.animation.finished) {
		fade.animation.play("idle");
	}
	if (fade.animation.name == "fadeIn" && fade.animation.finished && !end) {
		if (curTarget == 0) {
			dad.visible = true;
		}
		if (curTarget == 1) {
			dad.visible = false;
		}
		fade.animation.play("fadeOut");
	}
	boyfriend.visible = !dad.visible;
	shader.amount = (camGame.zoom - 1) * 50;
}

function beatHit(curBeat) {
	if (curBeat == 0) {
		fade.animation.play("fadeOut");
	}
	if (curBeat == 332) end = true;
}
function onEvent(e) {
	trace(e.event.params[0]);
	if (e.event.name == "Camera Movement") {
		curTarget = e.event.params[0];
		fade.animation.play("fadeIn");
	}
}