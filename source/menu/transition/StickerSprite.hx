package menu.transition;

import haxe.ds.Map;
import openfl.utils.Assets;

// these are the fun lil stickers that pop onto the screen during certain transitions
class StickerSprite extends FlxSprite
{
    public var timing:Float = 0;
    public var set:String;
    public var name:String;

    public function new(x:Float, y:Float, stickerSet:String, stickerName:String):Void
    {
        super(x, y);
        loadGraphic(Paths.image('transitionSwag/${stickerSet}/${stickerName}'));
        updateHitbox();
        scrollFactor.set();
        this.set = stickerSet;
        this.name = stickerName;
        this.antialiasing = true;
    }
}

class StickerInfo
{
    public var name:String;
    public var artist:String;
    public var stickers:Map<String, Array<String>>;
    public var stickerPacks:Map<String, Array<String>>;

    public function new(stickerSet:String):Void {
        var path = Paths.getPath('images/transitionSwag/${stickerSet}/stickers.json');
        var json = Json.parse(Assets.getText(path));

        this.name = Reflect.field(json, "name");
        this.artist = Reflect.field(json, "artist");

        stickerPacks = new Map<String, Array<String>>();
        for (field in Reflect.fields(json.stickerPacks))
        {
            var info = Reflect.field(json.stickerPacks, field);
            stickerPacks.set(field, cast info);
        }

        stickers = new Map<String, Array<String>>();
        for (field in Reflect.fields(json.stickers))
        {
            var info = Reflect.field(json.stickers, field);
            stickers.set(field, cast info);
        }
    }

    public function getStickers(stickerName:String):Array<String> {
        return this.stickers[stickerName];
    }

    public function getPack(packName:String):Array<String> {
        return this.stickerPacks[packName];
    }
}

// data structure for storing information about the stickers across the two halves of the transition
class StickerData {
    public var x:Float;
    public var y:Float;
    public var angle:Float;
    public var scale:Float;
    public var set:String;
    public var name:String;
    public var timing:Float;

    public function new(x:Float, y:Float, angle:Float, scale:Float, set:String, name:String, timing:Float) {
        this.x = x;
        this.y = y;
        this.angle = angle;
        this.scale = scale;
        this.set = set;
        this.name = name;
        this.timing = timing;
    }
}