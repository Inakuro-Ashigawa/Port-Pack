import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import flixel.text.FlxText.FlxTextAlign;


function postCreate(){

    counter = new FlxSprite(900,550).loadGraphic(Paths.image('misc/funkui/counter'));
    counter.cameras = [camHUD];
    add(counter);


    score = new FlxText(1000,670, 0, songScore, 21);
	score.setFormat('assets/fonts/funkadelix/tommy.otf', 40, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	score.scrollFactor.set();
	score.borderSize = 3;
    score.cameras = [camHUD];
    add(score);

	miss = new FlxText(1060,570, 0, misses, 40);
	miss.setFormat('assets/fonts/funkadelix/tommy.otf', 30, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	miss.borderSize = 3;
    miss.cameras = [camHUD];
    add(miss);

    accc = new FlxText(1180,575, 0, 0, 40);
	accc.setFormat('assets/fonts/funkadelix/tommy.otf', 25, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	accc.borderSize = 3;
    accc.cameras = [camHUD];
    add(accc);

    for (i in [healthBarBG, healthBar, iconP1, iconP2,scoreTxt,missesTxt,accuracyTxt])
		remove(i);

}

function update(elapsed){
    if (downscroll) counter.y = 550;
    if (downscroll) counter.flipY = true;
    if (downscroll) score.x = 1000;
    if (downscroll) score.y = 660;
    if (downscroll) miss.x = 1060;
    if (downscroll) miss.y = 570;
    if (downscroll) accc.x = 1180;
    if (downscroll) accc.y = 570;
    score.text = songScore;
    miss.text = misses;
    accc.text = (FlxMath.roundDecimal(accuracy * 100, 2) == -100 ? "N/A" : FlxMath.roundDecimal(accuracy * 100, 2) + '%');
}
