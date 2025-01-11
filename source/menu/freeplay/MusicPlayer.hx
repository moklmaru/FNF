package menu.freeplay;

import flixel.ui.FlxBar;

// Music player used for Freeplay

@:access(menu.freeplay.FreeplayState)
class MusicPlayer extends FlxGroup 
{
	public var instance:FreeplayState;
	public var controls:Controls;

	public var playing(get, never):Bool;

	public var playingMusic:Bool = false;
	public var curTime:Float;

	var songBG:FlxSprite;
	var songText:FlxText;
	var timeText:FlxText;
	var progressBar:FlxBar;
	var playbackBG:FlxSprite;
	var playbackSymbols:Array<FlxText> = [];
	var playbackText:FlxText;

	var wasPlaying:Bool;

	var holdPitchTime:Float = 0;
	var playbackRate(default, set):Float = 1;

	public function new(instance:FreeplayState)
	{
		super();

		this.instance = instance;
		this.controls = instance.controls;

		var xPos:Float = FlxG.width * 0.7;

		songBG = new FlxSprite(xPos - 6, 0).makeGraphic(1, 100, 0xFF000000);
		songBG.alpha = 0.6;
		add(songBG);

		playbackBG = new FlxSprite(xPos - 6, 0).makeGraphic(1, 100, 0xFF000000);
		playbackBG.alpha = 0.6;
		add(playbackBG);

		songText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		songText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		add(songText);

		timeText = new FlxText(xPos, songText.y + 60, 0, "", 32);
		timeText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		add(timeText);

		for (i in 0...2)
		{
			var text:FlxText = new FlxText();
			text.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, CENTER);
			text.text = '^';
			if (i == 1)
				text.flipY = true;
			text.visible = false;
			playbackSymbols.push(text);
			add(text);
		}

		progressBar = new FlxBar(timeText.x, timeText.y + timeText.height, LEFT_TO_RIGHT, Std.int(timeText.width), 8, null, "", 0, Math.POSITIVE_INFINITY);
		progressBar.createFilledBar(FlxColor.WHITE, FlxColor.BLACK);
		add(progressBar);

