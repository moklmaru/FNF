package menu.freeplay;

import gameplay.score.Highscore;

import gameplay.hud.HealthIcon;
import menu.freeplay.MusicPlayer;

import menu.options.GameplayChangersSubstate;
import gameplay.score.ResetScoreSubState;


import flixel.util.FlxDestroyUtil;



/**
	Freeplay!

	this is the state i spend most of my time so i'm putting a bunch of effort into refactoring this
	general foundation/inpiration is from V-Slice but i'm rewriting it to my own satisfaction

	note to other devs: leave comments on your shit !!! this is nasty

	-mokl
**/
class FreeplayState extends FunkinState {
	private static var selectedSong:Int = 0;
	private var songLerp:Float = 0;
	private var songList:Array<SongMetadata> = []; // list of songs displayed in the menu
	private var songGroup:FlxTypedGroup<Alphabet>;
	
	private static var difficultyPrev:String = Difficulty.getDefault();
	private var difficulty:Int = -1;
	private var difficultyText:FlxText;

	private var score:Int = 0;
	private var scoreLerp:Int = 0;
	private var scoreText:FlxText;
	private var scoreBG:FlxSprite;

	private var rating:Float = 0;
	private var ratingLerp:Float = 0;

	private var charIcons:Array<HealthIcon> = [];

	private var background:FlxSprite;
	private var backgroundColor:Int;

	private var missingText:FlxText;
	private var missingTextBG:FlxSprite;

	private var musicPlayer:MusicPlayer;
	private var bottomText:FlxText;

	override function create() {		
		persistentUpdate = true;

		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (WeekData.weeksList.length < 1) {
			FlxTransitionableState.skipNextTransIn = true;
			persistentUpdate = false;
			FunkinState.switchState(new core.debug.ErrorState(
				"NO WEEKS ADDED FOR FREEPLAY\n\nPress ACCEPT to go to the Week Editor Menu.\nPress BACK to return to Main Menu.",
				function() FunkinState.switchState(new modding.editors.WeekEditorState()),
				function() FunkinState.switchState(new menu.main.MainMenuState())
			));

			return;
		}

		for (i in 0...WeekData.weeksList.length) {
			if (weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length) {
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs) {
				var colors:Array<Int> = song[2];
				if (colors == null || colors.length < 3) {
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		Mods.loadTopMod();

		background = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		background.antialiasing = ClientPrefs.data.antialiasing;
		add(background);
		background.screenCenter();

		songGroup = new FlxTypedGroup<Alphabet>();
		add(songGroup);

		for (i in 0...songList.length) {
			var songText:Alphabet = new Alphabet(90, 320, songList[i].songName, true);
			songText.targetY = i;
			songGroup.add(songText);

			songText.scaleX = Math.min(1, 980 / songText.width);
			songText.snapToPosition();

			Mods.currentModDirectory = songList[i].folder;
			var icon:HealthIcon = new HealthIcon(songList[i].songCharacter);
			icon.sprTracker = songText;

			// too laggy with a lot of songs, so i had to recode the logic for it
			songText.visible = songText.active = songText.isMenuItem = false;
			icon.visible = icon.active = false;

			// using a FlxGroup is too much fuss!
			charIcons.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		difficultyText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		difficultyText.font = scoreText.font;
		add(difficultyText);

		add(scoreText);

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);
		
		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		if (selectedSong >= songList.length) selectedSong = 0;
		background.color = songList[selectedSong].color;
		backgroundColor = background.color;
		songLerp = selectedSong;

		difficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(difficultyPrev)));

		var bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		bottomBG.alpha = 0.6;
		add(bottomBG);

		var leText:String = Language.getPhrase("freeplay_tip", "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.");
		var size:Int = 16;
		bottomText = new FlxText(bottomBG.x, bottomBG.y + 4, FlxG.width, leText, size);
		bottomText.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, CENTER);
		bottomText.scrollFactor.set();
		add(bottomText);
		
		musicPlayer = new MusicPlayer(this);
		add(musicPlayer);
		
		changeSelection();
		updateTexts();
		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int) {
		songList.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		var locked = (
			!leWeek.startUnlocked 
			&& leWeek.weekBefore.length > 0 
			&& (
				!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) 
				|| !StoryMenuState.weekCompleted.get(leWeek.weekBefore)
			)
		);

