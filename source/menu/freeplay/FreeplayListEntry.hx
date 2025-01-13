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
        songName.distancePerItem.y = 35;
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

    // tweens/animates the entrys as they come in/out of focus
    function setSelected(selected:Bool) {
        var TIMING = 0.2; // how long the tween should take
        var songScale = if (selected) 0.8 else SCALE;
        var subScale = if (selected) 0.45 else SCALE * 0.7;
        var subPos =
            if (selected) new FlxPoint(6, 22)
            else new FlxPoint(0, 7);
        var iconScale = if (selected) 1.0 else 0.4;
        var iconPos =
            if (selected) new FlxPoint(-icon.width, -50)
            else new FlxPoint(-(icon.width * 0.8), -60);
        var alpha = if (selected) 1.0 else 0.6;

        FlxTween.tween(songName, { scaleX: songScale, scaleY: songScale }, TIMING, { ease: FlxEase.quadInOut });
        FlxTween.tween(songName, {alpha: alpha}, TIMING);
        if (subTitle != null) {
            FlxTween.tween(subTitle, { scaleX: subScale, scaleY: subScale }, TIMING, { ease: FlxEase.quadInOut });
            FlxTween.tween(subTitle, {alpha: alpha}, TIMING);
            FlxTween.tween(subOffset, { x: subPos.x, y: subPos.y }, TIMING);
        }
        FlxTween.tween(icon.scale, { x: iconScale, y: iconScale }, TIMING, { ease: FlxEase.elasticInOut });
        FlxTween.tween(icon, {alpha: alpha}, TIMING);
        FlxTween.tween(iconOffset, { x: iconPos.x, y: iconPos.y }, TIMING);
        if (!selected) icon.angle = 0; // halt the jamming...
    }

    function setVisible(bool:Bool) {
        songName.visible = songName.active = songName.isMenuItem = bool;
        if (subTitle != null)
            subTitle.visible = subTitle.active = subTitle.isMenuItem = bool;
        icon.visible = icon.active = bool;

        this.shown = bool;
    }
    function show() setVisible(true);
    function hide() setVisible(false);

    // its time for some MATH boys !!!
    var DRAW_DISTANCE:Int = 7; // how far from the selected song that entrys will be visible
    override function update(elapsed:Float) {
        super.update(elapsed);
        songName.update(elapsed); // update the alphabet text

        var currentIndex = FreeplayState.currentIndex;
        var selected = (currentIndex == index);

        // this value is used for smooth transitioning, as it will lerp between the 2 song items being shifted between
        // it is a universal value shared between all entries as the list shifts
        lerpIndex = FlxMath.lerp(currentIndex, lerpIndex, Math.exp(-FlxG.elapsed * 9.6));

        // kill anything outside of the draw distance and bypass rest of the logic
        var min:Int = Math.round(FlxMath.bound(lerpIndex - DRAW_DISTANCE, 0, FreeplayState.songListLength)); 
        var max:Int = Math.round(FlxMath.bound(lerpIndex + DRAW_DISTANCE, 0, FreeplayState.songListLength)); 
		if (songName.targetY < min || songName.targetY > max) {
            if (shown) hide();
            return;
        }

        // give a little extra wiggle room on either side of the selected song
        // this padding is relative to how close to the center the selction is (keeps it smooth)
        var delta = Math.abs(currentIndex - lerpIndex); // basically how big our current lerp is
        var diff = FlxMath.bound(30 * delta, 0, 30); // smaller the lerp, bigger the margin!
        var dir = (lerpIndex < index) ? 1 : -1;
        var selectedMargin = if (!selected) (30 - diff) * dir else -15;
        var distance = songName.targetY - lerpIndex; // how far away from the selection this song is

        // additional padding based on the week index. makes them appear in groups!
        selectedMargin += (weekIndex - FreeplayState.currentWeek) * 25;

        // not worth explaining these calcs in detail but it makes for a pretty circle formation
        pos.x = (Math.pow(distance, 2) * songName.distancePerItem.x * 0.2) + songName.startPosition.x;
        pos.y = (distance * songName.distancePerItem.y * 1.3) + songName.startPosition.y + selectedMargin;
        songName.setPosition(pos.x, pos.y);
        icon.setPosition(pos.x + iconOffset.x, pos.y + iconOffset.y);
        if (subTitle != null) // only update subtitle if it exists
            subTitle.setPosition(pos.x + songName.width + subOffset.x, pos.y + subOffset.y);

        if (!shown) show();

        // handles lerping of the icon jammin out to the beat
        if (selected) {
            iconLerp = FlxMath.lerp(icon.angle, 0, 0.05);
            icon.angle = iconLerp;
        } 
    }
}
