import states.stages.objects.ABotSpeaker;
//ul
var abot:ABotSpeaker;

function onCreatePost()
{
    var curLevel = Paths.currentLevel;

    Paths.setCurrentLevel('weekend1');

    abot = new ABotSpeaker(game.gfGroup.x, game.gfGroup.y + 550);
    abot.x += -210;
    abot.y -= 260;
    abot.antialiasing = ClientPrefs.data.antialiasing;

    Paths.setCurrentLevel(curLevel);

    updateABotEye("dad", true);


    game.addBehindGF(abot);
}

function onSongStart()
{

    abot.snd = FlxG.sound.music;
}

function onMoveCamera(who:String)
{

    updateABotEye(who, false);
}

function updateABotEye(who:String = "dad", finishInstantly:Bool = false)
{

    if (who == "dad") {
        abot.lookLeft(); 
    } else {
        abot.lookRight(); 
    }

    if (finishInstantly) {
        abot.eyes.anim.curFrame = abot.eyes.anim.length - 1;
    }
}