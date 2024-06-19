import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import flixel.util.FlxTimer;
import flxanimate.FlxAnimate;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import openfl.filters.ShaderFilter;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTweenType;
import funkin.game.Note;

var blue:CustomShader;
var Peaknote = new CustomShader('Silly/3D');

var StrumsCamera = new FlxCamera(); 

introLength = -10;
var bars:FlxSprite;
var camExtra:FlxCamera;
var cutsceneCamera:FlxCamera;
var camZoomLock = false;
var lyric:FlxSprite;
var HollowPurple = new FlxVideoSprite();
var dadZoom:Float = 0.625;
var bfZoom:Float = .5;
var elapsedTime:Float = 0;
var i:Int = 0;


function onNoteCreation(e) {
 e.note.alpha = 0.6;

}

function onPostStrumCreation() {

      for (e in strumLines.members[0]) {
            e.camera = camGame;
            e.scrollFactor.set(1,1);
            e.alpha = 0.6;
      }

}



function create() {
    player.cpu = true;
    remove(dad);


    camSilly = new FlxCamera();
	camSilly.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camSilly, false);
	FlxG.cameras.add(camHUD, false);

    blue = new CustomShader('Silly/blue');
    blue.hue = 1.3;
    blue.pix = 0.00001;

    if (FlxG.save.data.Videos){
        Opening = new FlxVideo();
        Opening.onEndReached.add(Opening.dispose);
        Opening.load(Assets.getPath(Paths.file("videos/Silly/open.mp4")));


        HollowPurple.load(Assets.getPath(Paths.file("videos/Silly/Hollow Purple.mp4")));  
        HollowPurple.cameras = [camSilly];
        //mutes Hollow Purple lol
        HollowPurple.bitmap.volume = 0;
        add(HollowPurple);
    }

    lyric  = new FlxSprite(910 + 45, 600 + -5);
    lyric.frames = Paths.getFrames('misc/lyric/lyric');
    lyric.animation.addByPrefix('Proud', 'billy', 24.8 ,false);
    lyric.antialiasing = true;
    lyric.scale.set(1.37,1.35);
    lyric.alpha = 0.0000001;
    insert(11, lyric);

    bars = new FlxSprite().loadGraphic(Paths.image('misc/bars'));
    bars.cameras = [camHUD];
    add(bars);

    lyrics = new FlxText();
    lyrics.setFormat(Paths.font("Times New Roman.ttff"), 48, 0xFFcfa92d,FlxTextBorderStyle.OUTLINE, "center");
    lyrics.borderSize = 2;
    lyrics.cameras = [camHUD];
    lyrics.screenCenter(FlxAxes.X);
    lyrics.y = FlxG.height - lyrics.height;
    lyrics.text = '';
    add(lyrics);

    blackScreen = new FlxSprite().makeGraphic(1, 1, 0xFF000000);
    blackScreen.scale.set(FlxG.width * 2,FlxG.height * 2);
    blackScreen.updateHitbox();
    blackScreen.scrollFactor.set();
    blackScreen.screenCenter();
    blackScreen.alpha = 0;
    add(blackScreen);

    broken.useColorTransform = true;


}
//pauses videos
function onSubstateOpen(event) {
if (HollowPurple != null && Opening != null && paused)
    Opening.pause(); 
    HollowPurple.pause();
}
function onSubstateClose(event){ 
    if (HollowPurple != null && Opening != null && paused) 
    Opening.resume(); 
    HollowPurple.resume();
}
function focusGained(){
    if (HollowPurple != null && Opening != null && !paused) 
    Opening.resume(); 
    HollowPurple.resume();
}

function onCountdown(event)
    event.cancel();
    camGame.alpha = 0.00000000000001;
    camHUD.alpha = 0.00000000000001;

function onSongStart(){
    if (FlxG.save.data.Videos)Opening.play();
    camGame.alpha = 1;
    camHUD.alpha = 1;
}
function meway(){
    HollowPurple.play();
    camHUD.alpha = 0.00000000000001;
    vocals.volume = 2;
}
function fadein(){
    FlxTween.tween(camHUD, {alpha: 1}, 2, {ease: FlxEase.quartOut});
}