		return locked;
	}

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	public static var opponentVocals:FlxSound = null;
	var holdTime:Float = 0;

	var stopMusicPlay:Bool = false;
	override function update(elapsed:Float) {
		if(WeekData.weeksList.length < 1) return;

		if (FlxG.sound.music.volume < 0.7)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		scoreLerp = Math.floor(FlxMath.lerp(score, scoreLerp, Math.exp(-elapsed * 24)));
		ratingLerp = FlxMath.lerp(rating, ratingLerp, Math.exp(-elapsed * 12));

		if (Math.abs(scoreLerp - score) <= 10)
			scoreLerp = score;
		if (Math.abs(ratingLerp - rating) <= 0.01)
			ratingLerp = rating;

		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(ratingLerp * 100, 2)).split('.');
		if(ratingSplit.length < 2) //No decimals, add an empty space
			ratingSplit.push('');
		
		while(ratingSplit[1].length < 2) //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (!musicPlayer.playingMusic) {
			scoreText.text = Language.getPhrase('personal_best', 'PERSONAL BEST: {1} ({2}%)', [scoreLerp, ratingSplit.join('.')]);
			positionHighscore();
			
			if(songList.length > 1) {
				if(FlxG.keys.justPressed.HOME) {
					selectedSong = 0;
					changeSelection();
					holdTime = 0;	
				}
				else if(FlxG.keys.justPressed.END) {
					selectedSong = songList.length - 1;
					changeSelection();
					holdTime = 0;	
				}

				if (controls.UI_UP_P) {
					changeSelection(-shiftMult);
					holdTime = 0;
				}

				if (controls.UI_DOWN_P) {
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP) {
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				}

				if(FlxG.mouse.wheel != 0) {
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				}
			}

			if (controls.UI_LEFT_P) {
				changeDiff(-1);
				_updateSongLastDifficulty();
			}
			else if (controls.UI_RIGHT_P) {
				changeDiff(1);
				_updateSongLastDifficulty();
			}
		}

		if (controls.BACK) {
			if (musicPlayer.playingMusic) {
				FlxG.sound.music.stop();
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				instPlaying = -1;

				musicPlayer.playingMusic = false;
				musicPlayer.switchPlayMusic();

				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
				FlxTween.tween(FlxG.sound.music, {volume: 1}, 1);
			} else {
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FunkinState.switchState(new MainMenuState());
			}
		}

		if(FlxG.keys.justPressed.CONTROL && !musicPlayer.playingMusic) {
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		else if(FlxG.keys.justPressed.SPACE) {
			if (instPlaying != selectedSong && !musicPlayer.playingMusic) {
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;

				Mods.currentModDirectory = songList[selectedSong].folder;
				var poop:String = Highscore.formatSong(songList[selectedSong].songName.toLowerCase(), difficulty);
				Song.loadFromJson(poop, songList[selectedSong].songName.toLowerCase());
				if (PlayState.SONG.needsVoices) {
					vocals = new FlxSound();
					try {
						var playerVocals:String = getVocalFromCharacter(PlayState.SONG.player1);
						var loadedVocals = Paths.voices(PlayState.SONG.song, (playerVocals != null && playerVocals.length > 0) ? playerVocals : 'Player');
						if(loadedVocals == null) loadedVocals = Paths.voices(PlayState.SONG.song);
						
						if(loadedVocals != null && loadedVocals.length > 0) {
							vocals.loadEmbedded(loadedVocals);
							FlxG.sound.list.add(vocals);
							vocals.persist = vocals.looped = true;
							vocals.volume = 0.8;
							vocals.play();
							vocals.pause();
						}
						else vocals = FlxDestroyUtil.destroy(vocals);
					}
					catch(e:Dynamic)
						vocals = FlxDestroyUtil.destroy(vocals);
					
					opponentVocals = new FlxSound();
					try {
						// trace('please work...');
						var oppVocals:String = getVocalFromCharacter(PlayState.SONG.player2);
						var loadedVocals = Paths.voices(PlayState.SONG.song, (oppVocals != null && oppVocals.length > 0) ? oppVocals : 'Opponent');
						
						if (loadedVocals != null && loadedVocals.length > 0) {
							opponentVocals.loadEmbedded(loadedVocals);
							FlxG.sound.list.add(opponentVocals);
							opponentVocals.persist = opponentVocals.looped = true;
							opponentVocals.volume = 0.8;
							opponentVocals.play();
							opponentVocals.pause();
							// trace('yaaay!!');
						}
						else opponentVocals = FlxDestroyUtil.destroy(opponentVocals);
					}
					catch(e:Dynamic) {
						// trace('FUUUCK');
						opponentVocals = FlxDestroyUtil.destroy(opponentVocals);
					}
				}

				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.8);
				FlxG.sound.music.pause();
				instPlaying = selectedSong;

				musicPlayer.playingMusic = true;
				musicPlayer.curTime = 0;
				musicPlayer.switchPlayMusic();
				musicPlayer.pauseOrResume(true);
			}
			else if (instPlaying == selectedSong && musicPlayer.playingMusic) {
				musicPlayer.pauseOrResume(!musicPlayer.playing);
			}
		}

		else if (controls.ACCEPT && !musicPlayer.playingMusic) {
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songList[selectedSong].songName);
			var poop:String = Highscore.formatSong(songLowercase, difficulty);

			try {
				Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = difficulty;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			}
			catch(e) {
				trace('ERROR! ${e.message}');

				var errorStr:String = e.message;
				if(errorStr.contains('There is no TEXT asset with an ID of')) errorStr = 'Missing file: ' + errorStr.substring(errorStr.indexOf(songLowercase), errorStr.length-1); //Missing chart
				else errorStr += '\n\n' + e.stack;

				missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
				missingText.screenCenter(Y);
				missingText.visible = true;
				missingTextBG.visible = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));

				updateTexts(elapsed);
				super.update(elapsed);
				return;
			}

			LoadingState.prepareToSong();
			LoadingState.loadAndSwitchState(new PlayState());
			#if !SHOW_LOADING_SCREEN FlxG.sound.music.stop(); #end
			stopMusicPlay = true;

			destroyFreeplayVocals();
			#if (MODS_ALLOWED && DISCORD_ALLOWED)
			DiscordClient.loadModRPC();
			#end
		}

		else if(controls.RESET && !musicPlayer.playingMusic) {
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songList[selectedSong].songName, difficulty, songList[selectedSong].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		updateTexts(elapsed);
		super.update(elapsed);
	}
	
	function getVocalFromCharacter(char:String) {
		try {
			var path:String = Paths.getPath('characters/$char.json', TEXT);
			#if MODS_ALLOWED
			var character:Dynamic = Json.parse(File.getContent(path));
			#else
			var character:Dynamic = Json.parse(Assets.getText(path));
			#end
			return character.vocals_file;
		}
		catch (e:Dynamic) trace('Error loading character vocals: $e');

		return null;
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) vocals.stop();
		vocals = FlxDestroyUtil.destroy(vocals);

		if(opponentVocals != null) opponentVocals.stop();
		opponentVocals = FlxDestroyUtil.destroy(opponentVocals);
	}

	function changeDiff(change:Int = 0) {
		if (musicPlayer.playingMusic)
			return;

		difficulty = FlxMath.wrap(difficulty + change, 0, Difficulty.list.length-1);
		#if !switch
		score = Highscore.getScore(songList[selectedSong].songName, difficulty);
		rating = Highscore.getRating(songList[selectedSong].songName, difficulty);
		#end

		difficultyPrev = Difficulty.getString(difficulty, false);
		var displayDiff:String = Difficulty.getString(difficulty);
		if (Difficulty.list.length > 1)
			difficultyText.text = '< ' + displayDiff.toUpperCase() + ' >';
		else
			difficultyText.text = displayDiff.toUpperCase();

		positionHighscore();
		missingText.visible = false;
		missingTextBG.visible = false;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true) {
		if (musicPlayer.playingMusic) return;

		selectedSong = FlxMath.wrap(selectedSong + change, 0, songList.length-1);
		_updateSongLastDifficulty();
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		var newColor:Int = songList[selectedSong].color;
		if(newColor != backgroundColor) {
			backgroundColor = newColor;
			FlxTween.cancelTweensOf(background);
			FlxTween.color(background, 1, background.color, backgroundColor);
		}

		for (num => item in songGroup.members) {
			var icon:HealthIcon = charIcons[num];
			item.alpha = 0.6;
			icon.alpha = 0.6;
			if (item.targetY == selectedSong) {
				item.alpha = 1;
				icon.alpha = 1;
			}
		}
		
		Mods.currentModDirectory = songList[selectedSong].folder;
		PlayState.storyWeek = songList[selectedSong].week;
		Difficulty.loadFromWeek();
		
		var savedDiff:String = songList[selectedSong].lastDifficulty;
		var lastDiff:Int = Difficulty.list.indexOf(difficultyPrev);
		if(savedDiff != null && !Difficulty.list.contains(savedDiff) && Difficulty.list.contains(savedDiff))
			difficulty = Math.round(Math.max(0, Difficulty.list.indexOf(savedDiff)));
		else if (lastDiff > -1)
			difficulty = lastDiff;
		else if (Difficulty.list.contains(Difficulty.getDefault()))
			difficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(Difficulty.getDefault())));
		else
			difficulty = 0;

		changeDiff();
		_updateSongLastDifficulty();
	}

	inline private function _updateSongLastDifficulty()
		songList[selectedSong].lastDifficulty = Difficulty.getString(difficulty, false);

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		difficultyText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		difficultyText.x -= difficultyText.width / 2;
	}

	var _drawDistance:Int = 4;
	var _lastVisibles:Array<Int> = [];
	public function updateTexts(elapsed:Float = 0.0) {
		songLerp = FlxMath.lerp(selectedSong, songLerp, Math.exp(-elapsed * 9.6));
		for (i in _lastVisibles) {
			songGroup.members[i].visible = songGroup.members[i].active = false;
			charIcons[i].visible = charIcons[i].active = false;
		}
		_lastVisibles = [];

		var min:Int = Math.round(Math.max(0, Math.min(songList.length, songLerp - _drawDistance)));
		var max:Int = Math.round(Math.max(0, Math.min(songList.length, songLerp + _drawDistance)));
		for (i in min...max) {
			var item:Alphabet = songGroup.members[i];
			item.visible = item.active = true;
			item.x = ((item.targetY - songLerp) * item.distancePerItem.x) + item.startPosition.x;
			item.y = ((item.targetY - songLerp) * 1.3 * item.distancePerItem.y) + item.startPosition.y;

			var icon:HealthIcon = charIcons[i];
			icon.visible = icon.active = true;
			_lastVisibles.push(i);
		}
	}

	override function destroy():Void {
		super.destroy();

		FlxG.autoPause = ClientPrefs.data.autoPause;
		if (!FlxG.sound.music.playing && !stopMusicPlay)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}	
}

class SongMetadata {
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var lastDifficulty:String = null;

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Mods.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}