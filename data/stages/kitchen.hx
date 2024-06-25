import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
import openfl.text.TextFormat;
import openfl.text.TextField;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
var rotting = new FlxVideoSprite();
var camOrange:FlxCamera;
var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var what:FlxText; 
var timeTxt:FlxText; // I forgot why I made these variables.......
var hudTxt:FlxText;
var hudTxtTween:FlxTween;
var cutsceneCamera:FlxCamera;
var cutscene:Bool = false;
    

function create() {
    camOrange = new FlxCamera();
	camOrange.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camOrange, false);
	FlxG.cameras.add(camHUD, false);

    rotting.load(Assets.getPath(Paths.file("videos/orange/rottenSmoothie_cutscene_noaudio.mp4")));  
    rotting.cameras = [camOrange];
    rotting.bitmap.onEndReached.add(rotting.destroy);
    add(rotting);
    rotting.play();
    rotting.pause();
    rotting.alpha = 0.000001;

    Black.alpha = 0.0000001;

    timeTxt = new FlxText(0, 19, 400, "X:XX", 22);
    timeTxt.setFormat(Paths.font("orange/CREABBRG.ttf"), 22, 0xFF9B73, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    hudTxt = new FlxText(0, 700, FlxG.width, "Score: 0");
    hudTxt.setFormat(Paths.font("orange/CREABBRG.ttf"), 15, 0xFF9B73, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("misc/psychTimeBar"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,FlxColor.WHITE);
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);
    add(hudTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];

    defaultCamZoom = camGame.zoom = camera.zoom =  0.35;
    
}
function onSongStart() for (i in [timeBar, timeBarBG, timeTxt]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
//pauses video
function onSubstateOpen(event) {
    if (rotting != null  && rotting.alpha == 1 && paused)
        rotting.pause(); 
}
function onSubstateClose(event){ 
    if (rotting != null && rotting.alpha == 1 &&  paused)
        rotting.resume(); 
    }
function focusGained(){
    if (rotting != null && rotting.alpha == 1 && paused)
        rotting.resume(); 
}
function PeakVideo(){
    rotting.play();
    rotting.alpha = 1;
    what.alpha = 0;

    cutscene = true;
    defaultCamZoom = .2;
    bg2.alpha = 0.001;
    
    playerStrums.members[0].x = 320;
    playerStrums.members[1].x = 440;
    playerStrums.members[2].x = 700;
    playerStrums.members[3].x = 810;
}
function postUpdate(){
    iconP2.x = 220;
    iconP2.y = 550;
    iconP1.x = 890;
    iconP1.y = 550;
    if (cutscene){
        for (i in cpuStrums.members){
            healthOverlay.alpha = iconP1.alpha = iconP2.alpha = healthBar.alpha = i.alpha = 0;
            i.x = 9999;
        }
        
    }
}
function update(elapsed:Float) {
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }
    
    if (songScore > 0 ) hudTxt.text = "Score: " + songScore;   


}

function postCreate(){ 
    //player.cpu = true; 
    
    healthOverlay = new FlxSprite().loadGraphic(Paths.image("stages/kitchen/healthBarOrange"));
    healthOverlay.cameras = [camHUD];
    Black.cameras = [camHUD];
    Black.screenCenter();
    healthOverlay.screenCenter(FlxAxes.x);
    healthBar.screenCenter(FlxAxes.x);
    healthOverlay.y = 580;
    healthBar.y = 630;
    healthBar.numDivisions = 900;
    insert(members.indexOf(iconP1), healthOverlay);
    healthBarBG.visible = false;
    healthBar.scale.set(.7,4);

    for (i in [missesTxt, accuracyTxt, scoreTxt]) i.visible = false;

    //fore centerd text

    what = new FlxText(0, 19, 400, "WHAT?", 22);
    what.setFormat(Paths.font("orange/CREABBRG.ttf"), 100, FlxColor.RED, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    what.antialiasing = true;
    what.scrollFactor.set();
    what.alpha = 0.00001;
    what.cameras = [camOrange];
    what.borderColor = 0xFF000000;
    what.borderSize = 2;
    what.screenCenter();
    add(what);

}
function fade(){
    camGame.alpha = 1;
    FlxTween.tween(camHUD, {alpha: 1}, 4, {ease: FlxEase.circOut});
}
function tweens(){
    Black.alpha = 1;
    FlxTween.tween(Black, {alpha:0.00001}, 1, {ease: FlxEase.circOut});
    bg.alpha = 0.001;
}
function apple(){
    camHUD.alpha = 0.001;
    camGame.alpha = 0.001;
    what.alpha = 1;
}
function over(){
    what.text = "IT'S";
    what.color = 0xFF9B73;
    what.alpha = 1;
}
function over2(){
    what.alpha = 0.001;
}