function update(elapsed:Float){
 if (camZoomLock) return;

    switch (curCameraTarget){
        case 0: defaultCamZoom = dadZoom;
        case 1: defaultCamZoom = bfZoom;
    }
    elapsedTime += elapsed;
    for (e in strumLines.members[0]) {
            i += 1;
            if(i > strumLines.members.length) {
                  i = 0;
            }
            e.y = dad.y + -300;
            e.alpha = 0.3;
      }
}
function things(eventName, value1){
if(eventName == "ill make"){
  switch(value1){
    case 'vid':
        if (FlxG.save.data.Videos)HollowPurple.play();
        inst.volume = 2;
        camHUD.alpha = 1;
        //dont ask.....
        lyric.alpha = 0.00000001;
        dad.alpha = 1;
        camGame.flash(0xFF000000, 2);
        camGame.zoom = 1.1;   
        blackScreen.alpha = 0;
        defaultCamZoom = 0.5;

     case 'black':
         FlxTween.tween(blackScreen, {alpha: 1}, .8, {ease: FlxEase.quadOut});
         FlxTween.num(0.6, 1.125, 0.75, {ease: FlxEase.backIn, onUpdate: (s:FlxTween)->{
         defaultCamZoom = s.value;
         }});
      case 'pre':
      var shit = [scoreTxt];
      playerStrums.forEach(function(spr)
      {
	   shit.push(spr);
      });


      for(s in shit){ FlxTween.tween(s, {alpha: 0}, 2, {ease: FlxEase.quadIn}); }
      camZoomLock = true;
      defaultCamZoom = 0.5;

    case 'anim':    
        vocals.volume = .8;
        inst.volume = .7;
        lyric.alpha = 1;
        dad.alpha = 0.0000000001;
        lyric.animation.play('Proud');
     for (i in playerStrums.members) 
	    FlxTween.tween(i, {x: i.x - 300}, .01, {ease: FlxEase.smootherStepInOut});

    case 'break mirror':
        normal.alpha = 0.0000000000001;
        FlxTween.num(255, 0, 1.75, {ease: FlxEase.quadOut, onUpdate: function(twn)        {       broken.setColorTransform(1,1,1,1,twn.value,twn.value,twn.value,0); } } );
        camera.shake(0.01, 0.25);
        camGame.shake(0.01, 0.25);
        FlxG.sound.play(Paths.sound("SB/mirror_break"), 10);

     case 'no-vid':
        if (FlxG.save.data.Videos)remove(HollowPurple);
        blackScreen.alpha = 1;
        FlxG.camera.addShader(blue);
        camHUD.addShader(blue);
    case 'fadein':
        for (i in playerStrums.members) 
	     FlxTween.tween(i, {alpha:1}, 2, {ease: FlxEase.smootherStepInOut});

    case 'fadeout':
         FlxTween.tween(blackScreen, {alpha: 0}, 2, {ease: FlxEase.quadOut});
        for (i in playerStrums.members) 
	     FlxTween.tween(i, {x: i.x + 300}, 2, {ease: FlxEase.smootherStepInOut});
    case 'end':
        blackScreen.alpha = 1;

  }
 }
}
function postCreate(){



    healthBar.visible = false;
    healthBarBG.visible = false;
    for (i in [scoreTxt, missesTxt, accuracyTxt,iconP2])
     i.y -= 40;

    var vig = new FlxSprite().loadGraphic(Paths.image('misc/vignette'));
    vig.cameras = [camHUD];
    add(vig);

    for (i in 0...cpuStrums.members.length) {
		cpuStrums.members[i].x = i * 200 + 800;
    }
}
function setzoom(zoom){
    defaultCamZoom = zoom;
    FlxG.camera.zoom = zoom;
}
function postUpdate(){
   iconP2.x = -999;
   insert(999, dad);
}
function singing(words){
    trace(words);
    lyrics.text = words;
    lyrics.screenCenter(FlxAxes.X);       
}