		playbackText = new FlxText(FlxG.width * 0.6, 20, 0, "", 32);
		playbackText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE);
		add(playbackText);

		switchPlayMusic();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!playingMusic)
		{
			return;
		}

		var songName:String = instance.songList[FreeplayState.selectedSong].songName;
		if (playing && !wasPlaying)
			songText.text = Language.getPhrase('musicplayer_playing', 'PLAYING: {1}', [songName]);
		else
			songText.text = Language.getPhrase('musicplayer_paused', 'PLAYING: {1} (PAUSED)', [songName]);

		//if(FlxG.keys.justPressed.K) trace('Time: ${FreeplayState.vocals.time}, Playing: ${FreeplayState.vocals.playing}');

		if (controls.UI_LEFT_P)
		{
			if (playing)
				wasPlaying = true;

			pauseOrResume();

			curTime = FlxG.sound.music.time - 1000;
			instance.holdTime = 0;

			if (curTime < 0)
				curTime = 0;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}
		if (controls.UI_RIGHT_P)
		{
			if (playing)
				wasPlaying = true;

			pauseOrResume();

			curTime = FlxG.sound.music.time + 1000;
			instance.holdTime = 0;

			if (curTime > FlxG.sound.music.length)
				curTime = FlxG.sound.music.length;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}

		if(controls.UI_LEFT || controls.UI_RIGHT)
		{
			instance.holdTime += elapsed;
			if(instance.holdTime > 0.5)
			{
				curTime += 40000 * elapsed * (controls.UI_LEFT ? -1 : 1);
			}

			var difference:Float = Math.abs(curTime - FlxG.sound.music.time);
			if(curTime + difference > FlxG.sound.music.length) curTime = FlxG.sound.music.length;
			else if(curTime - difference < 0) curTime = 0;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}

		if(controls.UI_LEFT_R || controls.UI_RIGHT_R)
		{
			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);

			if (wasPlaying)
			{
				pauseOrResume(true);
				wasPlaying = false;
			}
		}
		if (controls.UI_UP_P)
		{
			holdPitchTime = 0;
			playbackRate += 0.05;
			setPlaybackRate();
		}
		else if (controls.UI_DOWN_P)
		{
			holdPitchTime = 0;
			playbackRate -= 0.05;
			setPlaybackRate();
		}
		if (controls.UI_DOWN || controls.UI_UP)
		{
			holdPitchTime += elapsed;
			if (holdPitchTime > 0.6)
			{
				playbackRate += 0.05 * (controls.UI_UP ? 1 : -1);
				setPlaybackRate();
			}
		}
	
		if (controls.RESET)
		{
			playbackRate = 1;
			setPlaybackRate();

			FlxG.sound.music.time = 0;
			setVocalsTime(0);
		}

		if (playing)
		{
			if(FreeplayState.vocals != null)
				FreeplayState.vocals.volume = (FreeplayState.vocals.length > FlxG.sound.music.time) ? 0.8 : 0;
			if(FreeplayState.opponentVocals != null)
				FreeplayState.opponentVocals.volume = (FreeplayState.opponentVocals.length > FlxG.sound.music.time) ? 0.8 : 0;

			if((FreeplayState.vocals != null && FreeplayState.vocals.length > FlxG.sound.music.time && Math.abs(FlxG.sound.music.time - FreeplayState.vocals.time) >= 25) ||
			(FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > FlxG.sound.music.time && Math.abs(FlxG.sound.music.time - FreeplayState.opponentVocals.time) >= 25))
			{
				pauseOrResume();
				setVocalsTime(FlxG.sound.music.time);
				pauseOrResume(true);
			}
		}

		positionSong();
		updateTimeTxt();
		updatePlaybackTxt();
	}

	function setVocalsTime(time:Float)
	{
		if (FreeplayState.vocals != null && FreeplayState.vocals.length > time)
			FreeplayState.vocals.time = time;
		if (FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > time)
			FreeplayState.opponentVocals.time = time;
	}

	public function pauseOrResume(resume:Bool = false) 
	{
		if (resume)
		{
			if(!FlxG.sound.music.playing)
				FlxG.sound.music.resume();

			if (FreeplayState.vocals != null && FreeplayState.vocals.length > FlxG.sound.music.time && !FreeplayState.vocals.playing)
				FreeplayState.vocals.resume();
			if (FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > FlxG.sound.music.time && !FreeplayState.opponentVocals.playing)
				FreeplayState.opponentVocals.resume();
		}
		else 
		{
			FlxG.sound.music.pause();

			if (FreeplayState.vocals != null)
				FreeplayState.vocals.pause();
			if (FreeplayState.opponentVocals != null)
				FreeplayState.opponentVocals.pause();
		}
	}

	public function switchPlayMusic()
	{
		FlxG.autoPause = (!playingMusic && ClientPrefs.data.autoPause);
		active = visible = playingMusic;

		instance.scoreBG.visible = instance.difficultyText.visible = instance.scoreText.visible = !playingMusic; //Hide Freeplay texts and boxes if playingMusic is true
		songText.visible = timeText.visible = songBG.visible = playbackText.visible = playbackBG.visible = progressBar.visible = playingMusic; //Show Music Player texts and boxes if playingMusic is true

		for (i in playbackSymbols)
			i.visible = playingMusic;
		
		holdPitchTime = 0;
		instance.holdTime = 0;
		playbackRate = 1;
		updatePlaybackTxt();

		if (playingMusic) {
			instance.bottomText.text = Language.getPhrase('musicplayer_tip', 'Press SPACE to Pause / Press ESCAPE to Exit / Press R to Reset the Song');
			positionSong();
			
			progressBar.setRange(0, FlxG.sound.music.length);
			progressBar.setParent(FlxG.sound.music, "time");
			progressBar.numDivisions = 1600;

			updateTimeTxt();
		}
		else
		{
			progressBar.setRange(0, Math.POSITIVE_INFINITY);
			progressBar.setParent(null, "");
			progressBar.numDivisions = 0;

			instance.positionHighscore();
		}
		progressBar.updateBar();
	}

	function updatePlaybackTxt()
	{
		var text = "";
		if (playbackRate is Int)
			text = playbackRate + '.00';
		else
		{
			var playbackRate = Std.string(playbackRate);
			if (playbackRate.split('.')[1].length < 2) // Playback rates for like 1.1, 1.2 etc
				playbackRate += '0';

			text = playbackRate;
		}
		playbackText.text = text + 'x';
	}

	function positionSong() 
	{
		var length:Int = instance.songList[FreeplayState.selectedSong].songName.length;
		var shortName:Bool = length < 5; // Fix for song names like Ugh, Guns
		songText.x = FlxG.width - songText.width - 6;
		if (shortName)
			songText.x -= 10 * length - length;
		songBG.scale.x = FlxG.width - songText.x + 12;
		if (shortName) 
			songBG.scale.x += 6 * length;
		songBG.x = FlxG.width - (songBG.scale.x / 2);
		timeText.x = Std.int(songBG.x + (songBG.width / 2));
		timeText.x -= timeText.width / 2;
		if (shortName)
			timeText.x -= length - 5;

		playbackBG.scale.x = playbackText.width + 30;
		playbackBG.x = songBG.x - (songBG.scale.x / 2);
		playbackBG.x -= playbackBG.scale.x;

		playbackText.x = playbackBG.x - playbackText.width / 2;
		playbackText.y = playbackText.height;

		progressBar.setGraphicSize(Std.int(songText.width), 5);
		progressBar.y = songText.y + songText.height + 10;
		progressBar.x = songText.x + songText.width / 2 - 15;
		if (shortName)
		{
			progressBar.scale.x += length / 2;
			progressBar.x -= length - 10;
		}

		for (i in 0...2)
		{
			var text = playbackSymbols[i];
			text.x = playbackText.x + playbackText.width / 2 - 10;
			text.y = playbackText.y;

			if (i == 0)
				text.y -= playbackText.height;
			else
				text.y += playbackText.height;
		}
	}

	function updateTimeTxt()
	{
		var text = FlxStringUtil.formatTime(FlxG.sound.music.time / 1000, false) + ' / ' + FlxStringUtil.formatTime(FlxG.sound.music.length / 1000, false);
		timeText.text = '< ' + text + ' >';
	}

	function setPlaybackRate() 
	{
		FlxG.sound.music.pitch = playbackRate;
		if (FreeplayState.vocals != null)
			FreeplayState.vocals.pitch = playbackRate;
		if (FreeplayState.opponentVocals != null)
			FreeplayState.opponentVocals.pitch = playbackRate;
	}

	function get_playing():Bool 
	{
		return FlxG.sound.music.playing;
	}

	function set_playbackRate(value:Float):Float 
	{
		var value = FlxMath.roundDecimal(value, 2);
		if (value > 3) value = 3;
		else if (value <= 0.25) value = 0.25;
		return playbackRate = value;
	}
}