// i'm super fucking mad
import flixel.FlxG;
if(SONG.meta.name == "THISSUCKSASS")
    //trying the pixel.hx method
    function onCountdown(event) {
        if (event.soundPath != null) event.soundPath = 'luigiCountdown/' + event.soundPath;
    }