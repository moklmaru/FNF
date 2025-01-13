package menu.freeplay;

import gameplay.hud.HealthIcon;
import modding.Mods;

// this is a group for bundling together all the elements that compose an item in the freeplay song list
// was getting way too messy to sync all of this up otherwise
// this is effectively a more expansive refactor of the old SongMetaData class

@:access(menu.freeplay.FreeplayState)
class FreeplayListEntry extends FlxGroup 
{
    var index:Int = 0; // placement in the song list
    var weekIndex:Int = 0; // placement of the parent week in the current load

    public var name:String; // full name of the song, as a string
    var songName:Alphabet;
    var subTitle:Alphabet;
    var subOffset:FlxPoint = new FlxPoint(0, 0);

    var icon:HealthIcon;
    var iconLerp:Float;
    var iconOffset:FlxPoint = new FlxPoint(0, 0);

    var playerChar:String;
    var opponentChar:String;
    var color:FlxColor;

    var rank:FlxSprite; // to be added later
    var frame:FlxSprite; // to be added later

    var difficulties:Array<Int> = [];
    var lastDifficulty:String;

    var lerpIndex:Float = 0; // the index that the song will lerp to when the selection is changed
    var pos:FlxPoint = new FlxPoint(0, 0);
    var shown:Bool = false;

    var folder:String = '';

    var SCALE:Float = 0.4; // default scale for non-selected entries

	public function new(song:Array<Dynamic>, index:Int, weekIndex:Int)
	{
		super();

        this.index = index;
        this.lerpIndex = index;
        this.weekIndex = weekIndex;

        this.folder = Mods.currentModDirectory;
		if (this.folder == null) this.folder = '';

        // derive title / subtitle from name string
        this.name = song[0];
        var songText = name;
        var subText = '';
        var splitPoint = name.indexOf(' (');
        if (splitPoint > 0) {
            subText = name.substring(splitPoint, songText.length);
            songText = name.substring(0, splitPoint);
        }

        this.songName = new Alphabet(350, 320, songText, true);
        songName.targetY = index;
        songName.distancePerItem.y = 40;
        songName.snapToPosition();
        songName.setScale(songName.scaleX * SCALE, songName.scaleY * SCALE);
        songName.startPosition = new FlxPoint(songName.x, songName.y);
        this.pos = new FlxPoint(songName.x, songName.y);

        add(songName);

        if (subText != '') {
            this.subTitle = new Alphabet(300, 320, subText, true);
            subTitle.snapToPosition();
            subTitle.setScale(songName.scaleX * 0.75, songName.scaleY * 0.75);
            subTitle.startPosition = new FlxPoint(subTitle.x, subTitle.y);
            subTitle.color = FlxColor.fromRGB(220, 190, 120);
            subOffset = new FlxPoint(10, 30);

            add(subTitle);
        }

        // more assignment from the metadata
        this.playerChar = song[1];
        this.opponentChar = song[2];

        var rgb:Array<Int> = song[3];
        if (rgb == null || rgb.length < 3)
            rgb = [146, 113, 253]; // default background color
        this.color = FlxColor.fromRGB(rgb[0], rgb[1], rgb[2]);

        // character icon
        // note: we'll be tracking it to the text in this class rather than using the tracking updates in HealthIcon
        // just a matter of more localized control + less buggyness
        this.icon = new HealthIcon(opponentChar);
        icon.scale.scale(SCALE, SCALE);
        iconOffset = new FlxPoint(-(icon.width * 0.8), -60);
        icon.setPosition(pos.x + iconOffset.x, pos.y + iconOffset.y);

        add(icon);
	}

