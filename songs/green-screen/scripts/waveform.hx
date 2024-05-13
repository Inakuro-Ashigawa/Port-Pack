import funkin.backend.utils.AudioAnalyzer;
import flixel.FlxCamera;
var analyzer:AudioAnalyzer;
var peakGroup:FlxGroup;
var start = false;

var waveCam:FlxCamera;

function postCreate() {
	analyzer = new AudioAnalyzer(inst);
	peakGroup = new FlxGroup(500);
	//FlxG.cameras.add(camGame, true);
	//FlxG.cameras.add(camHUD, true);
	for (i in 0...62) {
		var peak = new FlxSprite(22 * i - 4, 350);
		peak.makeGraphic(11, 5, FlxColor.fromString("#306230"));
		insert(members.indexOf(dad), peak);
		peakGroup.add(peak);
		peak.visible = false;
	}
}

function beatHit(curBeat) if (curBeat == 0) start = true;

function update(elapsed) {

	if (start) for (i in 0...peakGroup.length) {
		peakGroup.members[i].visible = true;
		var curPeak = analyzer.analyze(inst.time + (peakGroup.length - i), inst.time + (peakGroup.length - i) + 4);
		peakGroup.members[i].scale.y = FlxMath.lerp(peakGroup.members[i].scale.y, curPeak * 100, 0.1);
		//peakGroup.members[i].color = FlxColor.fromRGB(255 - curPeak * 50, 255 - curPeak * 50, 255 - curPeak * 50, 1);
	}
	//camHUD.zoom = FlxMath.lerp(camHUD.zoom, 1 + analyzer.analyze(inst.time, inst.time + 1) / 10, 0.1);
	//camGame.zoom = FlxMath.lerp(camGame.zoom, defaultCamZoom + analyzer.analyze(inst.time, inst.time + 1) / 5, 0.05);

}