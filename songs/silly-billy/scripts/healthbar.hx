import flixel.ui.FlxBar;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var timeTxt:FlxText;
var hudTxt:FlxText;
var hudTxtTween:FlxTween;
var ratingFC:String = "FC";
var ratingStuff:Array<Dynamic> = [
    ['You Suck!', 0.2], //From 0% to 19%
    ['Shit', 0.4], //From 20% to 39%
    ['Bad', 0.5], //From 40% to 49%
    ['Bruh', 0.6], //From 50% to 59%
    ['Meh', 0.69], //From 60% to 68%
    ['Nice', 0.7], //69%
    ['Good', 0.8], //From 70% to 79%
    ['Great', 0.9], //From 80% to 89%
    ['WILLY NILLY', 1], //From 90% to 99%
    ['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
];

var bar:FlxSprite;
var iconOpp:FlxSprite;
var iconP:FlxSprite;
var barFill:FlxSprite;
var actualBar:FlxBar;
var evilBar:FlxBar;
var evilHealth:Float = 1;

function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC(accuracy:Float, misses:Int):String {
    // this sucks but idk how to make it better lol
    if (misses == 0) {
        if (accuracy == 1.0) ratingFC = "SFC";
        else if (accuracy >= 0.99) ratingFC = "GFC";
        else ratingFC = "FC";
    }
    if (misses > 0) {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
}
function postCreate(){
    bar = new FlxSprite().loadGraphic(Paths.image("misc/Bar/Silly_Healthbar"));
    bar.cameras = [camHUD];
    bar.scale.set(0.5, 0.5);
    bar.updateHitbox();
    bar.screenCenter();
    bar.x -= 250;
    bar.y = (healthBarBG.y - (bar.height / 2)) - 25;

    actualBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 327.805, 28);
    actualBar.cameras = [camHUD];
    actualBar.createGradientBar([0xFF000000, 0xFF000000], [0xFF1565C0, 0xFFFFFFFF], 1, 90);
    actualBar.updateBar();
    actualBar.setPosition(420, 615.8);
    add(actualBar);

    evilBar = new FlxBar(0, 0, FlxBar.FILL_RIGHT_TO_LEFT, 330.805, 36);
    evilBar.cameras = [camHUD];
    evilBar.createGradientBar([0xFF000000, 0xFF000000], [0xFF8A0101, 0xFF000000], 1, 90);
    evilBar.updateBar();
    evilBar.flipX = true;
    evilBar.setPosition(405 - evilBar.width - 25, 620);
    add(evilBar);
    add(bar);

    iconP = new FlxSprite().loadGraphic(Paths.image("misc/Bar/icons/bficon"));
    iconP.loadGraphic(Paths.image("misc/Bar/icons/bficon"), true, Math.floor(iconP.width / 2), Math.floor(iconP.height));
    iconP.animation.add("win", [0], 10, true);
    iconP.animation.add("lose", [1], 10, true);
    iconP.animation.play('win');
    iconP.cameras = [camHUD];
    iconP.setPosition(400, (bar.y + (bar.height / 2) - (iconP.height / 2)));
    iconP.flipX = true;
    add(iconP);

    iconOpp = new FlxSprite();
    iconOpp.loadGraphic(Paths.image("misc/Bar/icons/billyicon"));
    iconOpp.loadGraphic(Paths.image("misc/Bar/icons/billyicon"), true, Math.floor(iconOpp.width / 5), Math.floor(iconOpp.height));
    iconOpp.animation.add('0', [0], 0, false, false);
    iconOpp.animation.add('1', [1], 0, false, false);
    iconOpp.animation.add('2', [2], 0, false, false);
    iconOpp.animation.add('3', [3], 0, false, false);
    iconOpp.animation.add('4', [4], 0, false, false);
    iconOpp.animation.play('1');
    iconOpp.cameras = [camHUD];
    iconOpp.setPosition(405 - iconOpp.width, (bar.y + (bar.height / 2) - (iconOpp.height / 2)));
    add(iconOpp);

    iconOpp.centerOffsets();
    iconP.centerOffsets();


    healthBarBG.visible = false;
    healthBar.visible = false;
    iconP1.visible = false;
    iconP2.visible = false;
    missesTxt.y += 50;
    accuracyTxt.y += 50;
    scoreTxt.y += 50;

    for (i in [missesTxt, accuracyTxt, scoreTxt]) {
        i.visible = false;
    }
    add(hudTxt);

}
function create() {

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Misses: 0 | Rating: ?");
    hudTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.screenCenter(FlxAxes.X);


    hudTxt.cameras = [camHUD];
   
}
function update(elapsed){
    actualBar.percent = healthBar.percent;
    evilBar.percent = 100 - healthBar.percent;

    hudTxt.x = 213.75 - ( hudTxt.width / 3);


    var percent = (health / 2) * 100;
    if (percent < 20){
       iconP.animation.play('lose');
    }
    else{
        iconP.animation.play('win');
    }
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    getRatingFC(accuracy, misses);
    if (songScore > 0 || acc > 0 || misses > 0) {
        hudTxt.text = "Score: " + songScore + " | Misses: " + misses +  " | Rating: " + rating + " (" + acc + "%)" + " - " + ratingFC;
    } 
}
function shits(eventName, value1){
    if(eventName == 'ill make'){
        switch(value1){
            case 'pre':
                var hud = [bar, actualBar, evilBar, iconP, iconOpp,hudTxt];
                for(h in hud){ FlxTween.tween(h, {alpha: 0}, 2, {ease: FlxEase.quadIn});}
        }
    }else if (eventName == 'icon switch'){
        trace(value1);
        iconOpp.animation.play(value1);
        if(health > 0.5) FlxTween.num(health, 0.5, 1, {ease: FlxEase.quadOut, onUpdate: (t:FlxTween)->{evilHealth = t.value;}});
    }
}


function onDadHit(note) {
if (health > 0.1) 
health -= .025* 0.5;
}