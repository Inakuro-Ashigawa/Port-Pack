var dadZoom:Float = .5;
var bfZoom:Float = .7;
var __timer:Float = 0;
var float:Bool = false;
function postCreate(){

    fireR.flipX = true;

    platform2  = new FlxSprite(-1100, -600).loadGraphic(Paths.image('stages/exesequel/SS_foreground'));
    platform2.scrollFactor.set(1.3, 1.3);
    add(platform2);
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
    }
//events but better than before lmao
function JohnDickApper(){
    FlxTween.tween(gf, {y: 0}, 3, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
    {
        float = true;

    }});
} 
function yoshi(){
    FlxTween.tween(gfGroup, {x: 3500}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(gfGroup, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
        {
            gfGroup.scrollFactor.set(0.55, 0.55);

            triggerEventNote('Play Animation', 'prepow', 'gf');
            gf.x = 685;
            gf.y = -1200;
            FlxTween.tween(gf, {y: 20}, 0.20, {startDelay: 1.04, onComplete: function(twn:FlxTween)
                {
                    triggerEventNote('Screen Shake','0.8, 0.02','');
                    triggerEventNote('Play Animation', 'pow', 'gf');
                    triggerEventNote('Play Animation', 'xd', 'dad');
                    starmanPOW.visible = false;
                    FlxTween.tween(dadGroup, {y: 1500}, 0.6, {ease:FlxEase.quadIn, onComplete: function(twn:FlxTween)
                        {
                            dadGroup.x = dadx;
                            dadGroup.y = dady;
                            triggerEventNote('Change Character', '1', 'peach-exe');
                            dad.visible = false;
                        }}));
}