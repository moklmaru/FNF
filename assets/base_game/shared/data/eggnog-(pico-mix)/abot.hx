import gameplay.stages.ABotSpeaker;
//ul
var abot:ABotSpeaker;

function onCreatePost()
{
    var curLevel = Paths.currentLevel;

    Paths.setCurrentLevel('weekend1');

    abot = new ABotSpeaker(game.gfGroup.x, game.gfGroup.y + 550);
    abot.x += 100;
    abot.y -= 160;
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
function onEvent(name, value1, value2, time) {
  if (name == 'Focus Camera') {
      if (value1 == '1') {
        abot.lookLeft(); 
  }
        if (value1 == '0') {
        abot.lookRight(); 
  }
    }
}