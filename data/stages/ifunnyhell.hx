var gfTurn = false;
function create() {
	strumLines.members[2].characters[1].visible = false;
}

function beatHit(curBeat) {
	if (curBeat == 266) strumLines.members[2].characters[0].visible = true;
	if (curBeat == 275) strumLines.members[2].characters[1].visible = true;
}

function gfSection() gfTurn = true;
function dadSection() gfTurn = false;

function onDadHit() {
	if (gfSection) strumLines.members[2].characters[1].playSingAnim(e.direction, e.animSuffix);
}