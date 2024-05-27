var badCam = false;
function create() {
	phase1();
	camGame.alpha = 0;
	strumLines.members[1].characters[0].visible = false;
}

function postCreate() iconP1.alpha = iconP2.alpha = 0;

function phase1() {
	bg.visible = true;
	strumLines.members[0].characters[0].visible = true;

	skibibg.visible = false;
	skibifg.visible = false;
	strumLines.members[0].characters[1].visible = false;

	badCam = false;
}

function phase2() {
	bg.visible = false;
	strumLines.members[0].characters[0].visible = false;

	skibibg.visible = true;
	skibifg.visible = true;
	strumLines.members[0].characters[1].visible = true;

	badCam = true;
}

function beatHit(curBeat) {
	if (curBeat == 0) camGame.alpha = 1;
	if (curBeat % camZoomingInterval == 0 && badCam) {
		camGame.zoom += camZoomingStrength / 4;
	}
}

function update(elapsed) {
	camGame.scroll.x = 40;
	camGame.scroll.y = -50;
	FlxG.camera.followLerp = 0.00;
	if (camGame.zoom > defaultCamZoom && badCam) {
		camGame.zoom -= elapsed * camZoomingStrength * 2;
	}
	if (badCam) {
		camHUD.zoom = (camGame.zoom - defaultCamZoom) / 4 + 1;
	}
}

function hideHUD() FlxTween.tween(camHUD, {alpha: 0, zoom:1.2}, 1, {ease:FlxEase.sineOut});
function showHUD() {camHUD.alpha = 1; camHUD.zoom = 1.8;}

function end() {
	badCam = false;
	FlxTween.tween(camGame, {alpha: 0, zoom:0.7}, 3.5, {ease:FlxEase.sineOut});
}