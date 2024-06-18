var pomnirizz = false;
var timer = 0;
function create() {
	var camCinematics:FlxCamera = new FlxCamera();
	camCinematics.bgColor = 0;
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(camCinematics, false);
	FlxG.cameras.add(camHUD, false);

	barBottom = new FlxSprite(0, FlxG.height - (FlxG.height / 2)).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
	barBottom.cameras = [camCinematics];
	barBottom.screenCenter(FlxAxes.X);
	add(barBottom);

	barTop = new FlxSprite(0, -FlxG.height + (FlxG.height / 2)).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
	barTop.cameras = [camCinematics];
	barTop.screenCenter(FlxAxes.X);
	add(barTop);

	fade = new FlxSprite(0, 0).makeSolid(FlxG.width*4, FlxG.height*4, FlxColor.BLACK);
	fade.cameras = [camCinematics];
	fade.screenCenter();
	add(fade);
}

function beatHit(curBeat) {
	if (curBeat == 0) {
		camGame.zoom = 1.8;
		camGame.angle = 30;
		FlxTween.tween(camGame, {zoom: 1, angle:0}, 17.35, {ease:FlxEase.quadInOut});
		FlxTween.tween(barBottom, {y: FlxG.height}, 17.35, {ease:FlxEase.quadInOut});
		FlxTween.tween(barTop, {y: -FlxG.height}, 17.35, {ease:FlxEase.quadInOut});
		FlxTween.tween(fade, {alpha:0}, 17.35, {ease:FlxEase.quadOut});

	}
	if (curBeat == 264) pomnirizz = true;
}

function update(elapsed) {
	if (pomnirizz) {
		strumLines.members[3].characters[0].alpha = Math.abs(Math.sin(timer) / 2);
		timer += elapsed;
	} else {
		strumLines.members[3].characters[0].alpha = 0;
	}
}