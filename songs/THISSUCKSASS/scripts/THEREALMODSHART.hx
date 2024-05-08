var defY = 0;
var waveAmt = 0;
var waveTar = 0;
var waveTarSpd = 0.1;

function postCreate()
	for (strums in strumLines.members) for (strum in strums.members) defY = strum.y;

function update(elapsed) {
	for (strums in strumLines.members)
		for (strum in strums.members)
			strum.y = defY + Math.sin((inst.time / 500) + (strum.ID * 2) * 50) * waveAmt;

	waveAmt = FlxMath.lerp(waveAmt, waveTar, 0.0025);
}

function beatHit(curBeat) {
	switch curBeat {
		case 32: waveTar = 12.5;
		case 64: waveTar = 25;
		case 128: waveTar = 12.5;
		case 192: waveTar = 5;
		case 264: waveTar = 25;
		case 328: waveTar = 0;
		case 336: waveTar = 35;
		case 592: waveTar = 12.5;
	}
}
