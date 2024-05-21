var fade = new FlxSprite();
var curTarget:Int = 0;
var charCam:FlxCamera;
var end:Bool = false;

function create() {
	insert(members.indexOf(dad), bg = new FlxSprite().makeGraphic(5000, 5000, 0xFF0F380F));

	add(fade = new FlxSprite().loadGraphic(Paths.image('stages/greenscreen/fade2'), true, 125, 76).screenCenter());
	fade.scale.set(6, 6);
	fade.animation.add("idle", [0], 18);
	fade.animation.add("outHold", [4], 18, true);
	fade.animation.add("fade", [0,1,2,3,4,3,2,1,0], 18, false);
	fade.animation.add("fadeIn", [0,1,2,3,4], 18, false);
	fade.animation.add("fadeOut", [4,3,2,1,0], 18, false);
	fade.camera = camGame;
	fade.animation.play("outHold");
	
	dad.screenCenter();
	boyfriend.screenCenter();

	camGame.addShader(shader = new CustomShader("yoshiShaders/cyclesd"));
	shader.amount = 0;
	shader.pixel = 1;
}

function postUpdate() {
	//trace(fade.animation.name + " & " + fade.animation.finished);
	if (fade.animation.name == "fadeOut" && fade.animation.finished)
		fade.animation.play("idle");
	if (fade.animation.name == "fadeIn" && fade.animation.finished && !end) {
		dad.visible = curTarget == 0;
		fade.animation.play("fadeOut");
	}
	boyfriend.visible = !dad.visible;
	shader.amount = (camGame.zoom - 1) * 50;
}

function beatHit(curBeat:Int) {
	if (curBeat == 0) fade.animation.play("fadeOut");
	if (curBeat == 332) end = true;
}
function onEvent(e) {
	trace(e.event.params[0]);
	if (e.event.name == "Camera Movement") {
		curTarget = e.event.params[0];
		fade.animation.play("fadeIn");
	}
}