    // functions for tweening/animating the entrys as they come in/out of focus
    function setSelected() {
        FlxTween.tween(songName, { scaleX: 0.8, scaleY: 0.8 }, 0.2, { ease: FlxEase.quadInOut });
        FlxTween.tween(songName, {alpha: 1}, 0.2);
        if (subTitle != null) {
            FlxTween.tween(subTitle, { scaleX: 0.45, scaleY: 0.45 }, 0.2, { ease: FlxEase.quadInOut });
            FlxTween.tween(subTitle, {alpha: 1.0}, 0.2);
            FlxTween.tween(subOffset, { x: 6, y: 22 }, 0.2);
        }
        FlxTween.tween(icon.scale, { x: 1.0, y: 1.0 }, 0.2, { ease: FlxEase.elasticInOut });
        FlxTween.tween(icon, {alpha: 1}, 0.2);
        FlxTween.tween(iconOffset, { x: -icon.width, y: -50 }, 0.2);
    }
    function setDeselected() {
        FlxTween.tween(songName, { scaleX: SCALE, scaleY: SCALE }, 0.2, { ease: FlxEase.quadInOut });
        FlxTween.tween(songName, {alpha: 0.6}, 0.2);
        if (subTitle != null) {
            FlxTween.tween(subTitle, { scaleX: SCALE * 0.7, scaleY: SCALE * 0.7 }, 0.2, { ease: FlxEase.quadInOut });
            FlxTween.tween(subTitle, {alpha: 0.6}, 0.2);
            FlxTween.tween(subOffset, { x: 0, y: 7 }, 0.2);
        }
        FlxTween.tween(icon.scale, { x: 0.4, y: 0.4 }, 0.2, { ease: FlxEase.elasticInOut });
        FlxTween.tween(icon, {"alpha": 0.6}, 0.2);
        icon.angle = 0;
        FlxTween.tween(iconOffset, { x: -(icon.width * 0.8), y: -60 }, 0.2);
    }

    function show() {
        // trace('Showimg song: $name');
        songName.visible = songName.active = songName.isMenuItem = true;
        if (subTitle != null)
            subTitle.visible = subTitle.active = subTitle.isMenuItem = true;
        icon.visible = icon.active = true;

        this.shown = true;
    }
    function hide() {
        // trace('Hiding song: $name');
        songName.visible = songName.active = songName.isMenuItem = false;
        if (subTitle != null)
            subTitle.visible = subTitle.active = subTitle.isMenuItem = false;
        icon.visible = icon.active = false;

        this.shown = false;
    }

    // its time for some MATH boys !!!
    var DRAW_DISTANCE:Int = 7; // how far from the selected song that entrys will be visible
    override function update(elapsed:Float) {
        super.update(elapsed);
        songName.update(elapsed); // update the alphabet text
        icon.update(elapsed); // update the icon

        var currentIndex = FreeplayState.currentIndex;

        // this value is used for smooth positioning, as it will lerp between the 2 indexes being shifted between
        // it is a relative value shared between all entries as the list shifts
        lerpIndex = FlxMath.lerp(currentIndex, lerpIndex, Math.exp(-FlxG.elapsed * 9.6));

        // kill anything outside of the draw distance and bypass rest of the logic
        var min:Int = Math.round(FlxMath.bound(lerpIndex - DRAW_DISTANCE, 0, FreeplayState.songListLength)); 
        var max:Int = Math.round(FlxMath.bound(lerpIndex + DRAW_DISTANCE, 0, FreeplayState.songListLength)); 
		if (songName.targetY < min || songName.targetY > max) {
            if (shown) hide();
            return;
        }
            
        var selected = (currentIndex == index);

        // give a little extra wiggle room on either side of the selected song
        // this padding is relative to how close to the center the selction is (keeps it smooth)
        var delta = Math.abs(currentIndex - lerpIndex); // basically how big our current lerp is
        var diff = FlxMath.bound(30 * delta, 0, 30); // smaller the lerp, bigger the margin
        var dir = (lerpIndex < index) ? 1 : -1;
        var selectedMargin = if (!selected) (30 - diff) * dir else -15;

        var distance = songName.targetY - lerpIndex; // how far away from the selection this song is
        pos.x = (Math.pow(distance, 2) * songName.distancePerItem.x * 0.2) + songName.startPosition.x;
        pos.y = (distance * songName.distancePerItem.y * 1.3) + songName.startPosition.y + selectedMargin;
        songName.setPosition(pos.x, pos.y);

        if (subTitle != null) 
            subTitle.setPosition(pos.x + songName.width + subOffset.x, pos.y + subOffset.y);

        icon.setPosition(pos.x + iconOffset.x, pos.y + iconOffset.y);

        if (!shown) show();

        // handles lerping of the icon jammin out
        if (selected) {
            iconLerp = FlxMath.lerp(icon.angle, 0, 0.05);
            icon.angle = iconLerp;
        } 
    }
}
