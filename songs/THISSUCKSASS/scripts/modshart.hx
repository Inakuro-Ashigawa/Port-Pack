import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import flixel.util.FlxTimer;
var curVideo = null;
var black;

function create() {
	strumLines.members[0].characters[1].visible = false;
	strumLines.members[0].characters[2].visible = false;
        curVideo = new FlxVideoSprite();
        //curVideo.onEndReached.add(curVideo.dispose);
        var path = Paths.file("videos/PeakCutscene.mp4");
	curVideo.load(Assets.getPath(path));
	curVideo.scale.set(1.2, 1.2);
	add(curVideo);
	black = new FlxSprite(0, 0);
	black.makeGraphic(100, 100, FlxColor.BLACK);
	black.scale.set(1000, 1000);
	add(black);
	black.alpha = 0;
}

function update() {
	curVideo.x = camGame.scroll.x - 320;
	curVideo.y = camGame.scroll.y - 200;
}

function beatHit(curBeat) {
	if (curBeat == 32) {
		strumLines.members[0].characters[0].visible = false;
		strumLines.members[0].characters[1].visible = true;
	}
	if (curBeat == 329) FlxTween.tween(black, {alpha: 1}, 0.8, {ease:FlxEase.quadInOut});
	if (curBeat == 330) FlxTween.tween(camHUD, {alpha: 0}, 0.8, {ease:FlxEase.quadInOut});
	if (curBeat == 332) curVideo.play();
	if (curBeat == 333) FlxTween.tween(black, {alpha: 0}, 0.8, {ease:FlxEase.quadInOut});
	if (curBeat == 460) {
		FlxTween.tween(camHUD, {alpha: 1}, 1.7, {ease:FlxEase.quadInOut});
	}
	if (curBeat == 464) {
		curVideo.visible = false;
		strumLines.members[0].characters[0].visible = false;
		strumLines.members[0].characters[1].visible = false;
		strumLines.members[0].characters[2].visible = true;
	}
	if (curBeat == 527) {
		strumLines.members[0].characters[0].visible = false;
		strumLines.members[0].characters[1].visible = true;
		strumLines.members[0].characters[2].visible = false;
	}
	if (curBeat = 660) FlxTween.tween(black, {alpha: 0}, 0.8, {ease:FlxEase.quadInOut});

}