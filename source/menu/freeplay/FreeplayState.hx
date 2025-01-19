package menu.freeplay;

import gameplay.score.Highscore;
import gameplay.score.ResetScoreSubState;
import gameplay.hud.HealthIcon;
import menu.freeplay.MusicPlayer;
import menu.freeplay.FreeplayListEntry;
import menu.freeplay.FreeplayListEntry.FreeplayBonusTrack;
import menu.options.GameplayChangersSubstate;

import flixel.util.FlxDestroyUtil;

typedef PlayerCharacter = {
	var index:Int;
	var id:String;
	var name:String;
}

/**
	Freeplay!

	this is the state i spend most of my time so i'm putting a bunch of effort into refactoring this
	general foundation/inpiration is from V-Slice but i'm rewriting it to my own satisfaction

	-mokl
**/
@:access(menu.freeplay.FreeplayListEntry)
class FreeplayState extends FunkinState {
	private static var currentIndex:Int = 0;
	private static var currentSong:FreeplayListEntry;
	private static var currentWeek:Int = 0; // week index in the scope of the current character
	private var songList:FlxTypedGroup<FreeplayListEntry>; // list of songs displayed in the menu
	private static var songListLength:Int = 0; // for passing into the FreeplayListEntry group

	private static var dipshit:PlayerCharacter = { index: 0, id: "bf", name: "Boyfriend"}; // just keeping the naming faithful...
	private var charaText:FlxText;
	
	private static var difficultyPrev:String = Difficulty.getDefault();
	private var difficulty:Int = -1;
	private var difficultyText:FlxText;

	private var score:Int = 0;
	private var scoreLerp:Int = 0;
	private var scoreText:FlxText;
	private var scoreBG:FlxSprite;

	private var rating:Float = 0;
	private var ratingLerp:Float = 0;

	private var background:FlxSprite;
	private var backgroundColor:Int;

	private var errorText:FlxText;
	private var errorTextBG:FlxSprite;

	private var musicPlayer:MusicPlayer;
	private var bottomText:FlxText;

	static var idle:Bool = true;
	var shouldSwitchInst:Bool = true;

	override function create() {		
		persistentUpdate = true;

		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);
		Conductor.bpm = 102; // default menu bpm

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end

		// failsafe for if there are no weeks to populate the freeplay menu
		if (WeekData.weeksList.length < 1) {
			FlxTransitionableState.skipNextTransIn = true;
			persistentUpdate = false;
			FunkinState.switchState(new core.debug.ErrorState(
				"NO WEEKS ADDED FOR FREEPLAY\n\nPress ACCEPT to go to the Week Editor Menu.\nPress BACK to return to Main Menu.",
				function() FunkinState.switchState(new modding.editors.WeekEditorState()),
				function() FunkinState.switchState(new MainMenuState())
			));

			return;
		}

		// creates the background graphic (grayed out)
		background = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		background.antialiasing = ClientPrefs.data.antialiasing;
		add(background);
		background.screenCenter();

		updateSongList(); // add the songs
		currentSong = songList.members[currentIndex];

		// create the little score/difficulty window
		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		difficultyText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		difficultyText.font = scoreText.font;
		add(difficultyText);

		add(scoreText);

