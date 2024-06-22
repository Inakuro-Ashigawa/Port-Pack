
var dadZoom:Float = .5;
var bfZoom:Float = .7;
var __timer:Float = 0;
var peachCuts:FlxSprite;
var iconGF:FlxSprite;
var yoshi = null;
var cancelCameraMove:Bool = false;

var float:Bool = false;
function postCreate(){

    fireR.flipX = true;

    platform2  = new FlxSprite(-1100, -600).loadGraphic(Paths.image('stages/exesequel/SS_foreground'));
    platform2.scrollFactor.set(1.3, 1.3);
    add(platform2);

    boyfriend.cameraOffset.y = 30;
    dad.cameraOffset.y = 30;

    
    peachCuts = new FlxSprite(-160, -100);
    peachCuts.scrollFactor.set(1,1);
    peachCuts.frames = Paths.getSparrowAtlas('stages/exesequel/Peach_EXE_death');
    peachCuts.animation.addByPrefix('floats', "PeachFalling1", 24, true);
    peachCuts.animation.addByPrefix('fall', "PeachFalling2", 24, false);
    peachCuts.animation.addByPrefix('dies', "PeachDIES", 24, false);
    peachCuts.alpha = 0.000001;
    add(peachCuts);

    //john dick icon
    iconGF = new FlxSprite().loadGraphic(Paths.image('icons/SS_Koopa'));
    iconGF.width = iconGF.width / 2;
    iconGF.loadGraphic(Paths.image('icons/SS_Koopa'), true, Math.floor(iconGF.width), Math.floor(iconGF.height));
    iconGF.animation.add("win", [0], 10, true);
    iconGF.animation.add("lose", [1], 10, true);
    iconGF.cameras = [camHUD];
}
function beathit(curBeat){
    if (curBeat % 2 == 0){
        starmanGF.animation.play('danceRight', true);
    }
    else{
        starmanGF.animation.play('danceLeft', true);
    }
}
function update(elapsed:Float){
   
       switch (curCameraTarget){
           case 0: defaultCamZoom = dadZoom;
           case 1: defaultCamZoom = bfZoom;
       }
       __timer += elapsed;
       if (float){
        gf.x = (100* -2*Math.sin(__timer));
        gf.y = (1 +10*Math.cos(__timer));
       }
       iconGF.x = iconP2.x - 70;
       iconGF.scale.set(iconP1.scale.x, iconP1.scale.y);

        if(health > 1.6){
            iconGF.animation.play('lose');
        }else{
            iconGF.animation.play('win');
        }
    }
//events but better than before lmao
function JohnDickApper(){
    add(iconGF);
    iconGF.y = (!downscroll ? 820 : -150);
    FlxTween.tween(iconGF, {y: iconP2.y - (!downscroll ? 35 : -15)}, 3, {ease: FlxEase.expoOut});

    FlxTween.tween(gf, {y: 0}, 3, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
    {
		FlxTween.tween(gf, {y: gf.y - 80}, 2, {ease: FlxEase.quadInOut, type: 4});
    }});
    FlxTween.tween(gf, {x: gf.x - 100}, 3, {ease: FlxEase.quadInOut, type: 4});
} 
function zoomoutBF(){
    bfZoom = .5;
}
function basezoom(){
    bfZoom = .7;
    dadZoom = .5; 
}
function zoom(){
    cancelCameraMove = true;
    //FlxTween.tween(camFollow, {y: -3404, x: 589}, 5, {ease: FlxEase.linear});
    FlxTween.tween(camFollow, {x: 999, y: 450}, .6, {ease: FlxEase.quadInOut});
    FlxTween.tween(camGame, {zoom: 0.4}, 1.5, {ease: FlxEase.quadInOut});
}
function back(){
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
    cancelCameraMove = false;
    });
}
function leave(){
    yoshi = strumLines.members[3].characters[0];
    yoshi.x = -20;
    yoshi.scrollFactor.set(0.55, 0.55);
    yoshi.y = -1200;

    FlxTween.tween(iconGF, {y: (!downscroll ? 820 : -150)}, 1.5, {ease: FlxEase.expoIn});
    FlxTween.tween(gf, {x: 3500}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(gf, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
        {
            gf.alpha = 0.0001;
            yoshi.playAnim("prepow", true);
            FlxTween.tween(yoshi, {y: 20}, 0.20, {onComplete: function(twn:FlxTween)
                {
                    cancelCameraMove = true;
                    FlxTween.tween(camFollow, {x: 550, y: 250}, 1.25, {startDelay: 0.25, ease: FlxEase.quadInOut});
                    FlxTween.tween(camGame, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut});
                    yoshi.playAnim("pow");
                    dad.playAnim("xd");
                    camGame.shake(0.8, 0.02);
                    pow.alpha = 0;
                    FlxTween.tween(camHUD, {alpha: 0.001}, 1.25, {ease: FlxEase.quadInOut});
                    FlxTween.tween(dad, {y: 1500}, 0.6, {ease:FlxEase.quadIn, onComplete: function(twn:FlxTween)
                        {
                            dad.x = dad.x;
                            dad.y = dad.y;
                            dad.alpha = 0.0001;
                        }});
                }});
        }});
}
function peach(){
    
    peachCuts.x = -2000;
    peachCuts.y = -700;
    peachCuts.alpha = 1;
    peachCuts.animation.play('floats');
    iconGF.y = iconP2.y - (!downscroll ? 35 : -15);
    iconGF.loadGraphic(Paths.image('icons/yoshi_exe'), true, Math.floor(iconGF.width), Math.floor(iconGF.height));
    iconGF.animation.add("win", [0], 10, true);
    iconGF.animation.add("lose", [1], 10, true);

    FlxTween.tween(peachCuts, {y: -380}, 1.25, {ease: FlxEase.quadInOut});
    FlxTween.tween(camHUD, {alpha: 1}, 1.25, {ease: FlxEase.quadInOut});
    FlxTween.tween(peachCuts, {x: -235}, 1.5, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
        {
            FlxTween.tween(peachCuts, {y: -200}, 0.4, {startDelay: 0.1, ease: FlxEase.backIn, onComplete: function(twn:FlxTween)
                {
                    peachCuts.animation.play('fall');
                    FlxTween.tween(gf, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
                        {

                        }});
                    new FlxTimer().start(0.5833, function(tmr:FlxTimer)
                        {
                            peachCuts.alpha = 0.0001;
                            dad.alpha = 1;
                        });
                }});
        }});
}
function onCameraMove(e) if(cancelCameraMove) e.cancel();
