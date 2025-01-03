package substates;

import haxe.Json;
import haxe.ds.Map;
import haxe.ds.StringMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxGradient;
import flixel.util.FlxTimer;
import flixel.util.FlxSort;
import flixel.addons.transition.FlxTransitionableState;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.utils.Assets;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.Paths;
import objects.StickerSprite;
import objects.StickerSprite.StickerInfo;
import objects.StickerSprite.StickerData;

class TransitionSubstate extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	var isTransIn:Bool = false;
    var isStickers:Bool = false;
    var stickersActive:Bool = false;

    // fade
	var transBlack:FlxSprite;
	var transGradient:FlxSprite;
	var duration:Float;

    // stickers
    private var stickerData:Array<StickerData> = [];
    private var stickerGroup:FlxTypedGroup<StickerSprite> = new FlxTypedGroup<StickerSprite>();
    var soundFolders:Array<String> = []; // what "folders" to potentially load from (as of writing only "keys" exist)
    var folder:String = ""; // what "folder" was randomly selected
    var sounds:Array<String> = [];

	public function new(duration:Float, isTransIn:Bool, isStickers:Bool, ?previousStickers:Array<StickerData>)
	{
		this.duration = duration;
		this.isTransIn = isTransIn;
        this.isStickers = 
            if (stickersActive) false // use the fade if there is already an active sticker transition (typically mid-removal)
            else isStickers;
		super();

        if (stickersActive) this.isStickers = false;
        if (!isStickers) return;

        stickerGroup = new FlxTypedGroup<StickerSprite>();
        add(stickerGroup);

        if (previousStickers != null) {
            for (idx => data in previousStickers) {
                // recreate the sticker arrangement from the previous data
                var sticker = new StickerSprite(data.x, data.y, data.set, data.name);
                sticker.angle = data.angle;
                sticker.scale.set(data.scale, data.scale);
                sticker.timing = data.timing;
                stickerGroup.add(sticker);
            }
        }
	}

	override function create()
	{
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length-1]];

        // fade
        if (!isStickers) {
            var width:Int = Std.int(FlxG.width / Math.max(camera.zoom, 0.001));
            var height:Int = Std.int(FlxG.height / Math.max(camera.zoom, 0.001));
            transGradient = FlxGradient.createGradientFlxSprite(1, height, (isTransIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
            transGradient.scale.x = width;
            transGradient.updateHitbox();
            transGradient.scrollFactor.set();
            transGradient.screenCenter(X);
            add(transGradient);

            transBlack = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
            transBlack.scale.set(width, height + 400);
            transBlack.updateHitbox();
            transBlack.scrollFactor.set();
            transBlack.screenCenter(X);
            add(transBlack);

            if (isTransIn)
                transGradient.y = transBlack.y - transBlack.height;
            else
                transGradient.y = -transGradient.height;
        }

        // stickers
        else {
            this.stickersActive = true;

            // check the folders that contain sticker sounds
            var folderSet = new StringMap<Bool>();
            for (asset in Assets.list()) {
                if (asset.startsWith('assets/shared/sounds/stickersounds/')) {
                    var folder = asset.replace('assets/shared/sounds/stickersounds/', '').split('/')[0];
                    folderSet.set(folder, true);
                }
            }
            soundFolders = [];
            for (folder in folderSet.keys()) {
                soundFolders.push(folder);
            }
            // trace('sound folders: ' + soundFolders);

            // get the sounds from a random folder
            folder = FlxG.random.getObject(soundFolders);
            sounds = Assets.list()
                .filter((a:String) -> a.startsWith('assets/shared/sounds/stickersounds/${folder}/'))
                .map((a:String) -> {
                    var filename = a.replace('assets/shared/sounds/', '');
                    return filename.substring(0, filename.lastIndexOf('.'));
                });

            stickerGroup.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

            // if theres no existing stickers, generate new ones
            if (!isTransIn) {
                createStickers();
                MusicBeatState.isStickerTransition = true;
            } else {
                removeStickers();
            }
        }

		super.create();
	}

    function createStickers():Void {
        // trace('creating stickers');

        if (stickerGroup.members.length > 0) {
            stickerGroup.clear();
        }

        var stickerInfo:StickerInfo = new StickerInfo('stickers-set-1');
        var stickers:Map<String, Array<String>> = new Map<String, Array<String>>();
        for (stickerSets in stickerInfo.getPack("all")) {
            stickers.set(stickerSets, stickerInfo.getStickers(stickerSets));
        }

        var xPos:Float = -100;
        var yPos:Float = -100;
        while (xPos <= FlxG.width) {
            var stickerKeys:Array<String> = [];
            for (key in stickers.keys()) {
                stickerKeys.push(key);
            }
            var stickerSet:String = FlxG.random.getObject(stickerKeys);
            var sticker:String = FlxG.random.getObject(stickers.get(stickerSet));
            var sticky:StickerSprite = new StickerSprite(0, 0, stickerInfo.name, sticker);
            sticky.visible = false;

            sticky.x = xPos;
            sticky.y = yPos;
            xPos += sticky.frameWidth * 0.5;

            if (xPos >= FlxG.width) {
                if (yPos <= FlxG.height) {
                    xPos = -100;
                    yPos += FlxG.random.float(70, 120);
                }
            }

            sticky.angle = FlxG.random.int(-60, 70);
            stickerGroup.add(sticky);
        }

        FlxG.random.shuffle(stickerGroup.members);

        for (idx => sticker in stickerGroup.members) {
            sticker.timing = FlxMath.remapToRange(idx, 0, stickerGroup.members.length, 0, 0.9);
            new FlxTimer().start(sticker.timing, _ -> {
                if (stickerGroup == null) return;
                var isLastSticker:Bool = idx == stickerGroup.members.length - 1;

                sticker.visible = true;
                var sfx:String = FlxG.random.getObject(sounds);
                FlxG.sound.play(Paths.sound(sfx));

                var frameTimer:Int = FlxG.random.int(0, 2);

                // always make the last one POP
                if (isLastSticker) frameTimer = 2;

                new FlxTimer().start((1 / 24) * frameTimer, _ -> {
                    if (sticker == null) return;

                    sticker.scale.x = sticker.scale.y = FlxG.random.float(0.97, 1.02);

                    if (isLastSticker) {
                        trace(stickerGroup.members.length + ' stickers loaded');
                        if (finishCallback != null) {
                            finishCallback();
                            finishCallback = null;
                        }
                    }
                });
            });
        }

        stickerGroup.sort((ord, a, b) -> {
            return FlxSort.byValues(ord, a.timing, b.timing);
        });

        // centers the very last sticker
        var lastOne:StickerSprite = stickerGroup.members[stickerGroup.members.length - 1];
        lastOne.updateHitbox();
        lastOne.angle = 0;
        lastOne.screenCenter();

        stickerData = [];
        for (sticker in stickerGroup.members) {
            // store the data for the out transition
            var data = new StickerData(
                sticker.x, 
                sticker.y, 
                sticker.angle, 
                sticker.scale.x,
                sticker.set,
                sticker.name,
                sticker.timing
            );

            stickerData.push(data);
        }
        MusicBeatState.stickerData = stickerData;
    }

    public function removeStickers():Void {
        trace('removing ${stickerGroup.length} stickers');
        MusicBeatState.isStickerTransition = false;

        // if theres no stickers... we're done here!
        if (stickerGroup.members == null || stickerGroup.members.length == 0) {
            trace('sticker group is null !!!');
            close();
            return;
        }

        for (idx => sticker in stickerGroup.members) {
            new FlxTimer().start(sticker.timing, _ -> {
                //trace('hiding sticker ${idx}. visibility: ${sticker.visible}');
                sticker.visible = false;
                var sfx:String = FlxG.random.getObject(sounds);
                FlxG.sound.play(Paths.sound(sfx));

                if (stickerGroup == null 
                || stickerGroup.members == null
                || idx == stickerGroup.members.length - 1) {
                    close();
                }
            });
        }
    }

	override function update(elapsed:Float) {
		super.update(elapsed);

        // no update logic to run for sticker variant
        if (isStickers) return;

        // fade gradient stuff
        final height:Float = FlxG.height * Math.max(camera.zoom, 0.001);
        final targetPos:Float = transGradient.height + 50 * Math.max(camera.zoom, 0.001);
        if (duration > 0)
            transGradient.y += (height + targetPos) * elapsed / duration;
        else
            transGradient.y = (targetPos) * elapsed;

        if (isTransIn)
            transBlack.y = transGradient.y + transGradient.height;
        else
            transBlack.y = transGradient.y - transBlack.height;

        if (transGradient.y >= targetPos)
        {
            close();
        }
	}

	// Don't delete this
	override function close():Void
	{
		super.close();

        if (isStickers) {
            remove(stickerGroup);
            stickerGroup.clear();
            this.stickersActive = false;
            return;
        }

		if (finishCallback != null)
		{
			finishCallback();
			finishCallback = null;
		}
	}
}