		// (temp) character select diplay
		var charaSelectText = new FlxText(FlxG.width * 0.7, 75, 0, "Character:", 24);
		charaSelectText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, RIGHT);

		var charaSelectBG = new FlxSprite(charaSelectText.x - 6, charaSelectText.y - 6)
			.makeGraphic(Math.round(FlxG.width - (charaSelectText.x - 6)), 80, 0xFF000000);
		charaSelectBG.alpha = 0.6;
		add(charaSelectBG);

		updateCharacter(true); // initialize our character data
		charaText = new FlxText(charaSelectText.x, charaSelectText.y + 28, 0, dipshit.name.toUpperCase(), 42);
		charaText.font = Paths.font("kidersun.otf");
		add(charaText);

		add(charaSelectText);

		// ??? refactor this out later because lol
		errorTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		errorTextBG.alpha = 0.6;
		errorTextBG.visible = false;
		add(errorTextBG);
		
		errorText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		errorText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		errorText.scrollFactor.set();
		errorText.visible = false;
		add(errorText);

		// default to the first song and set params from it
		if (currentIndex >= songList.members.length) currentIndex = 0;
		background.color = currentSong.color;
		backgroundColor = background.color;

		difficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(difficultyPrev)));

		// tip text at the bottom
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
		super.create();
	}

	override function closeSubState() {
		// changeSelection(0, false); // why was this here
		persistentUpdate = true;
		super.closeSubState();
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

		// update the conductor so we can have trigger beat-related events
		if (FlxG.sound.music.playing) Conductor.songPosition = FlxG.sound.music.time;

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
			scoreText.text = Language.getPhrase('personal_best', 'HIGHSCORE: {1} ({2}%)', [scoreLerp, ratingSplit.join('.')]);
			positionHighscore();
			
			if(songList.length > 1) {
				if(FlxG.keys.justPressed.HOME) {
					currentIndex = 0;
					changeSelection();
					holdTime = 0;	
				}
				else if(FlxG.keys.justPressed.END) {
					currentIndex = songList.length - 1;
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
					var checkLastHold:Int = Math.floor((holdTime - 0.25) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.25) * 10);

					if(holdTime > 0.25 && checkNewHold - checkLastHold > 0)
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

		// music player
		else if(FlxG.keys.justPressed.SPACE) {
			if (instPlaying != currentIndex && !musicPlayer.playingMusic) {
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;

				Mods.currentModDirectory = currentSong.folder;
				var poop:String = Highscore.formatSong(currentSong.name.toLowerCase(), difficulty);
				Song.loadFromJson(poop, currentSong.name.toLowerCase());
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
				instPlaying = currentIndex;

				musicPlayer.playingMusic = true;
				musicPlayer.curTime = 0;
				musicPlayer.switchPlayMusic();
				musicPlayer.pauseOrResume(true);
			}
			else if (instPlaying == currentIndex && musicPlayer.playingMusic) {
				musicPlayer.pauseOrResume(!musicPlayer.playing);
			}
		}

		// go into the selected song
		else if (controls.ACCEPT && !musicPlayer.playingMusic) {
			persistentUpdate = false;

			// swap into the alt track if it's selected
			if (currentSong.usingAltTrack) {
				var diff = Difficulty.getString(difficulty);
				for (track in currentSong.altTracks) 
				if (track.difficulties.contains(diff)) {
					trace('Switching to alt track ${track.name}');
					currentSong = track;
					Mods.currentModDirectory = currentSong.folder;
					PlayState.storyWeek = currentSong.weekGlobalIndex;
					break;
				}
			}

			var songLowercase:String = Paths.formatToSongPath(currentSong.name);
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

				errorText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
				errorText.screenCenter(Y);
				errorText.visible = true;
				errorTextBG.visible = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));

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
			openSubState(new ResetScoreSubState(currentSong.name, difficulty, currentSong.opponentChar));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		else if (FlxG.keys.justPressed.TAB) {
			updateCharacter();
		}

		// switch background music (if needed) if the menu is idle
		if (idle && shouldSwitchInst) {
			changeInst();
			shouldSwitchInst = false;
		}

		super.update(elapsed);
	}

	override function beatHit() {
		super.beatHit();

		currentSong.icon.angle = 25;
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

	function updateSongList() {
		songList = new FlxTypedGroup<FreeplayListEntry>();
		var appendedSongs:Array<FreeplayBonusTrack> = [];

		// get array of songs for the current character
		var index:Int = 0;
		var weekIndex = 0; // index of the weeks for this specific list
		for (i => week in WeekData.weeksList) {
			if (weekIsLocked(week)) continue; // skip locked weeks

			var leWeek:WeekData = WeekData.weeksLoaded.get(week);
			WeekData.setDirectoryFromWeek(leWeek);

			// note the difficulties of this week (or set the default)
			var weekDiffs:Array<String> = leWeek.difficulties.trim().split(',');
			if (weekDiffs.length < 1 || weekDiffs[0] == '')
				weekDiffs = Difficulty.defaultList.copy();
			
			var validWeek:Bool = false;
			for (idx => song in leWeek.songs) {
				// record data for songs that are instead added as extra difficulties to other songs
				if (leWeek.appended && leWeek.targets[idx] != null) {
					// trace('${song[0]} should be appended to ${leWeek.targets[idx]}');
					var track = new FreeplayBonusTrack(song, leWeek.targets[idx]);
					track.difficulties = weekDiffs.copy();
					track.weekGlobalIndex = i;
					track.opponentChar = song[2];
					//trace('opponentChar: ${track.opponentChar} on ${track.name}');
					appendedSongs.push(track);
					continue; // this song will NOT be added to the freeplay menu
				}

				var playerChar = song[1]; // bypass songs that arent for our selected character
				// trace('song ${song[0]} is for $playerChar');
				if (playerChar != dipshit.id) continue;

				var songEntry:FreeplayListEntry = new FreeplayListEntry(song, index, weekIndex);
				songEntry.difficulties = weekDiffs.copy();
				songEntry.weekGlobalIndex = i;
				songEntry.hide();
				songList.add(songEntry);

				index++;
				validWeek = true;
			}
			if (validWeek) weekIndex++;
		}

		// assign the alt song data to source of the appended songs
		for (track in appendedSongs) {
			for (song in songList.members) {
				if (song.name == track.parentName) {
					// trace('appending ${track.name} to ${song.name}');
					song.altTracks.push(track);
					song.altOpponents.push(track.opponentChar);
					track.parentSong = song;
					for (diff in track.difficulties) song.difficulties.push(diff);

					break;
				}
			}
		}

		Mods.loadTopMod();
		add(songList);
		songListLength = songList.members.length;

		WeekData.setDirectoryFromWeek();
	}

	function updateCharacter(?init:Bool = false) {
		var path = Paths.getPath('data/characterSelect.json', TEXT);
		var data:Dynamic = Json.parse(File.getContent(path));

		if (!init) { // advance to the next character
			var length:Int = Reflect.fields(data.characters).length;
			var idx = FlxMath.wrap(dipshit.index + 1, 0, length-1);
			dipshit.index = idx;
		}

		// WHY is this language so insufferable with parsing jsons
		var charList = Reflect.fields(data.characters);
		for (dood in charList) {
			var info:Dynamic = Reflect.field(data.characters, dood);
			if (info == null) continue;
			if (dipshit.index == info.index) {
				dipshit.id = dood;
				// trace('charID is ${dipshit.id} for index ${dipshit.index}');
				var char:Dynamic = Reflect.field(data.characters, dipshit.id);
				if (char == null) return;

				var name = Reflect.field(char, "name");
				if (name == null) {
					name = "???";
					trace('Character name not found for ID ${dipshit.index}!');
				}
				dipshit.name = name;

				break;
			}
		}
		
		if (init) return;

		charaText.text = dipshit.name.toUpperCase();

		// refresh song list for the new character
		remove(songList);
		updateSongList();
		changeSelection(0, true);
	}

	function changeDiff(change:Int = 0) {
		if (musicPlayer.playingMusic)
			return;

		var lastDiff = Difficulty.getString(difficulty);
		difficulty = FlxMath.wrap(difficulty + change, 0, Difficulty.list.length-1);

		difficultyPrev = Difficulty.getString(difficulty, false);
		var displayDiff:String = Difficulty.getString(difficulty);
		if (Difficulty.list.length > 1)
			difficultyText.text = '< ' + displayDiff.toUpperCase() + ' >';
		else
			difficultyText.text = displayDiff.toUpperCase();

		if (currentSong.altTracks.length > 0) {
			for (track in currentSong.altTracks) {
				if (track.difficulties.contains(displayDiff)) {
					if (displayDiff != lastDiff)
						FlxG.sound.play(Paths.sound('bside'), 0.6);

					Mods.currentModDirectory = track.folder;
					currentSong.changeIcon(track.opponentChar);
					var altColor = FlxColor.fromRGB(205, 86, 209);
					FlxTween.color(background, 0.2, background.color, altColor);
					currentSong.usingAltTrack = true;
					changeInst();
					break;
				} else if (currentSong.usingAltTrack) {
					currentSong.changeIcon(currentSong.opponentChar);
					FlxTween.cancelTweensOf(background);
					FlxTween.color(background, 0.2, background.color, currentSong.color);
					currentSong.usingAltTrack = false;
					changeInst();
				}
			}
		}

		var scoreTarget = if (currentSong.usingAltTrack) currentSong.altTracks[0].name else currentSong.name;
		#if !switch
		score = Highscore.getScore(scoreTarget, difficulty);
		rating = Highscore.getRating(scoreTarget, difficulty);
		#end

		positionHighscore();
		errorText.visible = false;
		errorTextBG.visible = false;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true) {
		if (musicPlayer.playingMusic) return;

		currentIndex = FlxMath.wrap(currentIndex + change, 0, songList.members.length-1);
		_updateSongLastDifficulty();
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		currentSong = songList.members[currentIndex];
		currentWeek = currentSong.weekIndex;
		// trace('selected song: ${currentSong.name} of week: $currentWeek');

		var newColor:FlxColor = currentSong.color;
		if(newColor != backgroundColor && !currentSong.usingAltTrack) {
			backgroundColor = newColor;
			FlxTween.cancelTweensOf(background);
			FlxTween.color(background, 0.5, background.color, backgroundColor);
		}

		for (entry in songList.members)
			entry.setSelected(entry.index == currentIndex);
		
		Mods.currentModDirectory = currentSong.folder;
		PlayState.storyWeek = currentSong.weekGlobalIndex;
		Difficulty.list = currentSong.difficulties.copy();

		var savedDiff:String = currentSong.lastDifficulty;
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

		FlxG.sound.music.volume = 0;
		changeInst();
	}

	function changeInst() {
		// if the menu is moving, we'll put in an IOU for the music to change once it stops
		// this is to prevent rapid changes in music while scrolling
		if (!idle) {
			shouldSwitchInst = true;
			return;
		}

		// draft for playing instrumentals. it does "work", might need some cleanup though
		var songTarget = currentSong.name;
		if (currentSong.altTracks.length > 0 
		&& currentSong.altTracks[0].difficulties.contains(Difficulty.getString(difficulty))) {
			songTarget = currentSong.altTracks[0].name;
			Mods.currentModDirectory = currentSong.altTracks[0].folder; 
		}
		var poop:String = Highscore.formatSong(songTarget.toLowerCase(), difficulty);
		// FIX THIS // will crash sometimes if it doesnt get the right song+diff string
		// needs a failsafe for when that data doesnt exist to prevent crashing
		Song.loadFromJson(poop, songTarget.toLowerCase());
		if (PlayState.SONG != null) {
			if (FlxG.sound.music != null) {
				FlxG.sound.music.destroy();
				FlxG.sound.music = null;
			}
			
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.8);
			FlxG.sound.music.autoDestroy = true;

			Conductor.bpm = PlayState.SONG.bpm;
			Conductor.songPosition = 0;
		}
	}

	inline private function _updateSongLastDifficulty()
		currentSong.lastDifficulty = Difficulty.getString(difficulty, false);

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		difficultyText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		difficultyText.x -= difficultyText.width / 2;
	}

	override function destroy():Void {
		super.destroy();

		FlxG.autoPause = ClientPrefs.data.autoPause;
		if (!FlxG.sound.music.playing && !stopMusicPlay)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}	
}