import gameplay.stages.ABotSpeaker;

var abot:ABotSpeaker;
var abof:ABotSpeaker;

function onCreate() {}

function onCreatePost()
{
    var curLevel = Paths.currentLevel;

    Paths.setCurrentLevel('weekend1');

    abot = new ABotSpeaker(game.gfGroup.x, game.gfGroup.y + 550);
    abot.x += 20;
    abot.y += -260;
    abot.antialiasing = ClientPrefs.data.antialiasing;


    // Crear la segunda instancia de ABotSpeaker
    abof = new ABotSpeaker(game.gfGroup.x, game.gfGroup.y + 550);
    abof.x += 20;
    abof.y += -260;
    abof.antialiasing = ClientPrefs.data.antialiasing;
      
    Paths.setCurrentLevel(curLevel);

    setVar('abot', abot);
    updateABotEye("dad", true, abot);
    updateABotEye("dad", true, abof);

   game.addBehindGF(abof);
    game.addBehindGF(abot);
     setVar('abof', abof);
}

function onSongStart()
{
    // Asignar la música actual a ambos bots
    abot.snd = FlxG.sound.music;
    abof.snd = FlxG.sound.music;
}

function onMoveCamera(who:String)
{
    // Actualizar los ojos de ambos bots según el movimiento de la cámara
    updateABotEye(who, false, abot);
    updateABotEye(who, false, abof);
}

function updateABotEye(who:String = "dad", finishInstantly:Bool = false, bot:ABotSpeaker)
{
    if (who == "dad") {
        bot.lookLeft(); 
    } else {
        bot.lookRight(); 
    }

    if (finishInstantly) {
        bot.eyes.anim.curFrame = bot.eyes.anim.length - 1;
    }
}

function onEvent(name, value1, value2, time)
{
    if (name == 'Focus Camera') {
        if (value1 == '1') {
            abot.lookLeft(); 
            abof.lookLeft();
        }
        if (value1 == '0') {
            abot.lookRight(); 
            abof.lookRight();
        }
    }
}
