
var tween:FlxTween = null;
var bouncy = false;
var defSX = 0;
var defSY = 0;
var defY = 0;
function postCreate() {
	camGame.zoom = 1;
	defaultCamZoom = 1;
	tween = FlxTween.tween(camGame, {zoom: 1}, 0.8, {ease: FlxEase.quadIn});
	tween.cancel();
	for (strums in strumLines.members) {
		for (strum in strums.members) {
			defSX = strum.scale.x;
			defSY = strum.scale.y;
			defY = strum.y;
		}
	}
}

function update(elapsed) {
	//camHUD.zoom += elapsed / 100;
	camHUD.zoom = (camGame.zoom - defaultCamZoom) * 2 + 1;
}

function beatHit(curBeat) {
	switch (curBeat) {
		case 0:
		trace("yeah");
		case 31:
		tween = FlxTween.tween(camGame, {zoom: 1.05}, 0.6, {ease: FlxEase.quadIn});
		case 32:
		tween.cancel();
		case 127:
		tween = FlxTween.tween(camGame, {zoom: 1.05}, 0.6, {ease: FlxEase.quadIn});
		case 128:
		tween.cancel();
		case 191:
		tween = FlxTween.tween(camGame, {zoom: 1.05}, 0.6, {ease: FlxEase.quadIn});
		case 192:
		tween.cancel();
		case 254:
		tween = FlxTween.tween(camGame, {zoom: 1.05}, 1.2, {ease: FlxEase.quadIn});
		case 256:
		tween.cancel();
		bouncy = true;
		case 318:
		tween = FlxTween.tween(camGame, {zoom: 1.05}, 1.2, {ease: FlxEase.quadIn});
		case 320:
		tween.cancel();
		bouncy = false;
	}
	if (bouncy == true) {
		for (strums in strumLines.members) {
			for (strum in strums.members) {
				//set the values
				strum.scale.x = defSX + 0.1;
				strum.scale.y = defSY - 0.1;
				//tween them!!!!
				FlxTween.tween(strum.scale, {x:defSX, y:defSY}, 0.25, {type:FlxTween.ONESHOT, ease:FlxEase.quadOut});
				//camGame.zoom += 0.1 / 100;
				//camHUD.zoom += 0.05 / 100;
			}
		}
		tween.cancel();
		camHUD.y = 0;
		tween = FlxTween.tween(camHUD, {y:-20}, 0.20, {type:FlxTween.ONESHOT, ease:FlxEase.quadOut, onComplete:fall});
	}
}
//oh yeah this is after the camHUD tween so it "falls" back
function fall(tween:FlxTween) {
	tween = FlxTween.tween(camHUD, {y:0}, 0.20, {type:FlxTween.ONESHOT, ease:FlxEase.quadIn});
}